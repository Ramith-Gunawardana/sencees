import 'package:flutter/material.dart';

class CommunicationAssistView extends StatefulWidget {
  CommunicationAssistView({super.key});

  @override
  _CommunicationAssistViewState createState() =>
      _CommunicationAssistViewState();
}

class _CommunicationAssistViewState extends State<CommunicationAssistView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Communication Assist'),
      ),
    );
  }
}
