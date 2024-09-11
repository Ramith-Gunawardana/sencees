import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:sencees/src/core/components/app_default_button.dart';
import 'package:sencees/src/core/constants/app_colors.dart';
import 'package:sencees/src/features/communication_assist/presentation/views/communication_assist_view.dart';

class CommunicationAnalyzerView extends StatelessWidget {
  const CommunicationAnalyzerView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Communication Analyzer')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AvatarGlow(
            startDelay: const Duration(milliseconds: 100),
            glowColor: AppColors.appLightBlue,
            glowShape: BoxShape.circle,
            animate: true,
            curve: Curves.fastOutSlowIn,
            child: Container(
              width: 150.0,
              height: 150.0,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage('assets/images/hello.jpg'),
                  fit: BoxFit
                      .contain, // Ensures the image is fully visible inside the circle
                ),
              ),
            ),
          ),

          // Text showing message
          const SizedBox(height: 100),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 32.0),
            child: Text(
              'Someone is trying to reach you with the word "Hello"',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ),

          // Button to continue to chat
          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: AppDefaultButton(
              text: 'Continue to Chat',
              backgroundColor: AppColors.appLightBlue,
              icon: Icons.chat_rounded,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const CommunicationAssistView()),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
