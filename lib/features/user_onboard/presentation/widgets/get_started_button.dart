import 'package:flutter/material.dart';
import 'package:sencees/constants/app_colors.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sencees/home.dart';

class GetStartedButton extends StatelessWidget {
  const GetStartedButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: AppColors.appLightBlue),
      width: MediaQuery.of(context).size.width * .9,
      height: 55,
      child: TextButton(
          onPressed: () async {
            final pres = await SharedPreferences.getInstance();
            pres.setBool("onboarding", true);
            if (!context.mounted) return;
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => const Home()));
          },
          child: const Text(
            "Get started",
            style: TextStyle(color: Colors.white, fontSize: 17),
          )),
    );
  }
}
