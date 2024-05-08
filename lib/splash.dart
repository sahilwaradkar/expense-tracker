import 'package:assignment/core/constant/colors.dart';
import 'package:assignment/core/constant/image_resource.dart';
import 'package:assignment/screens/auth/signup_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import 'bottom_nav_bar.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool onBoarding = false;

  void initState() {
    super.initState();
    User? user = FirebaseAuth.instance.currentUser;
    Future.delayed(const Duration(milliseconds: 3000), () async {
      // Future.delayed(const Duration(seconds: 1), (){
      if (user != null) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
              builder: (context) => const BottomNavBar()),
        );
      } else {
        setState(() {
          onBoarding = true;
        });
      }
      // });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: onBoarding == false ?
      Stack(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: Image.asset('assets/images/recordcircle.png'),
          ),
          Align(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset('assets/images/logo.png',),
                Text('CipherX', style: GoogleFonts.brunoAceSc(color: AppColors.white, fontSize: 40, fontWeight: FontWeight.w400),),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Image.asset('assets/images/recordcircle-bottom.png'),
          )
        ],
      ) :
      Stack(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: Image.asset('assets/images/recordcircle.png'),
          ),
          Positioned(left: 20, top: 50, child: Image.asset('assets/images/logo.png', width: 80,)),
          Align(
            alignment: Alignment.bottomLeft,
            child: Image.asset('assets/images/recordcircle-bottom.png'),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('Welcome to', style: TextStyle(fontSize: 36, color: AppColors.white),),
                        Text('CipherX', style: GoogleFonts.brunoAceSc(color: AppColors.white, fontSize: 36, fontWeight: FontWeight.w400),),
                      ],
                    ),
                    InkWell(onTap: () => Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => SignUpScreen())), child: CircleAvatar(radius: 35, backgroundColor: AppColors.white.withOpacity(0.8), child: SvgPicture.asset(ImageResource.arrowRight, width: 50, colorFilter: ColorFilter.mode(AppColors.black, BlendMode.srcIn),)))
                  ],
                ),
                SizedBox(height: 10,),
                Text('The best way to track your expenses.', style: TextStyle(fontSize: 18, color: AppColors.white, fontWeight: FontWeight.w400),),
                SizedBox(height: 70,),
              ],
            ),
          )
        ],
      ),
    );
  }
}
