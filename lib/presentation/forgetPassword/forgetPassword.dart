// ignore_for_file: file_names

import 'package:flutter/material.dart';

import 'forget_password_view_model.dart';
class ForgetPasswordView extends StatefulWidget {
  const ForgetPasswordView({ Key? key }) : super(key: key);

  @override
  _ForgetPasswordViewState createState() => _ForgetPasswordViewState();
}

class _ForgetPasswordViewState extends State<ForgetPasswordView> {

  ForgetPasswordViewModel _viewModel=ForgetPasswordViewModel();
TextEditingController _emailController=TextEditingController();
  void _bind() {
    _viewModel.start();
    _emailController.addListener(() =>_viewModel.setEmaill(_emailController.text)); 
  }
@override
void initState() {
    _bind();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      
    );
  }
  @override 
  void dispose() { 
    _viewModel.dispose();
    super.dispose();
  }

}