import 'dart:io';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mvvm_first_c/data/mapper/mapper.dart';
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
  ImagePicker imagePicker = instance<ImagePicker>();
  AppPreferences _appPreferences = instance<AppPreferences>();
  TextEditingController _userNameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _emailontroller = TextEditingController();
  TextEditingController _mobile_numberController = TextEditingController();
  TextEditingController _profilePictureController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  _bind() {
    _viewModel.start();
    _userNameController
        .addListener(() => _viewModel.setuserName(_userNameController.text));
    _passwordController
        .addListener(() => _viewModel.setPassword(_passwordController.text));
    _emailontroller
        .addListener(() => _viewModel.setEmail(_emailontroller.text));
    _mobile_numberController.addListener(
        () => _viewModel.setmobile_number(_mobile_numberController.text));
    _profilePictureController.addListener(() =>
        _viewModel.setProfilePicture(File(_profilePictureController.text)));
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
      appBar: AppBar(
        elevation: AppSize.s0,
        iconTheme: IconThemeData(color: ColorManager.primary),
        backgroundColor: ColorManager.white,
      ),
      body: StreamBuilder<FlowState>(
          stream: _viewModel.outputState,
          builder: (context, snapshut) {
            return Center(
              child: snapshut.data
                      ?.getScreenWidget(context, _getContentWidget(), () {
                    _viewModel.register();
                  }) ??
                  _getContentWidget(),
            );
          }),
    );
  }

  Widget _getContentWidget() {
    return Scaffold(
      body: Container(
          padding: const EdgeInsets.only(top: AppPadding.p8),
          color: ColorManager.white,
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(
                      height: AppSize.s100,
                      child: SvgPicture.asset(ImageAssets.logoIc)),
                  const SizedBox(height: AppSize.s18),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: AppPadding.p28, right: AppPadding.p28),
                    child: StreamBuilder<String?>(
                      stream: _viewModel.outputErrorUserNameValid,
                      builder: (context, snapshut) {
                        return TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            controller: _userNameController,
                            decoration: InputDecoration(
                              hintText: AppStrings.name,
                              label: const Text(AppStrings.name),
                              errorText: snapshut.data,
                            ));
                      },
                    ),
                  ),
                  const SizedBox(height: AppSize.s20),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: AppPadding.p28,
                          right: AppPadding.p28,
                          bottom: AppPadding.p20),
                      child: Row(
                        children: [
                          Expanded(
                              flex: 1,
                              child: CountryCodePicker(
                                onChanged: (country) {
                                  _viewModel.setCountryCode(
                                      country.dialCode ?? EMPTY);
                                },
                                initialSelection: "+213",
                                showCountryOnly: true,
                                showOnlyCountryWhenClosed: false,
                                hideMainText: true,
                                favorite: [
                                  "+966",
                                  "+213",
                                  "+39",
                                ],
                              )),
                          Expanded(
                            flex: 3,
                            child: StreamBuilder<String?>(
                              stream: _viewModel.outputErrormobile_numberValid,
                              builder: (context, snapshut) {
                                return TextFormField(
                                    keyboardType: TextInputType.phone,
                                    controller: _mobile_numberController,
                                    decoration: InputDecoration(
                                      hintText: AppStrings.mobile_number,
                                      label:
                                          const Text(AppStrings.mobile_number),
                                      errorText: (snapshut.data),
                                    ));
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: AppPadding.p28, right: AppPadding.p28),
                    child: StreamBuilder<String?>(
                      stream: _viewModel.outputErrorEmailValid,
                      builder: (context, snapshut) {
                        return TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            controller: _emailontroller,
                            decoration: InputDecoration(
                              hintText: AppStrings.emailHint,
                              label: const Text(AppStrings.emailHint),
                              errorText: (snapshut.data),
                            ));
                      },
                    ),
                  ),
                  const SizedBox(height: AppSize.s20),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: AppPadding.p28, right: AppPadding.p28),
                    child: StreamBuilder<String?>(
                      stream: _viewModel.outputErrorPasswordValid,
                      builder: (context, snapshut) {
                        return TextFormField(
                            keyboardType: TextInputType.visiblePassword,
                            controller: _passwordController,
                            decoration: InputDecoration(
                              hintText: AppStrings.password,
                              label: const Text(AppStrings.password),
                              errorText: (snapshut.data),
                            ));
                      },
                    ),
                  ),
                  const SizedBox(height: AppSize.s16),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: AppPadding.p28, right: AppPadding.p28),
                    child: Container(
                      height: AppSize.s40,
                      decoration: BoxDecoration(
                          border: Border.all(color: ColorManager.lightGray)),
                      child: GestureDetector(
                        child: _getMediaWidget(),
                        onTap: () {
                          _showPicture();
                        },
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: AppSize.s20,
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
                        left: AppPadding.p28, right: AppPadding.p28),
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

  Widget _getMediaWidget() {
    return Padding(
      padding: const EdgeInsets.only(
        left: AppPadding.p8,
        right: AppPadding.p8,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Flexible(
            child: Text(AppStrings.profilePicture),
          ),
          Flexible(
            child: StreamBuilder<File?>(
              stream: _viewModel.outputProfilePicture,
              builder: (context, snapshut) {
                return _getImagePickedByUser(snapshut.data);
              },
            ),
          ),
          Flexible(
            child: SvgPicture.asset(ImageAssets.cameraIc),
          )
        ],
      ),
    );
  }

  Widget _getImagePickedByUser(File? image) {
    if (image != null && image.path.isNotEmpty) {
      return Image.file(image);
    } else {
      return Container();
    }
  }

  _showPicture() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                trailing: const Icon(Icons.arrow_forward),
                leading: const Icon(Icons.image_rounded),
                title: const Text(AppStrings.pictureGallery),
                onTap: () {
                  _getImageFromGallery();
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                trailing: const Icon(Icons.arrow_forward),
                leading: const Icon(Icons.camera_alt_rounded),
                title: const Text(AppStrings.pictureCamera),
                onTap: () {
                  _getImageFromCamera();
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  _getImageFromGallery() async {
    var image = await imagePicker.pickImage(source: ImageSource.gallery);
    _viewModel.setProfilePicture(File(image?.path ?? EMPTY));
  }

  _getImageFromCamera() async {
    var image = await imagePicker.pickImage(source: ImageSource.camera);
    _viewModel.setProfilePicture(File(image?.path ?? EMPTY));
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }
}
