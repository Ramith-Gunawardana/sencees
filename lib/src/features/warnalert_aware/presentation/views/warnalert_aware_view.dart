import 'package:flutter/material.dart';

class WarnAlertAwareView extends StatelessWidget {
  const WarnAlertAwareView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('WarnAlert Aware')),
      body: const Center(child: Text('WarnAlert Aware Page')),
    );
  }
}
