import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donative/app/features/button_widget.dart';
import 'package:donative/app/features/form_container_widget.dart';
import 'package:donative/app/features/toast.dart';
import 'package:donative/app/user_auth/database_methods.dart';
import 'package:donative/app/utils/pickImageUtility.dart';
import 'package:donative/views/home_screen.dart';
import 'package:emailjs/emailjs.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

final _addFundraiserKey = GlobalKey<FormState>();

class AddFundraiserView extends StatefulWidget {
  const AddFundraiserView({super.key});

  @override
  State<AddFundraiserView> createState() => _AddFundraiserViewState();
}

class _AddFundraiserViewState extends State<AddFundraiserView> {
  String? _patientImageUrl;
  Uint8List? _image;
  String fundraiserId =
      FirebaseFirestore.instance.collection('fundraisers').doc().id;

  final FirebaseStorage _storage = FirebaseStorage.instance;
  String userId = FirebaseAuth.instance.currentUser!.uid;

  final _initiatorNameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _totalAmountController = TextEditingController();
  final _patientImageController = TextEditingController();
  final _hospitalNameController = TextEditingController();
  final _addressController = TextEditingController();
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _initiatorNameController.dispose();
    _titleController.dispose();
    _descriptionController.dispose();
    _phoneController.dispose();
    _totalAmountController.dispose();
    _patientImageController.dispose();
    _hospitalNameController.dispose();
    _addressController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  String? validateInputBox(String? value) {
    if (value!.isEmpty) {
      return 'This field is required';
    }
    return null;
  }

