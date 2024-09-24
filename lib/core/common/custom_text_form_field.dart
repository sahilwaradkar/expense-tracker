import 'package:assignment/core/constant/colors.dart';
import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String? Function(String?)? validator;
  final bool? obscureText;
  final String hintText;
  final IconButton? suffixIcon;
  final TextEditingController? textController;
  const CustomTextFormField({
    super.key,
    this.validator,
    this.obscureText,
    required this.hintText,
    this.textController,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
      child: TextFormField(
        controller: textController,
        obscureText: obscureText ?? false,
        validator: validator,
        decoration: InputDecoration(

            suffixIcon: suffixIcon,
            contentPadding: EdgeInsets.all(20),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(color: AppColors.grey.withOpacity(0.2)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(color: AppColors.grey.withOpacity(0.2)),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(color: AppColors.red.withOpacity(0.8)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(color: AppColors.grey),
            ),
            hintText: hintText,
            hintStyle: TextStyle(
              color: AppColors.grey,
            )),
        style: TextStyle(
            color: Theme.of(context).brightness == Brightness.light ? AppColors.black : AppColors.white
        ),
      ),
    );
  }
}
