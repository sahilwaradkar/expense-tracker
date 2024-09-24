import 'package:assignment/core/utils/get_month.dart';
import 'package:assignment/screens/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/constant/colors.dart';
import '../../database/database.dart';

class TransactionScreen extends StatefulWidget {
  const TransactionScreen({Key? key}) : super(key: key);

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  @override
  Widget build(BuildContext context) {
    final databaseProvider = Provider.of<DatabaseProvider>(context);
    return Scaffold(
      appBar: CustomAppBar(title: 'Transaction',),
      body: FutureBuilder(
        future: databaseProvider.getTransactions(),
        builder: (_, snapshot){
          if(snapshot.connectionState == ConnectionState.done){
            if(snapshot.hasError){
              return Center(child:  Text(snapshot.error.toString()),);
            }else{
              return TransactionList(selectedMonth: getMonth(DateTime.now().month),);
            }
          }
          else{
            return const Center(child: CircularProgressIndicator(),);
          }
        },
      ),
    );
  }
}

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  CustomAppBar({
    required this.title,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.primary,
      centerTitle: true,
      title: Text(
        title,
        style: TextStyle(
            fontWeight: FontWeight.w500,
            color: Theme.of(context).brightness == Brightness.light
                ? AppColors.white
                : AppColors.white),
      ),
    );
  }


  final height = AppBar().preferredSize.height;

  @override
  Size get preferredSize => Size.fromHeight(height);
}
