import 'package:assignment/core/constant/colors.dart';
import 'package:assignment/database/database.dart';
import 'package:assignment/screens/transaction/transaction_screen.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../core/constant/image_resource.dart';
import '../../core/utils/convert_date_time.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({Key? key}) : super(key: key);

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen>{

  @override
  Widget build(BuildContext context) {
    final databaseProvider = Provider.of<DatabaseProvider>(context);
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Report',
      ),
      body: FutureBuilder(
        future: databaseProvider.getTransactions(),
        builder: (_, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            } else {
              var list = databaseProvider.transactions.reversed.toList();
              // var graphList = databaseProvider.transactions;

              return Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  // Text('\$300', style: TextStyle(
                  //   fontSize: 30,
                  //   color: AppColors.white,
                  //   fontWeight: FontWeight.w600
                  // ),),
                  Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Stack(
                          children: [
                            Positioned(
                              bottom: 0,
                              left: 0,
                              child: Row(
                                children: [
                                  Container(
                                    width: 10,
                                    height: 10,
                                    color: AppColors.green,
                                  ),
                                  SizedBox(width: 5,)
                                  ,
                                  Text("Income", style: TextStyle(
                                      color: Theme.of(context).brightness == Brightness.light ? AppColors.black : AppColors.white
                                  ))
                                ],
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: Row(
                                children: [
                                  Container(
                                    width: 10,
                                    height: 10,
                                    color: AppColors.red,
                                  ),SizedBox(width: 5,)
                                  ,
                                  Text("Expense", style: TextStyle(
                                    color: Theme.of(context).brightness == Brightness.light ? AppColors.black : AppColors.white
                                  ),)
                                ],
                              ),
                            ),
                            PieChart(
                              PieChartData(
                                sections: [
                                  PieChartSectionData(
                                    value: databaseProvider.income,
                                    color: AppColors.green,
                                    radius: 100,
                                    borderSide: BorderSide.none,
                                    // titlePositionPercentageOffset: 1/ 3,
                                  ),
                                  PieChartSectionData(
                                    value: databaseProvider.expense,
                                    color: AppColors.red,
                                      radius: 100,
                                      borderSide: BorderSide.none,
                                    // badgeWidget: Text("abc")
                                  ),
                                ]
                              )
                            ),
                          ],
                        ),
                      )),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: (){
                          databaseProvider.changeReportType("Income");
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(30),
                                bottomLeft: Radius.circular(30)),
                            boxShadow: [
                              BoxShadow(
                                  color: AppColors.grey.withOpacity(0.5),
                                  offset: const Offset(
                                      -1, 1
                                  )
                              )
                            ],
                            color: databaseProvider.reportType == "Income" ? AppColors.primary : Theme.of(context).brightness == Brightness.light ? AppColors.white : AppColors.black,
                          ),
                          child: Text("Income", style: TextStyle(
                              color: databaseProvider.reportType == "Income" ? AppColors.white : Theme.of(context).brightness == Brightness.light ? AppColors.black : AppColors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold
                          ),),
                        ),
                      ),
                      InkWell(
                        onTap: (){
                          databaseProvider.changeReportType("Expense");
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                                topRight: Radius.circular(30),
                                bottomRight: Radius.circular(30)),
                            boxShadow: [
                              BoxShadow(
                                  color: AppColors.grey.withOpacity(0.5),
                                  offset: const Offset(
                                      1, 1
                                  )
                              )
                            ],
                            color: databaseProvider.reportType == "Expense" ? AppColors.primary :Theme.of(context).brightness == Brightness.light ? AppColors.white : AppColors.black,
                          ),
                          child: Text("Expense",style: TextStyle(
                              color: databaseProvider.reportType == "Expense" ? AppColors.white : Theme.of(context).brightness == Brightness.light ? AppColors.black : AppColors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold
                          ),),
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: ListView.builder(
                        itemCount: list.length,
                        itemBuilder: (context, index) {
                          return list[index].type == databaseProvider.reportType
                              ? Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 15.0, horizontal: 20),
                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                        padding: const EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                            BorderRadius.circular(
                                                15),
                                            color: list[index]
                                                .category
                                                .toLowerCase() ==
                                                'shopping'
                                                ? AppColors.yellow
                                                .withOpacity(0.2)
                                                : list[index]
                                                .category
                                                .toLowerCase() ==
                                                'subscription'
                                                ? AppColors.primary
                                                .withOpacity(
                                                0.2)
                                                : list[index]
                                                .category
                                                .toLowerCase() ==
                                                'travel'
                                                ? AppColors.blue
                                                .withOpacity(
                                                0.2)
                                                : list[index]
                                                .category
                                                .toLowerCase() ==
                                                'food'
                                                ? AppColors
                                                .red
                                                .withOpacity(0.2)
                                                : AppColors.green.withOpacity(0.2)),
                                        child: SvgPicture.asset(
                                          list[index]
                                              .category
                                              .toLowerCase() ==
                                              'shopping'
                                              ? ImageResource
                                              .shoppingBag
                                              : list[index]
                                              .category
                                              .toLowerCase() ==
                                              'subscription'
                                              ? ImageResource
                                              .subscription
                                              : list[index]
                                              .category
                                              .toLowerCase() ==
                                              'travel'
                                              ? ImageResource
                                              .travel
                                              : list[index]
                                              .category
                                              .toLowerCase() ==
                                              'food'
                                              ? ImageResource
                                              .food
                                              : ImageResource
                                              .other,
                                          width: 40,
                                          colorFilter:
                                          ColorFilter.mode(
                                              list[index]
                                                  .category
                                                  .toLowerCase() ==
                                                  'shopping'
                                                  ? AppColors
                                                  .yellow
                                                  : list[index]
                                                  .category
                                                  .toLowerCase() ==
                                                  'subscription'
                                                  ? AppColors
                                                  .primary
                                                  : list[index].category.toLowerCase() ==
                                                  'travel'
                                                  ? AppColors
                                                  .blue
                                                  : list[index].category.toLowerCase() ==
                                                  'food'
                                                  ? AppColors.red
                                                  : AppColors.green,
                                              BlendMode.srcIn),
                                        )),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          list[index].category,
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight:
                                              FontWeight.w500,
                                              color: Theme.of(context)
                                                  .brightness ==
                                                  Brightness.light
                                                  ? AppColors.black
                                                  : AppColors.white),
                                        ),
                                        Text(
                                          list[index].desc,
                                          style: const TextStyle(
                                              color: AppColors.grey),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      list[index]
                                          .type
                                          .toLowerCase() ==
                                          'expense'
                                          ? '-\u{20B9}' +
                                          list[index]
                                              .amount
                                              .toString()
                                          : '+\u{20B9}' +
                                          list[index]
                                              .amount
                                              .toString(),
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500,
                                          color: list[index]
                                              .type
                                              .toLowerCase() ==
                                              'expense'
                                              ? AppColors.red
                                              : AppColors.green),
                                    ),
                                    Text(
                                      convertDateTime(
                                          list[index].date),
                                      style: const TextStyle(
                                          color: AppColors.grey),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          )
                              : const SizedBox();
                        }),
                  ),
                ],
              );
            }
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