  Future<String> saveImage({required Uint8List file}) async {
    try {
      String imageName = DateTime.now().millisecondsSinceEpoch.toString();
      Reference ref = _storage.ref().child('fundraiserImages/$imageName.jpg');
      UploadTask uploadTask = ref.putData(file);
      TaskSnapshot snapshot = await uploadTask;
      String downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (error) {
      showToast(message: 'Error uploading image to storage: $error');
      throw error;
    }
  }

  void selectImage() async {
    Uint8List img = await pickImage(ImageSource.gallery);
    setState(() {
      _image = img;
    });
  }

  void savePic() async {
    String resp = await saveImage(file: _image!);
    showToast(message: resp);
  }

  uploadFundraisersData() async {
    String imageUrl = await saveImage(file: _image!);
    double totalAmount = double.parse(_totalAmountController.text);
    Map<String, dynamic> fundraisersData = {
      "title": _titleController.text,
      "description": _descriptionController.text,
      "initiator": _initiatorNameController.text,
      "image": imageUrl,
      "raisedAmount": 0,
      "totalAmount": totalAmount,
      "hospitalName": _hospitalNameController.text,
      "mobileNumber": _phoneController.text,
      "address": _addressController.text,
      "uid": FirebaseAuth.instance.currentUser!.uid,
      "createdAt": DateTime.now().millisecondsSinceEpoch.toString(),
      "isApproved": false,
      "email": _emailController.text,
      "fundraiserId": fundraiserId,
    };
    DatabaseMethods().addFundraisers(fundraisersData);
  }

  sendEmail() async {
    String imageUrl = await saveImage(file: _image!);
    double totalAmount = double.parse(_totalAmountController.text);

    Map<String, dynamic> templateParams = {
      "title": _titleController.text,
      "description": _descriptionController.text,
      "initiator": _initiatorNameController.text,
      "image": imageUrl,
      "totalAmount": totalAmount,
      "hospitalName": _hospitalNameController.text,
      "mobileNumber": _phoneController.text,
      "address": _addressController.text,
      "email": _emailController.text,
      "fundraiserId": fundraiserId,
    };

    try {
      await EmailJS.send(
        'service_601pvwc',
        'template_b6rx0c9',
        templateParams,
        const Options(
          publicKey: 'hzeDuuyqZ7Y2_OaIz',
          privateKey: '5OnaUwcfT3sfAyEgUno5k',
        ),
      );
      print('SUCCESS!');
    } catch (error) {
      print(error.toString());
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _patientImageUrl = FirebaseAuth.instance.currentUser!.photoURL;
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.onPrimary,
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
          title: const Text(
            "Add Fundraiser",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        body: Container(
            padding: const EdgeInsets.all(16),
            child: Form(
                key: _addFundraiserKey,
                child: SingleChildScrollView(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                      const SizedBox(height: 20),
                      Text(
                        "Raise your Funds now!",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Theme.of(context).colorScheme.primary),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        padding: const EdgeInsets.fromLTRB(18, 0, 18, 0),
                        child: Text(
                          "At Donative, we value transparency and are commited to providing a seamless and postive experience for all of our users.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              color: Theme.of(context)
                                  .colorScheme
                                  .onPrimaryContainer),
                        ),
                      ),
                      const SizedBox(height: 30),
                      FormContainerWidget(
                        labelText: "Initiator's Name",
                        controller: _initiatorNameController,
                        isPasswordField: false,
                        textInputType: TextInputType.name,
                        validateInputBox: validateInputBox,
                      ),
                      const SizedBox(height: 15),
                      FormContainerWidget(
                        labelText: "Title of Funding",
                        controller: _titleController,
                        isPasswordField: false,
                        textInputType: TextInputType.text,
                        validateInputBox: validateInputBox,
                      ),
                      const SizedBox(height: 15),
                      FormContainerWidget(
                        labelText: "Description",
                        controller: _descriptionController,
                        isPasswordField: false,
                        textInputType: TextInputType.emailAddress,
                        validateInputBox: validateInputBox,
                      ),
                      const SizedBox(height: 15),
                      GestureDetector(
                        onTap: () {
                          selectImage();
                        },
                        child: Stack(
                          children: [
                            _image != null
                                ? Container(
                                    width: 130,
                                    height: 130,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.rectangle,
                                      image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: MemoryImage(_image!),
                                      ),
                                    ),
                                  )
                                : _patientImageUrl != null
                                    ? Container(
                                        width: 120,
                                        height: 120,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.rectangle,
                                          image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image:
                                                NetworkImage(_patientImageUrl!),
                                          ),
                                        ),
                                      )
                                    : Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height: 180,
                                        decoration: BoxDecoration(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onInverseSurface,
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          image: const DecorationImage(
                                            fit: BoxFit.contain,
                                            image: AssetImage(
                                                "assets/add_image_icon.png"),
                                          ),
                                        ),
                                      ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      FormContainerWidget(
                        labelText: "Contact Number",
                        controller: _phoneController,
                        isPasswordField: false,
                        textInputType: TextInputType.phone,
                        validateInputBox: validateInputBox,
                      ),
                      const SizedBox(height: 15),
                      FormContainerWidget(
                        labelText: "Email Address",
                        controller: _emailController,
                        isPasswordField: false,
                        textInputType: TextInputType.text,
                        validateInputBox: validateInputBox,
                      ),
                      const SizedBox(height: 15),
                      FormContainerWidget(
                        labelText: "Total Amount Required",
                        controller: _totalAmountController,
                        isPasswordField: false,
                        textInputType: TextInputType.text,
                        validateInputBox: validateInputBox,
                      ),
                      const SizedBox(height: 15),
                      FormContainerWidget(
                        labelText: "Hospital Name",
                        controller: _hospitalNameController,
                        isPasswordField: false,
                        textInputType: TextInputType.text,
                        validateInputBox: validateInputBox,
                      ),
                      const SizedBox(height: 15),
                      FormContainerWidget(
                        labelText: "Address",
                        controller: _addressController,
                        isPasswordField: false,
                        textInputType: TextInputType.text,
                        validateInputBox: validateInputBox,
                      ),
                      const SizedBox(height: 15),
                      Text(
                        "NOTE: Your fundraiser will be reviewed by our team and will be approved within 24 hours.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: Theme.of(context).colorScheme.secondary),
                      ),
                      const SizedBox(height: 15),
                      ButtonWidget(
                        onTap: () {
                          if (_addFundraiserKey.currentState != null &&
                              _addFundraiserKey.currentState!.validate()) {
                            savePic();
                            uploadFundraisersData().then((value) {
                              sendEmail();
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const HomeScreen()),
                              );
                              showToast(
                                  message:
                                      "Fundraiser request sent successfully",
                                  context: context);
                            });
                          } else {
                            showToast(
                                message: "Please fill all the required fields",
                                context: context);
                          }
                        },
                        buttonText: "Add Fundraiser",
                      ),
                      const SizedBox(height: 50),
                    ])))));
  }
}
