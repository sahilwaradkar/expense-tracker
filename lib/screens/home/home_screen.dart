import 'package:assignment/controller/bottom_nav_bar/bottom_nav_bar_controller.dart';
import 'package:assignment/core/constant/colors.dart';
import 'package:assignment/core/constant/image_resource.dart';
import 'package:assignment/database/database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../../core/utils/convert_date_time.dart';
import '../../core/utils/get_month.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future _transactionList;
  String? selectedMonth;

  Future _getTransactionList() async {
    final databaseProvider =
        Provider.of<DatabaseProvider>(context, listen: false);
    return await databaseProvider.getTransactions();
  }

  @override
  void initState() {
    super.initState();
    _transactionList = _getTransactionList().then((value) =>
        Provider.of<DatabaseProvider>(context, listen: false).updateBalance());
    selectedMonth = getMonth(DateTime.now().month);
  }

  @override
  Widget build(BuildContext context) {
    final databaseProvider = Provider.of<DatabaseProvider>(context);
    final bottomNavBarController = Provider.of<BottomNavBarController>(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: InkWell(
            onTap: () {
              bottomNavBarController.updateIndex(3);
            },
            child: Image.asset('assets/images/05.png')),
        title: Container(
          padding: EdgeInsets.only(left: 15, right: 10),
          decoration: BoxDecoration(
              border: Border.all(color: AppColors.blue.withOpacity(0.1)),
              borderRadius: BorderRadius.circular(50)),
          child: DropdownButton<String>(
            icon: SvgPicture.asset(
              ImageResource.arrowDown,
              colorFilter: ColorFilter.mode(AppColors.primary, BlendMode.srcIn),
            ),
            underline: Container(),
            iconEnabledColor: AppColors.primary,
            value: selectedMonth,
            hint: Text('Select Month'),
            onChanged: (value) {
              setState(() {
                selectedMonth = value;
              });
            },
            items: <String>[
              'January',
              'February',
              'March',
              'April',
              'May',
              'June',
              'July',
              'August',
              'September',
              'October',
              'November',
              'December',
            ].map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(
                  value,
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).brightness == Brightness.light
                          ? AppColors.black
                          : AppColors.white),
                ),
              );
            }).toList(),
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {
                // databaseProvider.insertTransaction(TransactionModel(amount: 123.0, category: 'Other', desc: 'Micellaneous', date: '11:38 am', type: 'Income'));
                databaseProvider.updateBalance();
              },
              icon: SvgPicture.asset(
                ImageResource.notification,
                colorFilter:
                    ColorFilter.mode(AppColors.primary, BlendMode.srcIn),
              ))
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          databaseProvider.updateBalance();
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Account Balance',
                    style: TextStyle(
                        color: AppColors.grey, fontWeight: FontWeight.w500),
                  ),
                  Text(
                    '\u{20B9}' + databaseProvider.balance.toStringAsFixed(1),
                    style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).brightness == Brightness.light
                            ? AppColors.black
                            : AppColors.white),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IndicatorCard(
                  title: 'Income',
                  amount: databaseProvider.income.toStringAsFixed(1),
                  icon: SvgPicture.asset(
                    ImageResource.income,
                    colorFilter:
                        ColorFilter.mode(AppColors.green, BlendMode.srcIn),
                  ),
                  color: AppColors.green,
                ),
                IndicatorCard(
                  title: 'Expense',
                  amount: databaseProvider.expense.toStringAsFixed(1),
                  icon: SvgPicture.asset(
                    ImageResource.expense,
                    colorFilter:
                        ColorFilter.mode(AppColors.red, BlendMode.srcIn),
                  ),
                  color: AppColors.red,
                )
              ],
            ),
            SizedBox(
              height: 30,
            ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //   children: [
            //     CustomTab(
            //       title: 'Today',
            //       color: AppColors.yellow,
            //     ),
            //     CustomTab(
            //       title: 'Week',
            //     ),
            //     CustomTab(
            //       title: 'Month',
            //     ),
            //     CustomTab(
            //       title: 'Year',
            //     ),
            //   ],
            // ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 10, top: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Recent Transaction',
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                        color: Theme.of(context).brightness == Brightness.light
                            ? AppColors.black
                            : AppColors.white),
                  ),
                  CustomTab(
                    onTap: () {
                      bottomNavBarController.updateIndex(1);
                    },
                    title: 'See all',
                    color: AppColors.primary,
                  )
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
                child: FutureBuilder(
              future: databaseProvider.getTransactions(),
              builder: (_, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text(snapshot.error.toString()),
                    );
                  } else if (!snapshot.hasData) {
                    return Center(
                      child: Text(
                        'No Transactions found',
                        style: TextStyle(
                            fontStyle: FontStyle.italic, color: AppColors.grey),
                      ),
                    );
                  } else {
                    return TransactionList(selectedMonth: selectedMonth,);
                  }
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            )),
          ],
        ),
      ),
    );
  }
}

