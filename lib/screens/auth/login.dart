import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../components/custom_button.dart';
import '../../components/custom_text.dart';
import '../../components/custom_text_field.dart';
import '../../components/social_button.dart';
import '../../providers/auth/login_provider.dart';
import '../../utils/app_colors.dart';
import '../../utils/assets_constants.dart';
import '../../utils/util_functions.dart';
import 'forgot_password.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            width: size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 52,
                ),
                const CustomText(
                  text: 'Login',
                  textAlign: TextAlign.center,
                  fontSize: 25,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primaryColor,
                ),
                const SizedBox(
                  height: 40,
                ),
                Image.asset(
                  AssetConstants.logo,
                  width: 202,
                  height: 138,
                ),
                const SizedBox(
                  height: 39,
                ),
                CustomTextfield(
                  hintText: "Email",
                  controller:
                      Provider.of<LoginProvider>(context).emailController,
                ),
                const SizedBox(
                  height: 8,
                ),
                CustomTextfield(
                  hintText: "Password",
                  isObscure: true,
                  controller:
                      Provider.of<LoginProvider>(context).passwordController,
                ),
                const SizedBox(
                  height: 16,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: InkWell(
                    onTap: () => UtilFunctions()
                        .navigateTo(context, const ForgotPassword()),
                    child: const CustomText(
                      text: 'Forgot your password?',
                      fontSize: 14,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 29,
                ),
                Consumer<LoginProvider>(
                  builder: (context, value, child) {
                    return CustomButton(
                      text: "Login",
                      isLoading: value.isLoading,
                      onTap: () {
                        value.startLogin(context);
                      },
                    );
                  },
                ),
                const SizedBox(
                  height: 23,
                ),
                const CustomText(
                  text: 'Or login with social account',
                  textAlign: TextAlign.center,
                  fontSize: 14,
                ),
                const SizedBox(
                  height: 12,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SocialButton(
                      iconPath: AssetConstants.googleIcon,
                      onTap: () {},
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    SocialButton(
                      iconPath: AssetConstants.facebookIcon,
                      onTap: () {},
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
