import 'package:assignment/controller/auth/auth_controller.dart';
import 'package:assignment/screens/auth/signup_screen.dart';
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
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        child: CustomElevatedButton(
          child: Text('Logout'),
          onPressed: () => Provider.of<AuthController>(context, listen: false).logUserOut(context),
        ),
      ),
    );
  }
}
