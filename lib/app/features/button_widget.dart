import 'package:donative/app/features/toast.dart';
import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final VoidCallback onTap;
  final String buttonText;
  final String? toastMessage;

  const ButtonWidget({
    super.key,
    required this.onTap,
    required this.buttonText,
    this.toastMessage,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap();
        showToast(
          message: toastMessage!,
          context: context,
        );
      },
      child: Container(
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Theme.of(context).colorScheme.primaryContainer,
        ),
        child: Center(
          child: Text(
            buttonText,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
      ),
    );
  }
}
