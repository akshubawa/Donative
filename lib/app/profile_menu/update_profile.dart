import 'dart:typed_data';

import 'package:donative/app/features/form_container_widget.dart';
import 'package:donative/app/user_auth/button_widget.dart';
import 'package:donative/app/utils/utils.dart';
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
  void selectImage() async {
    Uint8List img = await pickImage(ImageSource.gallery);
  }

  bool isEditingEnabled = false;
  DateTime? _dateTime;

  void _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2023),
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

  @override
  void initState() {
    super.initState();
    _dateTime = null;
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
                        const CircleAvatar(
                          radius: 55,
                          backgroundImage: NetworkImage(
                              'https://img.freepik.com/free-vector/businessman-character-avatar-isolated_24877-60111.jpg?w=826&t=st=1705998704~exp=1705999304~hmac=94f210261e42c097bd53ad820556661109367d43ab094dc983e7d943a3b0693e'),
                        ),
                        Positioned(
                          bottom: -10,
                          left: 65,
                          child: IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.add_a_photo)),
                        ),
                      ],
                    ),

                    // Icon(CupertinoIcons.person_crop_circle_fill,
                    //     size: 100, color: Colors.grey[400]),
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
                      height: 15,
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
                        controller: _phoneController,
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
                    ButtonWidget(onTap: () {}, buttonText: "Update Profile"),
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
