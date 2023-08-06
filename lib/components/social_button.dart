import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../utils/app_colors.dart';

class SocialButton extends StatelessWidget {
  const SocialButton({Key? key, required this.iconPath, required this.onTap})
      : super(key: key);

  final String iconPath;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 34,
          vertical: 20,
        ),
        decoration: BoxDecoration(
          color: AppColors.kWhite,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 5),
              color: AppColors.kAsh.withOpacity(0.8),
              blurRadius: 5,
              // spreadRadius: 5,
            )
          ],
        ),
        child: SvgPicture.asset(iconPath),
      ),
    );
  }
}
