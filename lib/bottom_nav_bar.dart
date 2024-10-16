import 'package:assignment/controller/bottom_nav_bar/bottom_nav_bar_controller.dart';
import 'package:assignment/core/constant/colors.dart';
import 'package:assignment/core/constant/image_resource.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<BottomNavBarController>(context);
    return Scaffold(
      body: IndexedStack(
        index: controller.currentIndex,
        children: controller.screens,
      ),
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        backgroundColor: AppColors.primary,
        elevation: 0,
        child: Container(
            // width: MediaQuery.of(context).size.width * 0.1,
            height: MediaQuery.of(context).size.height * 0.095,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                //   border: Border(
                //     bottom: BorderSide(color: AppColors.white, width: 2),
                //     left: BorderSide(color: AppColors.white, width: 2),
                //     right: BorderSide(color: AppColors.white, width: 2),
                //   ),
                color: AppColors.primary),
            child: const Icon(
              Icons.add,
              size: 40,
              weight: 100,
              color: AppColors.white,
            )),
        onPressed: () {
          controller.showAddOptions(context);
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        color: Theme.of(context).brightness == Brightness.light
            ? AppColors.white
            : AppColors.black,
        shape: const CircularNotchedRectangle(),
        notchMargin: 10,
        child: SizedBox(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                onTap: () {
                  controller.updateIndex(0);
                },
                // minWidth: 40,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(ImageResource.home,
                        colorFilter: ColorFilter.mode(
                            controller.currentIndex == 0
                                ? AppColors.primary
                                : Colors.grey,
                            BlendMode.srcIn)),
                    Text(
                      'Home',
                      style: TextStyle(
                        color: controller.currentIndex == 0
                            ? AppColors.primary
                            : Colors.grey,
                      ),
                    )
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  controller.updateIndex(1);
                },
                // minWidth: 40,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(ImageResource.transaction,
                        colorFilter: ColorFilter.mode(
                            controller.currentIndex == 1
                                ? AppColors.primary
                                : Colors.grey,
                            BlendMode.srcIn)),
                    Text(
                      'Transaction',
                      style: TextStyle(
                        color: controller.currentIndex == 1
                            ? AppColors.primary
                            : Colors.grey,
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.08,
              ),
              GestureDetector(
                onTap: () {
                  controller.updateIndex(2);
                },
                // minWidth: 40,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(ImageResource.budget,
                        colorFilter: ColorFilter.mode(
                            controller.currentIndex == 2
                                ? AppColors.primary
                                : Colors.grey,
                            BlendMode.srcIn)),
                    Text(
                      'Report',
                      style: TextStyle(
                        color: controller.currentIndex == 2
                            ? AppColors.primary
                            : Colors.grey,
                      ),
                    )
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  controller.updateIndex(3);
                },
                // minWidth: 40,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(ImageResource.profile,
                        colorFilter: ColorFilter.mode(
                            controller.currentIndex == 3
                                ? AppColors.primary
                                : Colors.grey,
                            BlendMode.srcIn)),
                    Text(
                      'Profile',
                      style: TextStyle(
                        color: controller.currentIndex == 3
                            ? AppColors.primary
                            : Colors.grey,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
