import 'package:donative/app/features/form_container_widget.dart';
import 'package:donative/app/user_auth/button_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

final _profileKey = GlobalKey<FormState>();

class UpdateProfile extends StatefulWidget {
  const UpdateProfile({super.key});

  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
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
                    Icon(CupertinoIcons.person_crop_circle_fill,
                        size: 100, color: Colors.grey[400]),
                    const Text(
                      "Update Profile",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
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
                              textInputType: TextInputType.name),
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
                          ),
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
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    FormContainerWidget(
                      labelText: "Phone Number",
                      controller: _phoneController,
                      isPasswordField: false,
                      textInputType: TextInputType.phone,
                    ),
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
                    ),
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
