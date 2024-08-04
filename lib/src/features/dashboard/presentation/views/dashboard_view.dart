import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

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
                    'assets/images/dash_img2.png',
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
                      const CommunicationAnalyzerPage(),
                      const CommunicationAssistPage(),
                      const WarnAlertAwarePage(),
                      const EnviroSensAwarePage(),
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

class CommunicationAssistPage extends StatelessWidget {
  const CommunicationAssistPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Communication Assist')),
      body: const Center(child: Text('Communication Assist Page')),
    );
  }
}

class EnviroSensAwarePage extends StatelessWidget {
  const EnviroSensAwarePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('EnviroSens Aware')),
      body: const Center(child: Text('EnviroSens Aware Page')),
    );
  }
}

class WarnAlertAwarePage extends StatelessWidget {
  const WarnAlertAwarePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('WarnAlert Aware')),
      body: const Center(child: Text('WarnAlert Aware Page')),
    );
  }
}
