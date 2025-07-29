import 'package:blood_system/blocs/auth/bloc.dart';
import 'package:blood_system/blocs/auth/event.dart';
import 'package:blood_system/blocs/auth/state.dart';
import 'package:blood_system/blocs/hospital/bloc.dart';
import 'package:blood_system/blocs/hospital/event.dart';
import 'package:blood_system/blocs/hospital/state.dart';
import 'package:blood_system/models/hospital_model.dart';
import 'package:blood_system/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HospitalAdminRegister extends StatefulWidget {
  const HospitalAdminRegister({super.key});

  @override
  State<HospitalAdminRegister> createState() => _HospitalAdminRegisterState();
}

class _HospitalAdminRegisterState extends State<HospitalAdminRegister> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();

  Hospital? selectedHospital;
  bool _isPasswordVisible = false;

  @override
  void initState() {
    super.initState();
    // Load all hospitals when the screen starts
    context.read<HospitalBloc>().add(const LoadAllHospitals());
  }

  @override
  void dispose() {
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          print(
            'HospitalAdminRegister - AuthState changed: ${state.runtimeType}',
          );

          if (state is AuthEmailVerificationSent) {
            // Email verification sent, navigate to verification screen
            Navigator.of(context).pushReplacementNamed('/email-verification');
          } else if (state is AuthError) {
            // Show error message
            print(
              'HospitalAdminRegister - AuthError received: ${state.message}',
            );
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
                behavior: SnackBarBehavior.floating,
                margin: const EdgeInsets.all(16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                duration: const Duration(seconds: 4),
              ),
            );
          }
        },
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            final isLoading = state is AuthLoading;
            return SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title
                    const Text(
                      'Create Account',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 40),

                    // Hospital Selection Dropdown
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 8),
                        BlocBuilder<HospitalBloc, HospitalState>(
                          builder: (context, state) {
                            if (state is HospitalLoading) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            } else if (state is HospitalsLoaded) {
                              print('WE ARE HERE now ${state.hospitals}');
                              return DropdownButtonFormField<String>(
                                value: selectedHospital?.name,
                                hint: const Text('Select hospital'),
                                isExpanded: true,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.grey[50],
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide(
                                      color: Colors.grey[300]!,
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide(
                                      color: Colors.grey[300]!,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: const BorderSide(
                                      color: Colors.blue,
                                    ),
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 16,
                                  ),
                                ),
                                items:
                                    state.hospitals
                                        .map<DropdownMenuItem<String>>((
                                          Hospital hospital,
                                        ) {
                                          return DropdownMenuItem<String>(
                                            value: hospital.name,
                                            child: Text(hospital.name),
                                          );
                                        })
                                        .toList(),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    selectedHospital = state.hospitals
                                        .firstWhere(
                                          (hospital) =>
                                              hospital.name == newValue,
                                        );
                                  });
                                },
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please select a hospital';
                                  }
                                  return null;
                                },
                              );
                            }
                            // Default: empty dropdown (or you can show a placeholder)
                            return DropdownButtonFormField<String>(
                              value: null,
                              hint: const Text('Select hospital'),
                              items: const [],
                              onChanged: null,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(color: Colors.grey),
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),

                    // Email Field
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 8),
                        TextFormField(
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            filled: true,
                            hintText: 'Email',
                            fillColor: Colors.grey[50],
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(color: Colors.grey[300]!),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(color: Colors.grey[300]!),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(color: Colors.blue),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 16,
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email';
                            }
                            if (!RegExp(
                              r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                            ).hasMatch(value)) {
                              return 'Please enter a valid email';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),

                    // Phone Number Field
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 8),
                        TextFormField(
                          controller: _phoneController,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            hintText: 'Phone Number',
                            filled: true,
                            fillColor: Colors.grey[50],
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(color: Colors.grey[300]!),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(color: Colors.grey[300]!),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(color: Colors.blue),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),

                    // Password Field
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 8),
                        TextFormField(
                          controller: _passwordController,
                          obscureText: !_isPasswordVisible,
                          decoration: InputDecoration(
                            hintText: 'Password',
                            filled: true,
                            fillColor: Colors.grey[50],
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(color: Colors.grey[300]!),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(color: Colors.grey[300]!),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(color: Colors.blue),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 16,
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _isPasswordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Colors.grey,
                              ),
                              onPressed: () {
                                setState(() {
                                  _isPasswordVisible = !_isPasswordVisible;
                                });
                              },
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your password';
                            }
                            if (value.length < 6) {
                              return 'Password must be at least 6 characters';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 40),

                    // Register Button
                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton(
                        onPressed:
                            isLoading
                                ? null
                                : () {
                                  if (_formKey.currentState!.validate()) {
                                    // Handle registration logic here
                                    _handleRegister();
                                  }
                                },

                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              isLoading ? Colors.grey[400] : AppColors.red,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(28),
                          ),
                          elevation: 0,
                        ),
                        child:
                            isLoading
                                ? Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                              Colors.white,
                                            ),
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    const Text(
                                      'Registering...',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                )
                                : const Text(
                                  'Register',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Sign Up Link
                    Center(
                      child: RichText(
                        text: TextSpan(
                          text: "Already have an account? ",
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                          ),
                          children: [
                            WidgetSpan(
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.of(
                                    context,
                                  ).pushReplacementNamed('/login');
                                },
                                child: const Text(
                                  'Login',
                                  style: TextStyle(
                                    color: AppColors.red,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _handleRegister() {
    print('HospitalAdminRegister - _handleRegister called');
    print('Hospital: $selectedHospital');
    print('Email: ${_emailController.text}');
    print('Phone: ${_phoneController.text}');
    print('Password: ${_passwordController.text}');

    if (_formKey.currentState!.validate()) {
      print(
        'HospitalAdminRegister - Form validated, dispatching AuthSignUpRequested',
      );
      context.read<AuthBloc>().add(
        AuthSignUpRequested(
          fullName: _emailController.text.trim(),
          email: _emailController.text.trim(),
          districtName: selectedHospital?.district ?? '',
          hospital: selectedHospital?.name ?? '',
          password: _passwordController.text,
          phoneNumber: _phoneController.text.trim(),
          role: 'HOSPITAL_ADMIN',
          gender: '',
          bloodType: '',
        ),
      );
    } else {
      print('HospitalAdminRegister - Form validation failed');
      // Show a general validation error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Please check your form data'),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.all(16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      );
    }
  }
}
