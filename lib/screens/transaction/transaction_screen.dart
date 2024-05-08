import 'package:assignment/core/utils/get_month.dart';
import 'package:assignment/screens/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../core/constant/colors.dart';
import '../../core/constant/image_resource.dart';
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
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        centerTitle: true,
        title: Text(
          'Transactions',
          style: TextStyle(
              fontWeight: FontWeight.w500,
              color: Theme.of(context).brightness == Brightness.light
                  ? AppColors.white
                  : AppColors.white),
        ),
      ),
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
