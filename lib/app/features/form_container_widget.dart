// import 'package:flutter/material.dart';

// class FormContainerWidget extends StatefulWidget {
//   final TextEditingController? controller;
//   final Key? fieldKey;
//   final bool? isPasswordField;
//   final String? hintText;
//   final String? labelText;
//   final String? helperText;
//   final FormFieldSetter<String>? onSaved;
//   final FormFieldValidator<String>? validator;
//   final ValueChanged<String>? onFieldSubmitted;
//   final TextInputType? inputType;

//   const FormContainerWidget(
//       {this.controller,
//       this.isPasswordField,
//       this.fieldKey,
//       this.hintText,
//       this.labelText,
//       this.helperText,
//       this.onSaved,
//       this.validator,
//       this.onFieldSubmitted,
//       this.inputType});

//   @override
//   _FormContainerWidgetState createState() => _FormContainerWidgetState();
// }

// class _FormContainerWidgetState extends State<FormContainerWidget> {
//   bool _obscureText = true;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 100,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(10),
//       ),
//       child: TextFormField(
//         controller: widget.controller,
//         keyboardType: widget.inputType,
//         key: widget.fieldKey,
//         obscureText: widget.isPasswordField == true ? _obscureText : false,
//         onSaved: widget.onSaved,
//         validator: widget.validator,
//         onFieldSubmitted: widget.onFieldSubmitted,
//         decoration: InputDecoration(
//             hintText: widget.hintText,
//             // labelText: widget.labelText,
//             // helperText: widget.helperText,
//             suffixIcon: GestureDetector(
//               onTap: () {
//                 setState(() {
//                   _obscureText = !_obscureText;
//                 });
//               },
//               child: widget.isPasswordField == true
//                   ? Icon(_obscureText ? Icons.visibility_off : Icons.visibility)
//                   : null,
//             )),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

class FormContainerWidget extends StatefulWidget {
  const FormContainerWidget({
    super.key,
    required this.labelText,
    required this.controller,
    this.textInputType,
    this.validateInputBox,
    required this.isPasswordField,
  });

  final String labelText;
  final TextEditingController controller;
  final TextInputType? textInputType;
  final FormFieldValidator<String>? validateInputBox;
  final bool isPasswordField;

  @override
  State<FormContainerWidget> createState() => _FormContainerWidgetState();
}

class _FormContainerWidgetState extends State<FormContainerWidget> {
  bool _isHidden = true;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
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
                onTap: _togglePasswordView,
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
