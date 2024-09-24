import 'package:flutter/material.dart';

import '../../core/constant/colors.dart';
import '../../screens/add_transaction/add_expense_screen.dart';
import '../../screens/add_transaction/add_income_screen.dart';
import '../../screens/home/home_screen.dart';
import '../../screens/profile/profile_screen.dart';
import '../../screens/report/report_screen.dart';
import '../../screens/transaction/transaction_screen.dart';

class BottomNavBarController extends ChangeNotifier{
  int currentIndex = 0;
  final List<Widget> screens = [
    HomeScreen(),
    TransactionScreen(),
    ReportScreen(),
    ProfileScreen(),
  ];

  void updateIndex(index){
    currentIndex = index;
    notifyListeners();
  }

  void showAddOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.arrow_downward, color: AppColors.red,),
                title: Text('Add Expense', style: TextStyle(color: AppColors.red),),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AddExpenseScreen()),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.arrow_upward, color: AppColors.green,),
                title: Text('Add Income',style: TextStyle(color: AppColors.green),),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AddIncomeScreen()),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}