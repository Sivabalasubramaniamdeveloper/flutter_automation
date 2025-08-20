import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'base_screen.dart';

abstract class BaseFormScreen extends BaseScreen {
  const BaseFormScreen({super.key});

  // On form submit
  void onSubmit(BuildContext context);

  // Persistent formKey
  GlobalKey<FormState> get formKey;
  // Form fields
  List<Widget> buildFormFields(BuildContext context);
  @override
  Widget buildBody(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: formKey,
        child: Column(
          children: [
            ...buildFormFields(context),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  onSubmit(context);
                }
              },
              child: const Text("Submit"),
            ),
          ],
        ),
      ),
    );
  }
}
