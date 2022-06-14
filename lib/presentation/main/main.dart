import 'package:easy_localization/easy_localization.dart';
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
    AppStrings.home.tr(),
    AppStrings.search.tr(),
    AppStrings.notifications.tr(),
    AppStrings.settings.tr(),
  ];
  var _title = AppStrings.home.tr();
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
            items: [
              BottomNavigationBarItem(
                  icon: const Icon(Icons.home), label: AppStrings.home.tr()),
              BottomNavigationBarItem(
                  icon: const Icon(Icons.search),
                  label: AppStrings.search.tr()),
              BottomNavigationBarItem(
                  icon: const Icon(Icons.notifications),
                  label: AppStrings.notifications.tr()),
              BottomNavigationBarItem(
                  icon: const Icon(Icons.settings),
                  label: AppStrings.settings.tr()),
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
