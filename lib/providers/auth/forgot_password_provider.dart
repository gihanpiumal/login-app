import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import '../../controllers/auth_controllers.dart';
import '../../utils/alert_helper.dart';

class ForgotPasswordProvider extends ChangeNotifier {
  /// email controller
  final _emailController = TextEditingController();
  // get email controller
  TextEditingController get emailController => _emailController;

  /// loader state
  bool _isLoading = false;
  // get loading state
  bool get isLoading => _isLoading;

  /// change loading state
  void setLoading(bool val) {
    _isLoading = val;
    notifyListeners();
  }

  /// validate text field functions
  bool validationFields(BuildContext context) {
    if (_emailController.text.isEmpty) {
      /// show error dialog
      AlertHelper.showAlert(
          context, DialogType.ERROR, "ERROR", "Please fill all the fields!");
      return false;
    } else if (!_emailController.text.contains("@")) {
      /// show error dialog
      AlertHelper.showAlert(
          context, DialogType.ERROR, "ERROR", "Please enter a valid email!");
      return false;
    } else {
      return true;
    }
  }

  /// start signup prosess
  Future<void> startForgotPassword(BuildContext context) async {
    try {
      if (validationFields(context)) {
        /// start the loader
        setLoading(true);
        await AuthController().sendPasswordResetEmail(
          context,
          _emailController.text,
        );

        /// clear text fields
        _emailController.clear();

        /// stop the loader
        setLoading(false);
      }
    } catch (e) {
      setLoading(false);
      Logger().e(e);
      AlertHelper.showAlert(context, DialogType.ERROR, "ERROR", e.toString());
    }
  }
}
