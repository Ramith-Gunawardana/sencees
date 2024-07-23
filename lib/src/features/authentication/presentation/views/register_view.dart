import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sencees/src/core/components/app_default_toast.dart';
import 'package:sencees/src/core/constants/app_colors.dart';
import 'package:sencees/src/features/authentication/controllers/register_controller.dart';
import 'package:sencees/src/features/authentication/models/register_model.dart';
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
  final _lastNameController = TextEditingController();
  final _surnameController = TextEditingController();
  final _nickNameController = TextEditingController();
  final _birthDateController = TextEditingController();
  final _addressController = TextEditingController();
  final _mobileNumberController = TextEditingController();
  final _guardianMobileNumberController = TextEditingController();
  final _emailController = TextEditingController();
  final _aboutMeController = TextEditingController();

  int _currentStep = 0;
  String? _passwordError;
  String? _confirmPasswordError;
  bool _isObscuredPassword = true;
  bool _isObscuredConfirmPassword = true;
  DateTime? _selectedBirthDate;

  @override
  void initState() {
    super.initState();
    _passwordController.addListener(_validatePasswords);
    _confirmPasswordController.addListener(_validatePasswords);
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _surnameController.dispose();
    _nickNameController.dispose();
    _birthDateController.dispose();
    _addressController.dispose();
    _mobileNumberController.dispose();
    _guardianMobileNumberController.dispose();
    _emailController.dispose();
    _aboutMeController.dispose();
    super.dispose();
  }

  void _validatePasswords() {
    setState(() {
      _passwordError =
          _passwordController.text.isEmpty ? 'Please enter a password' : null;

      _confirmPasswordError = _confirmPasswordController.text.isEmpty
          ? 'Please confirm your password'
          : _confirmPasswordController.text != _passwordController.text
              ? 'Passwords do not match'
              : null;
    });
  }

  Future<void> _selectBirthDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedBirthDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null && picked != _selectedBirthDate) {
      setState(() {
        _selectedBirthDate = picked;
        _birthDateController.text = '${picked.toLocal()}'.split(' ')[0];
      });
    }
  }

  Future<void> _onStepContinue() async {
    final isLastStep = _currentStep == getSteps().length - 1;
    if (isLastStep) {
      // Create UserModel instance
      final userModel = UserModel(
        username: _usernameController.text,
        password: _passwordController.text,
        firstName: _firstNameController.text,
        lastName: _lastNameController.text,
        surname: _surnameController.text,
        nickName: _nickNameController.text,
        birthDate: _birthDateController.text,
        address: _addressController.text,
        mobileNumber: _mobileNumberController.text,
        guardianMobileNumber: _guardianMobileNumberController.text,
        email: _emailController.text,
        aboutMe: _aboutMeController.text,
      );

      try {
        await ref
            .read(registerControllerProvider.notifier)
            .registerUser(userModel);

        final successMessage =
            ref.read(registerControllerProvider.notifier).successMessage;
        if (!mounted) return;

        AppDefaultToast.show(
          context: context,
          title: 'Registration Successful',
          description: successMessage ?? 'You have successfully registered!',
          type: ToastificationType.success,
        );

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
              const Text(
                textAlign: TextAlign.center,
                "Welcome! Please enter your information\n below and get started.",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Stepper(
                steps: getSteps(),
                currentStep: _currentStep,
                onStepContinue: _onStepContinue,
                onStepCancel: _onStepCancel,
                controlsBuilder:
                    (BuildContext context, ControlsDetails controls) {
                  final isLastStep = _currentStep == getSteps().length - 1;
                  return Row(
                    children: <Widget>[
                      TextButton(
                        onPressed: controls.onStepContinue,
                        child: Text(
                          isLastStep ? 'REGISTER' : 'CONTINUE',
                          style: const TextStyle(color: AppColors.appLightBlue),
                        ),
                      ),
                      if (_currentStep > 0 || isLastStep)
                        TextButton(
                          onPressed: controls.onStepCancel,
                          child: const Text(
                            'CANCEL',
                          ),
                        ),
                    ],
                  );
                },
              ),
              const SizedBox(height: 200.0),
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
                obscureText: _isObscuredPassword,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: const OutlineInputBorder(),
                  errorText: _passwordError,
                  suffixIcon: IconButton(
                    icon: Icon(_isObscuredPassword
                        ? Icons.visibility
                        : Icons.visibility_off),
                    onPressed: () {
                      setState(() {
                        _isObscuredPassword = !_isObscuredPassword;
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _confirmPasswordController,
                obscureText: _isObscuredConfirmPassword,
                decoration: InputDecoration(
                  labelText: 'Confirm Password',
                  border: const OutlineInputBorder(),
                  errorText: _confirmPasswordError,
                  suffixIcon: IconButton(
                    icon: Icon(_isObscuredConfirmPassword
                        ? Icons.visibility
                        : Icons.visibility_off),
                    onPressed: () {
                      setState(() {
                        _isObscuredConfirmPassword =
                            !_isObscuredConfirmPassword;
                      });
                    },
                  ),
                ),
              ),
            ],
          )),
      Step(
          title: const Text(
            "How can someone reach you with your name ?",
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
                controller: _lastNameController,
                decoration: const InputDecoration(
                  labelText: 'Last Name',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _surnameController,
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
      Step(
          title: const Text(
            "Now let us know your date of birth & where you're from ? ",
            style: TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.w600,
            ),
          ),
          content: Column(
            children: [
              const SizedBox(height: 4.0),
              TextFormField(
                controller: _birthDateController,
                readOnly: true,
                onTap: _selectBirthDate,
                decoration: const InputDecoration(
                  labelText: 'Birth Date (YYYY-MM-DD)',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Birth Date';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _addressController,
                maxLines: null,
                keyboardType: TextInputType.multiline,
                textCapitalization: TextCapitalization.sentences,
                decoration: const InputDecoration(
                  labelText: 'Address',
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          )),
      Step(
          title: const Text(
            "How can someone contact you ? ",
            style: TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.w600,
            ),
          ),
          content: Column(
            children: [
              const SizedBox(height: 4.0),
              TextFormField(
                controller: _mobileNumberController,
                keyboardType: TextInputType.phone,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                  FilteringTextInputFormatter.digitsOnly
                ],
                decoration: const InputDecoration(
                  labelText: 'Mobile number',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter mobile number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _guardianMobileNumberController,
                keyboardType: TextInputType.phone,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                  FilteringTextInputFormatter.digitsOnly
                ],
                decoration: const InputDecoration(
                  labelText: 'Guardian mobile number',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter guardian mobile number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _emailController,
                maxLines: null,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          )),
      Step(
        title: const Text(
          "Tell us about you anything",
          style: TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.w600,
          ),
        ),
        content: TextFormField(
          controller: _aboutMeController,
          maxLines: null,
          keyboardType: TextInputType.multiline,
          textCapitalization: TextCapitalization.sentences,
          decoration: const InputDecoration(
            labelText: 'About Me',
            border: OutlineInputBorder(),
          ),
        ),
      )
    ];
  }
}
