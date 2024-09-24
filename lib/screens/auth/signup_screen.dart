import 'package:assignment/controller/auth/auth_controller.dart';
import 'package:assignment/core/common/custom_text_form_field.dart';
import 'package:assignment/core/constant/colors.dart';
import 'package:assignment/core/constant/image_resource.dart';
import 'package:assignment/screens/auth/login_screen.dart';
import 'package:assignment/core/common/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../../core/utils/email_validation.dart';
import '../../core/utils/password_validation.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<AuthController>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Sign Up',
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(
                height: 40,
              ),
              CustomTextFormField(
                textController: controller.nameController,
                hintText: 'Name',
                validator: (value) {
                  if(value == ''){
                    return 'Enter Your Name';
                  }else{
                    return null;
                  }
                },
              ),
              CustomTextFormField(
                textController: controller.emailController,
                hintText: 'Email',
                validator: (value) => emailValidation(value),
              ),
              CustomTextFormField(
                textController: controller.passwordController,
                hintText: 'Password',
                obscureText: controller.isPasswordVisible,
                validator: (value) => passwordValidation(value),
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      controller.isPasswordVisible = !controller.isPasswordVisible;
                    });
                  },
                  icon: Icon(
                    controller.isPasswordVisible
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
                          controller.termsNConditions, // A boolean variable to manage the checkbox state
                      onChanged: (newValue) {
                        setState(() {
                          controller.termsNConditions = newValue!;
                        });
                      },
                      isError: controller.checkBox,
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
                          children: const <TextSpan>[
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
              ),
                // onPressed: () => Navigator.pushReplacement(context,
                //   MaterialPageRoute(builder: (context) => BottomNavBar())),
                onPressed: (){
                  if (_formKey.currentState!.validate()) {
                    if(controller.termsNConditions){
                      print('validate');
                      controller.signUserUp(context);
                    }else{
                      setState(() {
                        controller.checkBox = true;
                      });
                    }
                  }
                },
              ),
              Text(
                'Or with',
                style:
                    TextStyle(color: AppColors.grey, fontWeight: FontWeight.w700),
              ),
              GestureDetector(
                onTap: ()=>controller.signInWithGoogle(context),
                child: Padding(
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
              ),
              SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: ()=> Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen())),
                child: Text.rich(
                  TextSpan(
                    text: 'Already have an account? ',
                    children: const <TextSpan>[
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}


