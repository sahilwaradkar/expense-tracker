import 'package:assignment/app.dart';
import 'package:assignment/controller/auth/auth_controller.dart';
import 'package:assignment/core/common/custom_elevated_button.dart';
import 'package:assignment/core/constant/colors.dart';
import 'package:assignment/screens/transaction/transaction_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<AuthController>(context);
    return Scaffold(
      appBar: CustomAppBar(
        title: "Profile",
      ),
      body: Expanded(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(size.width * 0.03),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: size.width * 0.08,
                    child: Icon(Icons.person, size: size.width * 0.1,),
                  ),
                  SizedBox(
                    width: size.width * 0.03
                  ),
                  Expanded(
                    child: Text(controller.user.email ?? "", style: TextStyle(
                      fontSize: size.width * 0.05,
                      color: Theme.of(context).brightness == Brightness.light ? AppColors.black : AppColors.white, overflow: TextOverflow.clip
                    ),),
                  ),

                ],
              ),
            ),
            CustomElevatedButton(onPressed: (){
              controller.logUserOut(context);
            }, child: Text("Logout",  style: TextStyle(
              color: Theme.of(context).brightness == Brightness.light ? AppColors.black : AppColors.white,
            ),))
          ],
        ),
      ),
    );
  }
}
