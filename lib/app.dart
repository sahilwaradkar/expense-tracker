import 'package:assignment/core/constant/themes.dart';
import 'package:assignment/provider_list.dart';
import 'package:assignment/splash.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return
      MultiProvider(
      providers: providerList(),
      child:
      MaterialApp(
        title: 'Flutter Demo',
        theme: MyTheme.lightTheme,
        darkTheme: MyTheme.darkTheme,
        home: const SplashScreen(),
      ),
    );
  }
}
