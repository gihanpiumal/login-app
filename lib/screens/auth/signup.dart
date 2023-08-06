import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../components/custom_button.dart';
import '../../components/custom_text.dart';
import '../../components/custom_text_field.dart';
import '../../providers/auth/signup_provider.dart';
import '../../utils/app_colors.dart';
import '../../utils/assets_constants.dart';
import '../../utils/util_functions.dart';
import 'login.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
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
                  text: 'SignUp',
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
                  hintText: "Name",
                  controller:
                      Provider.of<SignupProvider>(context).nameController,
                ),
                const SizedBox(
                  height: 8,
                ),
                CustomTextfield(
                  hintText: "Email",
                  controller:
                      Provider.of<SignupProvider>(context).emailController,
                ),
                const SizedBox(
                  height: 8,
                ),
                CustomTextfield(
                  hintText: "Password",
                  isObscure: true,
                  controller:
                      Provider.of<SignupProvider>(context).passwordController,
                ),
                const SizedBox(
                  height: 16,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: InkWell(
                    onTap: () {
                      UtilFunctions().navigateTo(context, const Login());
                    },
                    child: const CustomText(
                      text: 'Already have an account?',
                      fontSize: 14,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 29,
                ),
                Consumer<SignupProvider>(
                  builder: (context, value, child) {
                    return CustomButton(
                      text: "SignUp",
                      isLoading: value.isLoading,
                      onTap: () {
                        value.startSignup(context);
                      },
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
