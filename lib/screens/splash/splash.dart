import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../components/custom_text.dart';
import '../../providers/auth/user_provider.dart';
import '../../utils/app_colors.dart';
import '../../utils/assets_constants.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    // Future.delayed(
    //   const Duration(seconds: 3),
    //   () {
    //     // Navigator.push(
    //     //     context, MaterialPageRoute(builder: (context) => const Login()));
    //     UtilFunctions().navigateTo(context, const Signup());
    //   },
    // );

    Provider.of<UserProvider>(context, listen: false).initializeUser(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FadeInDown(child: Image.asset(AssetConstants.logo)),
            const SizedBox(
              height: 72,
            ),
            FadeInUp(
              child: const CustomText(
                text: 'Shop Your Daily \nNecessary',
                fontSize: 30,
                fontWeight: FontWeight.w500,
                textAlign: TextAlign.center,
                color: AppColors.primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
