import 'package:dev_hampter/screens/account/account_settings_page.dart';
import 'package:dev_hampter/screens/add/add_page.dart';
import 'package:dev_hampter/screens/homescreens/details_page.dart';
import 'package:dev_hampter/screens/homescreens/home_page.dart';
import 'package:dev_hampter/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NavBar extends StatelessWidget {
  const NavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavController());
    return Scaffold(
      backgroundColor: secondaryColor,
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: secondaryColor,
        ),
        child: Container(
          decoration: BoxDecoration(
            border: BorderDirectional(
              top: BorderSide(
                width: 2,
                color: primaryColor,
              ),
            ),
          ),
          height: MediaQuery.of(context).size.height * 0.1,
          child: Obx(
            () => BottomNavigationBar(
              selectedItemColor: iconColor,
              unselectedItemColor: primaryColor,
              elevation: 0,
              currentIndex: controller.selectedIndex.value,
              onTap: (index) => controller.selectedIndex.value = index,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: "Home",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.add_circle_outline),
                  label: "Add",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.auto_graph),
                  label: "Details",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: "Account",
                ),
              ],
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Obx(() => controller.screens[controller.selectedIndex.value]),
      ),
    );
  }
}

class NavController extends GetxController {
  final Rx<int> selectedIndex = 0.obs;

  final screens = [
    const HomePage(),
    const AddPage(),
    const DetailsPage(),
    const AccountSettingsPage(),
  ];
}
