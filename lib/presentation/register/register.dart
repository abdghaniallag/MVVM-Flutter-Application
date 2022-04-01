import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mvvm_first_c/presentation/register/registerViewModel.dart';

import '../../app/app_preferences.dart';
import '../../app/di.dart';
import '../resources/assets_manager.dart';
import '../resources/color_manager.dart';
import '../resources/routes_manager.dart';
import '../resources/strings_manager.dart';
import '../resources/values_manager.dart';
import '../state_renderer/state_renderer_implimenter.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  _RegisterViewState createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  RegisterViewModel _viewModel = instance<RegisterViewModel>();
  AppPreferences _appPreferences = instance<AppPreferences>();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _emailontroller = TextEditingController();
  TextEditingController _mobileController = TextEditingController();
  TextEditingController _profilePictureController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  _bind() {
    _viewModel.start();
    _nameController.addListener(() => _viewModel.setName(_nameController.text));
    _passwordController
        .addListener(() => _viewModel.setPassword(_passwordController.text));

    _emailontroller.addListener(() => _viewModel.setName(_emailontroller.text));
    _mobileController
        .addListener(() => _viewModel.setPassword(_mobileController.text));
    _profilePictureController.addListener(
        () => _viewModel.setPassword(_profilePictureController.text));
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
                  _viewModel.register();
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
                      stream: _viewModel.outputIsNameValid,
                      builder: (context, snapshut) {
                        return TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          controller: _nameController,
                          decoration: InputDecoration(
                              hintText: AppStrings.name,
                              label: const Text(AppStrings.name),
                              errorText: (snapshut.data ?? true)
                                  ? null
                                  : AppStrings.name),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: AppSize.s16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                          height: AppSize.s36,
                          child: SvgPicture.asset(ImageAssets.emptyCircle)),
                      const SizedBox(width: AppSize.s14),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: AppPadding.p28, right: AppPadding.p28),
                        child: StreamBuilder<bool>(
                          stream: _viewModel.outputIsmobileValid,
                          builder: (context, snapshut) {
                            return TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              controller: _mobileController,
                              decoration: InputDecoration(
                                  hintText: AppStrings.mobile,
                                  label: const Text(AppStrings.mobile),
                                  errorText: (snapshut.data ?? true)
                                      ? null
                                      : AppStrings.mobileError),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSize.s16),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: AppPadding.p28, right: AppPadding.p28),
                    child: StreamBuilder<bool>(
                      stream: _viewModel.outputIsEmailValid,
                      builder: (context, snapshut) {
                        return TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          controller: _emailontroller,
                          decoration: InputDecoration(
                              hintText: AppStrings.emailHint,
                              label: const Text(AppStrings.emailHint),
                              errorText: (snapshut.data ?? true)
                                  ? null
                                  : AppStrings.invalidEmail),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: AppSize.s16),
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
                  const SizedBox(height: AppSize.s16),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: AppPadding.p28, right: AppPadding.p28),
                    child: StreamBuilder<bool>(
                      stream: _viewModel.outputIsProfilePictureValid,
                      builder: (context, snapshut) {
                        return TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          controller: _profilePictureController,
                          decoration: InputDecoration(
                              hintText: AppStrings.profilePicture,
                              label: const Text(AppStrings.profilePicture),
                              errorText: (snapshut.data ?? true)
                                  ? null
                                  : AppStrings.profilePictureError),
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
                                        _viewModel.register();
                                      }
                                    : null,
                                child: const Text(AppStrings.register),
                              ));
                        },
                      )),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: AppPadding.p8,
                        left: AppPadding.p28,
                        right: AppPadding.p28),
                    child: TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, Routes.loginRoute);
                        },
                        child: Text(
                          AppStrings.haveAnAccount,
                          style: Theme.of(context).textTheme.subtitle2,
                        )),
                  ),
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
