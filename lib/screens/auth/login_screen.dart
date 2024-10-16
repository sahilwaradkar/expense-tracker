import 'package:assignment/controller/auth/auth_controller.dart';
import 'package:assignment/core/common/custom_text_form_field.dart';
import 'package:assignment/core/constant/colors.dart';
import 'package:assignment/core/constant/image_resource.dart';
import 'package:assignment/screens/auth/signup_screen.dart';
import 'package:assignment/core/common/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../../core/utils/email_validation.dart';
import '../../core/utils/password_validation.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final _formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    // final color = Theme.of(context).brightness == Brightness.light ? AppColors() : AppColors();
    final controller = Provider.of<AuthController>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Login',
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
                height: 80,
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
              SizedBox(height: 40,),
              CustomElevatedButton(child: Text(
                'Login',
                style: TextStyle(
                    color: AppColors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600),
              ),
                // onPressed: () => Navigator.pushReplacement(context,
                //   MaterialPageRoute(builder: (context) => BottomNavBar())),
                onPressed: (){
                  if (_formKey.currentState!.validate()) {
                      print('validate');
                      controller.signUserIn(context);
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
                          'Sign In with Google',
                          style:
                          TextStyle(fontWeight: FontWeight.w600, color: Theme.of(context).brightness == Brightness.light ? AppColors.black : AppColors.white, fontSize: 18),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: ()=> Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SignUpScreen())),
                child: Text.rich(
                  TextSpan(
                    text: "Don't have an account? ",
                    children: <TextSpan>[
                      TextSpan(
                        text: 'Sign Up',
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