class TransactionList extends StatelessWidget {
  String? selectedMonth;
  TransactionList({
    required this.selectedMonth,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<DatabaseProvider>(
      builder: (_, db, __) {
        var list = db.transactions.reversed.toList();
        return ListView.builder(
            itemCount: list.length,
            itemBuilder: (context, index) {
              return selectedMonth ==
                  getMonth(DateTime.parse(list[index].date.toString())
                          .month)

                  ? Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 15.0, horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                  padding: EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: list[index]
                                                  .category
                                                  .toLowerCase() ==
                                              'shopping'
                                          ? AppColors.yellow.withOpacity(0.2)
                                          : list[index]
                                                      .category
                                                      .toLowerCase() ==
                                                  'subscription'
                                              ? AppColors.primary
                                                  .withOpacity(0.2)
                                              : list[index]
                                                          .category
                                                          .toLowerCase() ==
                                                      'travel'
                                                  ? AppColors.blue
                                                      .withOpacity(0.2)
                                                  : list[index]
                                                              .category
                                                              .toLowerCase() ==
                                                          'food'
                                                      ? AppColors.red
                                                          .withOpacity(0.2)
                                                      : AppColors.green
                                                          .withOpacity(0.2)),
                                  child: SvgPicture.asset(
                                    list[index].category.toLowerCase() ==
                                            'shopping'
                                        ? ImageResource.shoppingBag
                                        : list[index].category.toLowerCase() ==
                                                'subscription'
                                            ? ImageResource.subscription
                                            : list[index]
                                                        .category
                                                        .toLowerCase() ==
                                                    'travel'
                                                ? ImageResource.travel
                                                : list[index]
                                                            .category
                                                            .toLowerCase() ==
                                                        'food'
                                                    ? ImageResource.food
                                                    : ImageResource.other,
                                    width: 40,
                                    colorFilter: ColorFilter.mode(
                                        list[index].category.toLowerCase() ==
                                                'shopping'
                                            ? AppColors.yellow
                                            : list[index]
                                                        .category
                                                        .toLowerCase() ==
                                                    'subscription'
                                                ? AppColors.primary
                                                : list[index]
                                                            .category
                                                            .toLowerCase() ==
                                                        'travel'
                                                    ? AppColors.blue
                                                    : list[index]
                                                                .category
                                                                .toLowerCase() ==
                                                            'food'
                                                        ? AppColors.red
                                                        : AppColors.green,
                                        BlendMode.srcIn),
                                  )),
                              SizedBox(
                                width: 10,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    list[index].category,
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                        color: Theme.of(context).brightness ==
                                                Brightness.light
                                            ? AppColors.black
                                            : AppColors.white),
                                  ),
                                  Text(
                                    list[index].desc,
                                    style: TextStyle(color: AppColors.grey),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                list[index].type.toLowerCase() == 'expense'
                                    ? '-\u{20B9}' +
                                        list[index].amount.toString()
                                    : '+\u{20B9}' +
                                        list[index].amount.toString(),
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: list[index].type.toLowerCase() ==
                                            'expense'
                                        ? AppColors.red
                                        : AppColors.green),
                              ),
                              Text(
                                convertDateTime(list[index].date),
                                style: TextStyle(color: AppColors.grey),
                              ),
                            ],
                          )
                        ],
                      ),
                    )
                  : SizedBox();
            });
      },
    );
  }
}

class CustomTab extends StatelessWidget {
  final String title;
  final Color? color;
  final VoidCallback? onTap;
  const CustomTab({super.key, this.onTap, required this.title, this.color});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.2,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(49),
          color: color == null ? Colors.transparent : color!.withOpacity(0.2),
        ),
        child: Text(
          title,
          style: TextStyle(
              fontWeight: FontWeight.w700, color: color ?? AppColors.grey),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

class IndicatorCard extends StatelessWidget {
  final String title, amount;
  final Color color;
  final SvgPicture icon;
  const IndicatorCard({
    super.key,
    required this.title,
    required this.amount,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.45,
      height: 95,
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              width: MediaQuery.of(context).size.width * 0.1,
              padding: EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              child: icon),
          SizedBox(
            width: 15,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                    fontWeight: FontWeight.w500, color: AppColors.white),
              ),
              Text(
                '\u{20B9}$amount',
                style: TextStyle(
                    fontSize: amount.length > 8 ? 17 : 22,
                    color: AppColors.white,
                    fontWeight: FontWeight.w500),
              ),
            ],
          )
        ],
      ),
    );
  }
}
