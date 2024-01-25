import 'package:donative/app/features/button_widget.dart';
import 'package:donative/app/features/form_container_widget.dart';
import 'package:donative/app/features/toast.dart';
import 'package:donative/views/profile_page.dart';
import 'package:emailjs/emailjs.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

final _contactUsKey = GlobalKey<FormState>();

class ContactUsView extends StatefulWidget {
  const ContactUsView({super.key});

  @override
  State<ContactUsView> createState() => _ContactUsViewState();
}

class _ContactUsViewState extends State<ContactUsView> {
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _subjectController = TextEditingController();
  final _messageController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _subjectController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  String? validateInputBox(String? value) {
    if (value!.isEmpty) {
      return 'This field is required';
    }
    return null;
  }

  Future sendEmail() async {
    Map<String, dynamic> templateParams = {
      "user_name": _nameController.text,
      "user_email": _emailController.text,
      "user_phone": _phoneController.text,
      "user_subject": _subjectController.text,
      "user_message": _messageController.text,
    };

    try {
      await EmailJS.send(
        'service_601pvwc',
        'template_wjhp766',
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

  _launchURL() async {
    final Uri url = Uri.parse('https://wa.me/+918439944224');
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.onPrimary,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        title: const Text(
          "Contact Us",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _contactUsKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                Text(
                  "We would love to hear from you!",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Theme.of(context).colorScheme.primary),
                ),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.fromLTRB(18, 0, 18, 0),
                  child: Text(
                    "Please get in touch and our experts will get back to you as soon as possible.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color:
                            Theme.of(context).colorScheme.onPrimaryContainer),
                  ),
                ),
                const SizedBox(height: 30),
                FormContainerWidget(
                  labelText: "Enter your Name",
                  controller: _nameController,
                  isPasswordField: false,
                  textInputType: TextInputType.name,
                  validateInputBox: validateInputBox,
                ),
                const SizedBox(height: 15),
                FormContainerWidget(
                  labelText: "Mobile Number",
                  controller: _phoneController,
                  isPasswordField: false,
                  textInputType: TextInputType.number,
                  validateInputBox: validateInputBox,
                ),
                const SizedBox(height: 15),
                FormContainerWidget(
                  labelText: "Email Address",
                  controller: _emailController,
                  isPasswordField: false,
                  textInputType: TextInputType.emailAddress,
                  validateInputBox: validateInputBox,
                ),
                const SizedBox(height: 15),
                FormContainerWidget(
                  labelText: "Subject Line",
                  controller: _subjectController,
                  isPasswordField: false,
                  textInputType: TextInputType.text,
                  validateInputBox: validateInputBox,
                ),
                const SizedBox(height: 15),
                FormContainerWidget(
                  labelText: "Message",
                  controller: _messageController,
                  isPasswordField: false,
                  textInputType: TextInputType.text,
                  validateInputBox: validateInputBox,
                ),
                const SizedBox(height: 15),
                ButtonWidget(
                  onTap: () {
                    if (_contactUsKey.currentState != null &&
                        _contactUsKey.currentState!.validate()) {
                      sendEmail().then((value) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ProfilePage()),
                        );
                        showToast(
                            message: "Message sent successfully",
                            context: context);
                      });
                    } else {
                      showToast(
                          message: "Please fill all the required fields",
                          context: context);
                    }
                  },
                  buttonText: "Send Message",
                ),
                const SizedBox(height: 8),
               
                Text(
                  "OR",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.w300,
                      fontSize: 14,
                      color: Theme.of(context).colorScheme.onPrimaryContainer),
                ),
                const SizedBox(height: 8),
                GestureDetector(
                  onTap: () {
                    _launchURL();
                  },
                  child: Container(
                    width: double.infinity,
                    height: 50,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: const Color(0xFF4FCE5D),
                      ),
                      borderRadius: BorderRadius.circular(10),
                      color: Theme.of(context).colorScheme.surface,
                    ),
                    child: const Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            FontAwesomeIcons.whatsapp,
                            color: Color(0xFF4FCE5D),
                          ),
                          SizedBox(width: 10),
                          Text(
                            "Whatsapp",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Color(0xFF4FCE5D),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
