import 'package:assignment/controller/auth/auth_controller.dart';
import 'package:assignment/controller/bottom_nav_bar/bottom_nav_bar_controller.dart';
import 'package:assignment/database/database.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> providerList() {
  return [
    ChangeNotifierProvider(create: (context) => DatabaseProvider()),
    ChangeNotifierProvider(create: (context) => BottomNavBarController()),
    ChangeNotifierProvider(create: (context) => AuthController())
  ];
}