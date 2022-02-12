// ignore_for_file: prefer_final_fields

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mvvm_first_c/app/app_preferences.dart';
import 'package:mvvm_first_c/app/di.dart';
import 'package:mvvm_first_c/presentation/login/login_viewmodel.dart';
import 'package:mvvm_first_c/presentation/resources/assets_manager.dart';
import 'package:mvvm_first_c/presentation/resources/color_manager.dart';
import 'package:mvvm_first_c/presentation/resources/routes_manager.dart';
import 'package:mvvm_first_c/presentation/resources/strings_manager.dart';
import 'package:mvvm_first_c/presentation/resources/values_manager.dart';
import 'package:mvvm_first_c/presentation/state_renderer/state_renderer_implimenter.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  LoginViewModel _viewModel = instance<LoginViewModel>();
  AppPreferences _appPreferences = instance<AppPreferences>();
  TextEditingController _userNameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  _bind() {
    _viewModel.start();
    _userNameController
        .addListener(() => _viewModel.setUserName(_userNameController.text));
    _passwordController
        .addListener(() => _viewModel.setPassword(_passwordController.text));
    _viewModel.isUserLoggedInSuccessfullyController.stream
        .listen((isSuccessFullyLoge) {
//      navigate to main screen
      SchedulerBinding.instance?.addPostFrameCallback((timeStamp) {
        _appPreferences.setUserLoggedIn();
        Navigator.of(context).pushReplacementNamed(Routes.mainRoute);
      });
    });
  }

  @override
  void initState() {
    _bind();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      body: StreamBuilder<FlowState>(
          stream: _viewModel.outputState,
          builder: (context, snapshut) {
            return snapshut.data?.getScreenWidget(context, _getContentWidget(),
                    () {
                  _viewModel.login();
                }) ??
                _getContentWidget();
          }),
    );
  }

  Widget _getContentWidget() {
    return Scaffold(
      body: Container(
          padding: const EdgeInsets.only(top: AppPadding.p100),
          color: ColorManager.white,
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  SvgPicture.asset(ImageAssets.logoIc),
                  const SizedBox(height: AppSize.s20),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: AppPadding.p28, right: AppPadding.p28),
                    child: StreamBuilder<bool>(
                      stream: _viewModel.outputIsUserNameValid,
                      builder: (context, snapshut) {
                        return TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          controller: _userNameController,
                          decoration: InputDecoration(
                              hintText: AppStrings.userName,
                              label: const Text(AppStrings.userName),
                              errorText: (snapshut.data ?? true)
                                  ? null
                                  : AppStrings.userNameError),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: AppSize.s20),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: AppPadding.p28, right: AppPadding.p28),
                    child: StreamBuilder<bool>(
                      stream: _viewModel.outputIspasswordValid,
                      builder: (context, snapshut) {
                        return TextFormField(
                          keyboardType: TextInputType.visiblePassword,
                          controller: _passwordController,
                          decoration: InputDecoration(
                              hintText: AppStrings.password,
                              label: const Text(AppStrings.password),
                              errorText: (snapshut.data ?? true)
                                  ? null
                                  : AppStrings.passwordError),
                        );
                      },
                    ),
                  ),
                  const SizedBox(
                    height: AppSize.s28,
                  ),
                  Padding(
                      padding: const EdgeInsets.only(
                          left: AppPadding.p28, right: AppPadding.p28),
                      child: StreamBuilder<bool>(
                        stream: _viewModel.outputIsAllInputsValid,
                        builder: (context, snapshut) {
                          return SizedBox(
                              width: double.infinity,
                              height: AppSize.s40,
                              child: ElevatedButton(
                                onPressed: (snapshut.data ?? false)
                                    ? () {
                                        _viewModel.login();
                                      }
                                    : null,
                                child: const Text(AppStrings.login),
                              ));
                        },
                      )),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: AppPadding.p8,
                        left: AppPadding.p28,
                        right: AppPadding.p28),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, Routes.forgotPasswordRoute);
                            },
                            child: Text(
                              AppStrings.ForgotPassword,
                              style: Theme.of(context).textTheme.subtitle2,
                            )),
                        TextButton(
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, Routes.registerRoute);
                            },
                            child: Text(
                              AppStrings.register,
                              style: Theme.of(context).textTheme.subtitle2,
                            ))
                      ],
                    ),
                  )
                ],
              ),
            ),
          )),
    );
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }
}
