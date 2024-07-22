import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sencees/src/core/components/app_default_toast.dart';
import 'package:sencees/src/features/authentication/controllers/register_controller.dart';
import 'package:toastification/toastification.dart';

class RegisterView extends ConsumerStatefulWidget {
  const RegisterView({super.key});

  @override
  ConsumerState<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends ConsumerState<RegisterView> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameNameController = TextEditingController();
  final _suerNameController = TextEditingController();
  final _nickNameController = TextEditingController();

  int _currentStep = 0;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _firstNameController.dispose();
    _lastNameNameController.dispose();
    _suerNameController.dispose();
    _nickNameController.dispose();
    super.dispose();
  }

  Future<void> _onStepContinue() async {
    final isLastStep = _currentStep == getSteps().length - 1;
    if (isLastStep) {
      // Update the user in the controller
      try {
        await ref.read(registerControllerProvider.notifier).registerUser(
              username: _usernameController.text,
              password: _passwordController.text,
              firstName: _firstNameController.text,
              lastName: _lastNameNameController.text,
              surname: _suerNameController.text,
              nickName: _nickNameController.text,
            );
        final successMessage =
            ref.read(registerControllerProvider.notifier).successMessage;
        if (!mounted) return;
        AppDefaultToast.show(
          context: context,
          title: 'Registration Successful',
          description: successMessage ?? 'You have successfully registered!',
          type: ToastificationType.success,
        );
        // Navigate back
        Navigator.of(context).pop();
      } catch (e) {
        if (!mounted) return;
        AppDefaultToast.show(
          context: context,
          title: 'Registration Failed',
          description: e.toString(),
          type: ToastificationType.error,
        );
      }
    } else {
      setState(() {
        _currentStep++;
      });
    }
  }

  void _onStepCancel() {
    if (_currentStep > 0) {
      setState(() {
        _currentStep--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              const SizedBox(height: 40.0),
              const Text(
                "Create account",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                child: Text(
                  textAlign: TextAlign.center,
                  "Welcome! Please enter your information below and get started.",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Stepper(
                steps: getSteps(),
                currentStep: _currentStep,
                onStepContinue: _onStepContinue,
                onStepCancel: _onStepCancel,
              ),
              const SizedBox(height: 100.0),
            ],
          ),
        ),
      ),
    );
  }

  List<Step> getSteps() {
    return <Step>[
      Step(
          title: const Text(
            "First create Username & Password ",
            style: TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.w600,
            ),
          ),
          content: Column(
            children: [
              const SizedBox(height: 4.0),
              TextFormField(
                controller: _usernameController,
                decoration: const InputDecoration(
                  labelText: 'Username',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a username';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a password';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _confirmPasswordController,
                decoration: const InputDecoration(
                  labelText: 'Confirm Password',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a password';
                  }
                  return null;
                },
              ),
            ],
          )),
      Step(
          title: const Text(
            "How can someone reach you with your name?",
            style: TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.w600,
            ),
          ),
          content: Column(
            children: [
              const SizedBox(height: 4.0),
              TextFormField(
                controller: _firstNameController,
                decoration: const InputDecoration(
                  labelText: 'First Name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter first name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _lastNameNameController,
                decoration: const InputDecoration(
                  labelText: 'Last Name',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _suerNameController,
                decoration: const InputDecoration(
                  labelText: 'Surname',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _nickNameController,
                decoration: const InputDecoration(
                  labelText: 'Nick name',
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          )),
    ];
  }
}
