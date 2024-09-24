import 'package:assignment/database/database.dart';
import 'package:assignment/screens/auth/signup_screen.dart';
import 'package:assignment/core/common/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../core/constant/colors.dart';
import '../../core/constant/image_resource.dart';
import '../../models/transaction.dart';

class AddExpenseScreen extends StatefulWidget {
  const AddExpenseScreen({Key? key}) : super(key: key);

  @override
  State<AddExpenseScreen> createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {
  String? selectedCategory;
  TextEditingController amountController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final databaseProvider = Provider.of<DatabaseProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.blue,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: AppColors.white,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Expense',
          style: TextStyle(
              fontWeight: FontWeight.w500,
              color: Theme.of(context).brightness == Brightness.light
                  ? AppColors.white
                  : AppColors.white),
        ),
      ),
      backgroundColor: AppColors.blue,
      body: Stack(
        children: [
          Positioned(
            left: 0,
            right: 0,
            bottom: MediaQuery.of(context).size.height *
                0.5, // Adjust the bottom margin as needed
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'How much?',
                    style: TextStyle(
                        fontSize: 18,
                        color: AppColors.white.withOpacity(0.7),
                        fontWeight: FontWeight.w600),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        '\u{20B9}',
                        style: TextStyle(
                            fontSize: 60,
                            color:
                                Theme.of(context).brightness == Brightness.light
                                    ? AppColors.white
                                    : AppColors.white,
                            fontWeight: FontWeight.w800),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.6,
                        child: TextFormField(
                          controller: amountController,
                          keyboardType: TextInputType.number,
                          style: TextStyle(
                              fontSize: 60,
                              color: Theme.of(context).brightness ==
                                      Brightness.light
                                  ? AppColors.white
                                  : AppColors.white,
                              fontWeight: FontWeight.w800),
                          decoration: InputDecoration(
                            hintText: '0',
                            hintStyle: TextStyle(
                                fontSize: 70,
                                color: Theme.of(context).brightness ==
                                        Brightness.light
                                    ? AppColors.white
                                    : AppColors.white,
                                fontWeight: FontWeight.w800),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height *
                  0.5, // Adjust the height as needed
              decoration: BoxDecoration(
                color: Theme.of(context).brightness == Brightness.light
                    ? AppColors.white
                    : AppColors.black,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 20),
                        width: MediaQuery.of(context).size.width * 0.93,
                        padding: EdgeInsets.only(left: 16, right: 10),
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: AppColors.grey.withOpacity(0.2)),
                            borderRadius: BorderRadius.circular(15)),
                        child: DropdownButton<String>(
                          padding: EdgeInsets.all(6),
                          icon: SvgPicture.asset(
                            ImageResource.arrowDown,
                            colorFilter: ColorFilter.mode(
                                AppColors.grey, BlendMode.srcIn),
                          ),
                          isExpanded: true,
                          underline: Container(),
                          iconEnabledColor: AppColors.primary,
                          value: selectedCategory,
                          hint: Text(
                            'Category',
                            style: TextStyle(
                              color: AppColors.grey,
                            ),
                          ),
                          onChanged: (value) {
                            setState(() {
                              selectedCategory = value!;
                            });
                          },
                          items: <String>[
                            'Shopping',
                            'Subscription',
                            'Travel',
                            'Food',
                            'Other'
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Theme.of(context).brightness ==
                                            Brightness.light
                                        ? AppColors.black
                                        : AppColors.white),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15.0, vertical: 20.0),
                        child: TextField(
                          controller: descriptionController,
                          // validator: validator,
                          decoration: InputDecoration(

                              // suffixIcon: suffixIcon,
                              contentPadding: EdgeInsets.all(20),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(
                                    color: AppColors.grey.withOpacity(0.2)),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(
                                    color: AppColors.grey.withOpacity(0.2)),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(
                                    color: AppColors.red.withOpacity(0.8)),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(color: AppColors.grey),
                              ),
                              hintText: 'Description',
                              hintStyle: TextStyle(
                                color: AppColors.grey,
                              )),
                          style: TextStyle(
                              color: Theme.of(context).brightness ==
                                      Brightness.light
                                  ? AppColors.black
                                  : AppColors.white),
                        ),
                      ),
                    ],
                  ),
                  CustomElevatedButton(
                    backgroundColor: AppColors.blue,
                    child: Text(
                      'Continue',
                      style: TextStyle(
                          color: AppColors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600),
                    ),
                    onPressed: () {
                      databaseProvider
                          .insertTransaction(TransactionModel(
                              amount: double.parse(amountController.text),
                              category: selectedCategory ?? 'Other',
                              desc: descriptionController.text,
                              date: DateTime.now().toString(),
                              type: 'Expense'))
                          .then((_) {
                        databaseProvider.updateBalance();
                        Navigator.pop(context);
                      });
                    },
                  )
                  // Container(
                  //   width: MediaQuery.of(context).size.width * 0.93,
                  //   padding: EdgeInsets.only(left: 16, right: 10),
                  //   decoration: BoxDecoration(
                  //       border: Border.all(color: AppColors.grey.withOpacity(0.2)),
                  //       borderRadius: BorderRadius.circular(15)),
                  //   child: DropdownButton<String>(
                  //     padding: EdgeInsets.all(6),
                  //     icon: SvgPicture.asset(
                  //       ImageResource.arrowDown,
                  //       colorFilter: ColorFilter.mode(AppColors.primary, BlendMode.srcIn),
                  //     ),
                  //     isExpanded: true,
                  //     underline: Container(),
                  //     iconEnabledColor: AppColors.primary,
                  //     value: selectedCategory,
                  //     hint: Text('Wallet'),
                  //     onChanged: (value) {
                  //       setState(() {
                  //         selectedCategory = value!;
                  //       });
                  //     },
                  //     items: <String>[
                  //       'Shopping',
                  //       'Subscription',
                  //       'Travel',
                  //       'Food',
                  //       'Other'
                  //     ].map<DropdownMenuItem<String>>((String value) {
                  //       return DropdownMenuItem<String>(
                  //         value: value,
                  //         child: Text(
                  //           value,
                  //           style: TextStyle(
                  //               fontWeight: FontWeight.w500,
                  //               color: Theme.of(context).brightness == Brightness.light
                  //                   ? AppColors.black
                  //                   : AppColors.white),
                  //         ),
                  //       );
                  //     }).toList(),
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
