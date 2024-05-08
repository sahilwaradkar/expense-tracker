import 'package:assignment/bottom_nav_bar.dart';
import 'package:assignment/core/constant/colors.dart';
import 'package:assignment/core/constant/image_resource.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool termsNConditions = false;
  bool isPasswordVisible = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Sign Up',
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 40,
            ),
            CustomTextFormField(
              hintText: 'Name',
            ),
            CustomTextFormField(
              hintText: 'Email',
            ),
            CustomTextFormField(
              hintText: 'Password',
              obscureText: isPasswordVisible,
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    isPasswordVisible = !isPasswordVisible;
                  });
                },
                icon: Icon(
                  isPasswordVisible
                      ? Icons.visibility
                      : Icons.visibility_off, color: AppColors.grey,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                children: [
                  Checkbox(
                    checkColor: AppColors.white,
                    activeColor: AppColors.primary,
                    side: BorderSide(
                      color: AppColors.primary,
                    ),
                    value:
                        termsNConditions, // A boolean variable to manage the checkbox state
                    onChanged: (newValue) {
                      setState(() {
                        termsNConditions = newValue!;
                      });
                    },
                  ),
                  Flexible(
                    // child: Text(
                    //   "By signing up, you agree to the Terms of Service and Privacy Policy",
                    //   style: TextStyle(
                    //     color: AppColors.black,
                    //     fontSize: 14,
                    //     fontWeight: FontWeight.w400,
                    //   ),
                    // ),
                    child: Text.rich(
                      TextSpan(
                        text: 'By signing up, you agree to the ',
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Terms of Service and Privacy Policy',
                            style: TextStyle(
                                color: AppColors
                                    .primary, // Change color to blue or any other color you prefer
                                fontWeight: FontWeight.w500,
                                fontSize: 14),
                          ),
                        ],
                        style: TextStyle( color: Theme.of(context).brightness == Brightness.light ? AppColors.black : AppColors.grey,
                            fontWeight: FontWeight.w500, fontSize: 14),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            CustomElevatedButton(child: Text(
              'Sign Up',
              style: TextStyle(
                  color: AppColors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600),
            ),onPressed: () => Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => BottomNavBar())),),
            Text(
              'Or with',
              style:
                  TextStyle(color: AppColors.grey, fontWeight: FontWeight.w700),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: AppColors.grey.withOpacity(0.2))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(ImageResource.googleIcon),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Sign Up with Google',
                      style:
                          TextStyle(fontWeight: FontWeight.w600, color: Theme.of(context).brightness == Brightness.light ? AppColors.black : AppColors.white, fontSize: 18),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text.rich(
              TextSpan(
                text: 'Already have an account? ',
                children: <TextSpan>[
                  TextSpan(
                    text: 'Login',
                    style: TextStyle(
                        color: AppColors
                            .primary, // Change color to blue or any other color you prefer
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        decoration: TextDecoration.underline, decorationColor: AppColors.primary),
                  ),
                ],
                style: TextStyle(
                    color: AppColors.grey,
                    fontWeight: FontWeight.w500,
                    fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomElevatedButton extends StatelessWidget {
  final Widget child;
  final Color? backgroundColor;
  final VoidCallback? onPressed;
  const CustomElevatedButton({
    required this.child,
    this.backgroundColor,
    this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
            backgroundColor: backgroundColor ??  AppColors.primary,
            fixedSize: const Size(double.infinity, 60),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15))),
        child: child,
      ),
    );
  }
}

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
