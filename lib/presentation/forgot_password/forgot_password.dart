// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mvvm_first_c/presentation/resources/assets_manager.dart';
import 'package:mvvm_first_c/presentation/resources/color_manager.dart'; 
import 'package:mvvm_first_c/presentation/resources/strings_manager.dart';
import 'package:mvvm_first_c/presentation/resources/values_manager.dart';
import 'package:mvvm_first_c/presentation/state_renderer/state_renderer_implimenter.dart';

import 'Forgot_password_view_model.dart';

class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({Key? key}) : super(key: key);

  @override
  _ForgotPasswordViewState createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
  ForgotPasswordViewModel _viewModel = ForgotPasswordViewModel(null);
  TextEditingController _emailController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  void _bind() {
    _viewModel.start();
    _emailController
        .addListener(() => _viewModel.setEmail(_emailController.text));
  }

  @override
  void initState() {
    _bind();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: ColorManager.white,
      body: StreamBuilder<FlowState>(
          stream: _viewModel.outputState,
          builder: (context, snapshut) {
            return snapshut.data?.getScreenWidget(context, _getContentWidget(context),
                    () {
                  _viewModel.forgotPassword();
                }) ??
                _getContentWidget(context);
          }),
    );
  }

  Widget _getContentWidget(BuildContext context) {
    return Scaffold(
      body: Container(
          padding: const EdgeInsets.only(top: AppPading.p100),
          color: ColorManager.white,
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  SvgPicture.asset(ImageAssets.logoIc),
                  const SizedBox(height: AppSize.s20),
                  const SizedBox(height: AppSize.s20),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: AppPading.p28, right: AppPading.p28),
                    child: StreamBuilder<bool>(
                      stream: _viewModel.outputIsEmailValid,
                      builder: (context, snapshut) {
                        return TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          controller: _emailController,
                          decoration: InputDecoration(
                              hintText: AppStrings.email,
                              label: const Text(AppStrings.email),
                              errorText: (snapshut.data ?? true)
                                  ? null
                                  : AppStrings.emailError),
                        );
                      },
                    ),
                  ),
                  const SizedBox(
                    height: AppSize.s28,
                  ),
                  Padding(
                      padding: const EdgeInsets.only(
                          left: AppPading.p28, right: AppPading.p28),
                      child: StreamBuilder<bool>(
                        stream: _viewModel.outputIsEmailValid,
                        builder: (context, snapshut) {
                          return SizedBox(
                              width: double.infinity,
                              height: AppSize.s40,
                              child: ElevatedButton(
                                onPressed: (snapshut.data ?? false)
                                    ? () {
                                        _viewModel.resetPassword();
                                      }
                                    : null,
                                child: const Text(AppStrings.resetPassword),
                              ));
                        },
                      )),
                  const SizedBox(
                    height: AppSize.s28,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: AppPading.p28,
                      right: AppPading.p28,
                    ),
                    child: TextButton(
                        onPressed: () {},
                        child: Text(
                          AppStrings.resendEmail,
                          style: Theme.of(context).textTheme.subtitle2,
                        )),
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
