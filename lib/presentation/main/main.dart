import 'package:flutter/material.dart';
import 'package:mvvm_first_c/presentation/main/home/home_page.dart';
import 'package:mvvm_first_c/presentation/resources/color_manager.dart';
import 'package:mvvm_first_c/presentation/resources/strings_manager.dart';
import 'package:mvvm_first_c/presentation/resources/values_manager.dart';

import 'notification/notifications.dart';
import 'search/search.dart';
import 'settings/setting.dart';

class MainView extends StatefulWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  _MainViewState createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  List<Widget> pages = [
    HomePage(),
    NotificationPage(),
    SearchPage(),
    SettingPage()
  ];
  List<String> titles = [
    AppStrings.home,
    AppStrings.search,
    AppStrings.notifications,
    AppStrings.settings,
  ];
  var _title = AppStrings.home;
  var _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text(
          _title,
          style: Theme.of(context).textTheme.headline2,
        )),
        body: pages[_currentIndex],
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(color: ColorManager.black, spreadRadius: AppSize.s1_5)
            ],
          ),
          child: BottomNavigationBar(
            selectedItemColor: ColorManager.primary,
            unselectedItemColor: ColorManager.gray,
            currentIndex: _currentIndex,
            onTap: onTap,
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home), label: AppStrings.home),
              BottomNavigationBarItem(
                  icon: Icon(Icons.search), label: AppStrings.search),
              BottomNavigationBarItem(
                  icon: Icon(Icons.notifications),
                  label: AppStrings.notifications),
              BottomNavigationBarItem(
                  icon: Icon(Icons.settings), label: AppStrings.settings),
            ],
          ),
        ));
  }

  onTap(int index) {
    setState(() {
      _currentIndex = index;
      _title = titles[index];
    });
  }
}
