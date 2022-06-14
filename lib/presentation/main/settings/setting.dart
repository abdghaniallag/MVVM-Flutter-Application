import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mvvm_first_c/app/di.dart';
import 'package:mvvm_first_c/data/data_source/local_data_source.dart';
import 'package:mvvm_first_c/presentation/resources/routes_manager.dart';
import '../../../app/app_preferences.dart';
import '../../resources/values_manager.dart';

import '../../resources/strings_manager.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  AppPreferences _appPreferances = instance<AppPreferences>();
  LocalDataSource _localDataSource = instance<LocalDataSource>();
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(AppPadding.p8),
      children: [
        ListTile(
          title: Text(AppStrings.changeLanguage.tr()),
          leading: const Icon(Icons.language_rounded),
          trailing: const Icon(Icons.arrow_forward_rounded),
          onTap: () {},
        ),
        ListTile(
          title: Text(AppStrings.contactUs.tr()),
          leading: const Icon(Icons.contact_page_rounded),
          trailing: const Icon(Icons.arrow_forward_rounded),
          onTap: () {},
        ),
        ListTile(
          title: Text(AppStrings.inviteFriends.tr()),
          leading: const Icon(Icons.insert_invitation_rounded),
          trailing: const Icon(Icons.arrow_forward_rounded),
          onTap: () {},
        ),
        ListTile(
          title: const Text(AppStrings.logOut).tr(),
          leading: const Icon(Icons.logout_rounded),
          trailing: const Icon(Icons.arrow_forward_rounded),
          onTap: () {
            _logOut();
          },
        )
      ],
    );
  }

  void _logOut() {
    _appPreferances.logOut();
    _localDataSource.clearDataSource();
    Navigator.pushNamed(context, Routes.loginRoute);
  }
}
