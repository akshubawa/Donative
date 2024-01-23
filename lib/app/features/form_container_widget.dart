import 'package:flutter/material.dart';

class FormContainerWidget extends StatefulWidget {
  const FormContainerWidget({
    super.key,
    required this.labelText,
    required this.controller,
    this.textInputType,
    this.validateInputBox,
    required this.isPasswordField,
    this.isEnabled,
    this.isEditing,
    this.onEnabledChanged,
  });

  final String labelText;
  final TextEditingController controller;
  final TextInputType? textInputType;
  final FormFieldValidator<String>? validateInputBox;
  final bool isPasswordField;
  final bool? isEnabled;
  final bool? isEditing;
  final ValueChanged<bool>? onEnabledChanged;

  @override
  State<FormContainerWidget> createState() => _FormContainerWidgetState();
}

class _FormContainerWidgetState extends State<FormContainerWidget> {
  bool _isEditing = false;
  bool _isHidden = true;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: widget.isEnabled,
      controller: widget.controller,
      keyboardType: widget.textInputType,
      obscureText: widget.isPasswordField == true ? _isHidden : false,
      decoration: InputDecoration(
        labelText: widget.labelText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        suffix: widget.isPasswordField
            ? InkWell(
                onTap: () {
                  _togglePasswordView;
                },
                child: widget.isPasswordField == true
                    ? Icon(_isHidden ? Icons.visibility_off : Icons.visibility)
                    : null,
              )
            : null,
      ),
      validator: widget.validateInputBox,
      autovalidateMode: AutovalidateMode.onUserInteraction,
    );
  }

  void _togglePasswordView() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }
}
