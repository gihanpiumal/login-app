import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import '../../controllers/auth_controllers.dart';
import '../../models/objects.dart';
import '../../screens/auth/signup.dart';
import '../../screens/main/main_screeen.dart';
import '../../utils/util_functions.dart';

class UserProvider extends ChangeNotifier {
  // user model
  late UserModel _userModel;

  // get usr model
  UserModel get userModel => _userModel;

  /// loader state
  bool _isLoading = false;
  // get loading state
  bool get isLoading => _isLoading;

  /// change loading state
  void setLoading(bool val) {
    _isLoading = val;
    notifyListeners();
  }

  // fetch single user data
  Future<void> fetchUser(String id) async {
    try {
      // start the loading
      setLoading(true);

      await AuthController().fetchUserData(id).then((value) {
        if (value != null) {
          Logger().w(value.email);
          _userModel = value;
          notifyListeners();

          // stop the loading
          setLoading(false);
        }
      });
    } catch (e) {}
  }

  /// initialize and check whether the user is signin or not
  Future<void> initializeUser(BuildContext context) async {
    FirebaseAuth.instance.authStateChanges().listen((User? user) async {
      if (user == null) {
        UtilFunctions().navigateTo(context, const Signup());
      } else {
        await fetchUser(user.uid);
        UtilFunctions().navigateTo(context, const MainScreen());
      }
    });
  }
}
