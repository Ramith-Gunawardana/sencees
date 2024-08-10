import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:sencees/src/features/communication_analyzer/presentation/views/communication_analyzer_view.dart';
import 'package:sencees/src/features/communication_assist/presentation/views/communication_assist_view.dart';
import 'package:sencees/src/features/envirosens_aware/presentation/views/envirosens_aware_view.dart';
import 'package:sencees/src/features/warnalert_aware/presentation/views/warnalert_aware_view.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView>
    with TickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final titles = [
      "Communication\nAnalyzer",
      "Communication\nAssist",
      "WarnAlert\nAware",
      "EnviroSens\nAware",
    ];
    final subtitles = [
      "Stay Connected",
      "Stay Aware",
      "Stay Safe",
      "Stay Informed",
    ];

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 30),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Hi! Good Morning ,",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                        Text(
                          "Manula Kavinda",
                          style: TextStyle(
                              fontSize: 24.0, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  CircleAvatar(
                    radius: 25, // Adjust the radius as needed
                    backgroundImage: AssetImage('assets/images/avatar.jpg'),
                  ),
                ],
              ),
              Center(
                child: SizedBox(
                  height: 300,
                  child: Image.asset(
                    'assets/images/dash_img3.png',
                    fit: BoxFit.cover, // Adjust how the image fits
                  ),
                ),
              ),
              const SizedBox(height: 30),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.70,
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemCount: 4,
                  itemBuilder: (context, index) {
                    final animationPath = 'assets/lottie/${index + 1}.json';

                    // Define the pages to navigate to
                    final pages = [
                      const CommunicationAnalyzerView(),
                      const CommunicationAssistView(),
                      const WarnAlertAwareView(),
                      const EnviroSensAwareView(),
                    ];

                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => pages[index],
                          ),
                        );
                      },
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 80,
                                height: 80,
                                child: Padding(
                                  padding: (index == 1 || index == 3)
                                      ? const EdgeInsets.all(14.0)
                                      : EdgeInsets.zero,
                                  child: Lottie.asset(
                                    animationPath,
                                    controller: _controller,
                                    onLoaded: (composition) {
                                      _controller
                                        ..duration = composition.duration
                                        ..repeat();
                                    },
                                  ),
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    titles[index],
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    subtitles[index],
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CommunicationAnalyzerPage extends StatelessWidget {
  const CommunicationAnalyzerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Communication Analyzer')),
      body: const Center(child: Text('Communication Analyzer Page')),
    );
  }
}
