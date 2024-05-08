import 'package:flutter/material.dart';

import '../../screens/budget/budget_screen.dart';
import '../../screens/home/home_screen.dart';
import '../../screens/profile/profile_screen.dart';
import '../../screens/transaction/transaction_screen.dart';

class BottomNavBarController extends ChangeNotifier{
  int currentIndex = 0;
  final List<Widget> screens = [
    HomeScreen(),
    TransactionScreen(),
    BudgetScreen(),
    ProfileScreen(),
  ];

  void updateIndex(index){
    currentIndex = index;
    notifyListeners();
  }
}