import 'package:assignment/core/constant/themes.dart';
import 'package:assignment/provider_list.dart';
import 'package:assignment/splash.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

late Size size;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return MultiProvider(
      providers: providerList(),
      child: MaterialApp(
        title: 'Xpense Mate',
        theme: MyTheme.lightTheme,
        darkTheme: MyTheme.darkTheme,
        home: const SplashScreen(),
      ),
    );
  }
}
