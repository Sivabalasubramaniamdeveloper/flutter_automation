import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_automation/core/utils/snackbar_helper.dart';
import '../../../../core/base/abstract/base_form.dart';

class Screen2 extends BaseFormScreen {
  Screen2({super.key});
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  @override
  GlobalKey<FormState> get formKey => _formKey;

  @override
  String get title => "Login page";

  @override
  bool get showAppBar => true;

  @override
  List<Widget> buildFormFields(BuildContext context) {
    return [
      TextFormField(
        controller: _emailController,
        style: TextStyle(color: CupertinoColors.darkBackgroundGray),
        decoration: const InputDecoration(labelText: "Email"),
        validator: (val) => val!.isEmpty ? "Enter email" : null,
      ),
      TextFormField(
        controller: _passwordController,
        decoration: const InputDecoration(labelText: "Password"),
        obscureText: true,
        validator: (val) => val!.isEmpty ? "Enter password" : null,
      ),
    ];
  }

  @override
  void onSubmit(BuildContext context) {
    print("s");
    SnackBarHelper.showSuccess(context, "Login Successfully");
  }
}
