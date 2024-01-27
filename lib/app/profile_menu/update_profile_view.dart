import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donative/app/features/form_container_widget.dart';
import 'package:donative/app/features/toast.dart';
import 'package:donative/app/features/button_widget.dart';
import 'package:donative/app/utils/pickImageUtility.dart';
import 'package:donative/views/profile_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

final _profileKey = GlobalKey<FormState>();

class UpdateProfile extends StatefulWidget {
  const UpdateProfile({super.key});

  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  String? _profilePicUrl;
  Uint8List? _image;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String userId = FirebaseAuth.instance.currentUser!.uid;

  Future<String> saveImage({required Uint8List file}) async {
    try {
      String imageUrl = await (String childName, Uint8List file) async {
        try {
          Reference ref = _storage.ref().child(childName);
          UploadTask uploadTask = ref.putData(file);
          TaskSnapshot snapshot = await uploadTask;
          String downloadUrl = await snapshot.ref.getDownloadURL();
          return downloadUrl;
        } catch (error) {
          showToast(message: 'Error uploading image to storage: $error');
          throw error;
        }
      }('profileImage_$userId', file);

      await _firestore.collection('users').doc(userId).update({
        'profilePic': imageUrl,
      });

      return "Success";
    } catch (error) {
      showToast(message: 'Error saving image to Server: $error');
      return "Some Error Occurred: $error";
    }
  }

  void selectImage() async {
    Uint8List img = await pickImage(ImageSource.gallery);
    setState(() {
      _image = img;
    });
  }

  void saveProfile() async {
    String resp = await saveImage(file: _image!);
    showToast(message: resp);
  }

  bool isEditingEnabled = false;
  DateTime? _dateTime;

  void _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2050),
    ).then((value) {
      setState(() {
        _dateTime = value!;
      });
    });
  }

  void toggleEditing() {
    setState(() {
      isEditingEnabled = !isEditingEnabled;
    });
  }

  final List<String> genderTypeList = ['Male', 'Female', 'Others'];

  String genderType = "";

  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _addressController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchUserDataFromFirebase();
  }

  void fetchUserDataFromFirebase() async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    String userId = FirebaseAuth.instance.currentUser!.uid;
    DocumentSnapshot userSnapshot = await users.doc(userId).get();

    setState(() {
      _firstNameController.text = userSnapshot['firstName'] ?? '';
      _lastNameController.text = userSnapshot['lastName'] ?? '';
      _emailController.text = userSnapshot['email'] ?? '';
      _phoneController.text = userSnapshot['phone'] ?? '';
      _dateTime = userSnapshot['dob']?.toDate();
      genderType = userSnapshot['gender'] ?? '';
      _addressController.text = userSnapshot['address'] ?? '';
      _profilePicUrl = userSnapshot['profilePic'];
    });
  }

  @override
  Widget build(BuildContext context) {
    DateFormat dateFormat = DateFormat('dd-MM-yyyy');
    String formattedDate =
        _dateTime != null ? dateFormat.format(_dateTime!) : "Date of Birth";

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.onPrimary,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        title: const Text(
          "Personal Information",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _profileKey,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        _image != null
                            ? CircleAvatar(
                                radius: 65,
                                backgroundImage: MemoryImage(_image!),
                              )
                            : _profilePicUrl != null
                                ? CircleAvatar(
                                    radius: 60,
                                    backgroundImage: NetworkImage(
                                      _profilePicUrl!,
                                    ),
                                  )
                                : const CircleAvatar(
                                    radius: 60,
                                    backgroundImage: NetworkImage(
                                        "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png")),
                        Positioned(
                          bottom: -15,
                          left: 70,
                          child: IconButton(
                              onPressed: selectImage,
                              icon: const Icon(
                                Icons.add_a_photo,
                                size: 30,
                              )),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Text(
                          "Update Profile",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        const SizedBox(width: 10),
                        CircleAvatar(
                          radius: 20,
                          child: IconButton(
                              onPressed: toggleEditing,
                              icon: Icon(
                                  isEditingEnabled ? Icons.save : Icons.edit)),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: FormContainerWidget(
                              labelText: "First Name",
                              controller: _firstNameController,
                              isPasswordField: false,
                              textInputType: TextInputType.name,
                              isEnabled: isEditingEnabled,
                              onEnabledChanged: (value) {
                                setState(() {
                                  isEditingEnabled = value;
                                });
                              }),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: FormContainerWidget(
                              labelText: "Last Name",
                              controller: _lastNameController,
                              isPasswordField: false,
                              textInputType: TextInputType.name,
                              isEnabled: isEditingEnabled,
                              onEnabledChanged: (value) {
                                setState(() {
                                  isEditingEnabled = value;
                                });
                              }),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    FormContainerWidget(
                        labelText: "Email Address",
                        controller: _emailController,
                        isPasswordField: false,
                        textInputType: TextInputType.emailAddress,
                        isEnabled: isEditingEnabled,
                        onEnabledChanged: (value) {
                          setState(() {
                            isEditingEnabled = value;
                          });
                        }),
                    const SizedBox(
                      height: 10,
                    ),
                    FormContainerWidget(
                        labelText: "Phone Number",
                        controller: _phoneController,
                        isPasswordField: false,
                        textInputType: TextInputType.phone,
                        isEnabled: isEditingEnabled,
                        onEnabledChanged: (value) {
                          setState(() {
                            isEditingEnabled = value;
                          });
                        }),
                    const SizedBox(
                      height: 10,
                    ),
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 6, 10, 6),
                        child: MaterialButton(
                          onPressed: _showDatePicker,
                          child: Row(
                            children: [
                              const Icon(Icons.calendar_today),
                              const SizedBox(width: 8),
                              Text(formattedDate)
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Card(
                      color: Theme.of(context).colorScheme.surface,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(15, 6, 10, 6),
                        child: SizedBox(
                          width: double.infinity,
                          child: DropdownButton(
                            hint: const Text("Gender"),
                            value: genderType.isNotEmpty ? genderType : null,
                            items: genderTypeList
                                .map((e) =>
                                    DropdownMenuItem(value: e, child: Text(e)))
                                .toList(),
                            onChanged: (String? value) {
                              setState(() {
                                genderType = value ?? "";
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    FormContainerWidget(
                        labelText: "Address",
                        controller: _addressController,
                        isPasswordField: false,
                        textInputType: TextInputType.streetAddress,
                        isEnabled: isEditingEnabled,
                        onEnabledChanged: (value) {
                          setState(() {
                            isEditingEnabled = value;
                          });
                        }),
                    const SizedBox(
                      height: 15,
                    ),
                    ButtonWidget(
                        onTap: () {
                          saveProfile();
                          CollectionReference users =
                              FirebaseFirestore.instance.collection('users');

                          String userId =
                              FirebaseAuth.instance.currentUser!.uid;

                          users.doc(userId).update({
                            'firstName': _firstNameController.text,
                            'lastName': _lastNameController.text,
                            'email': _emailController.text,
                            'phone': _phoneController.text,
                            'dob': _dateTime,
                            'gender': genderType,
                            'address': _addressController.text,
                            // Add other fields as needed
                          }).then((value) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const ProfilePage()),
                            );
                            showToast(message: 'Profile updated successfully!');
                          }).catchError((error) {
                            showToast(
                                message: 'Failed to update profile: $error');
                          });
                        },
                        buttonText: "Update Profile"),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
