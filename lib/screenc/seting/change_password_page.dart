import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/cupertino.dart';
import '../components/components.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moody/blocs/blocs.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _currentPasswordController =
      TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmNewPasswordController =
      TextEditingController();

  bool _isPasswordVisible = false;

  // Method to handle form submission
  void _onSubmit() {
    if (_formKey.currentState!.validate()) {
      if (_newPasswordController.text == _confirmNewPasswordController.text) {
        // Dispatch the ChangePasswordEvent using Bloc
        context.read<AuthBloc>().add(
              ChangePasswordEvent(
                currentPassword: _currentPasswordController.text,
                newPassword: _newPasswordController.text,
              ),
            );
      } else {
        // Show error if passwords do not match
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Passwords do not match')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Change Password'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is UserSuccess && state.message != null) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message!)),
              );
            } else if (state is UserFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.error)),
              );
            }
          },
          builder: (context, state) {
            if (state is UserLoading) {
              return const Center(
                  child: CircularProgressIndicator()); // Show loading spinner
            }

            return Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // Current Password
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: MyTextField(
                        controller: _currentPasswordController,
                        hintText: 'Current Password',
                        obscureText: !_isPasswordVisible,
                        keyboardType: TextInputType.visiblePassword,
                        prefixIcon: const Icon(CupertinoIcons.lock_fill),
                        validator: (val) {
                          if (val!.isEmpty) {
                            return 'Please enter your current password';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(height: 20),

                    // New Password
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: MyTextField(
                        controller: _newPasswordController,
                        hintText: 'New Password',
                        obscureText: !_isPasswordVisible,
                        keyboardType: TextInputType.visiblePassword,
                        prefixIcon: const Icon(CupertinoIcons.lock_fill),
                        validator: (val) {
                          if (val!.isEmpty) {
                            return 'Please enter a new password';
                          } else if (!RegExp(
                                  r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~`)\%\-(_+=;:,.<>/?"[{\]}\|^]).{8,}$')
                              .hasMatch(val)) {
                            return 'Password must meet all criteria';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Confirm New Password
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: MyTextField(
                        controller: _confirmNewPasswordController,
                        hintText: 'Confirm New Password',
                        obscureText: !_isPasswordVisible,
                        keyboardType: TextInputType.visiblePassword,
                        prefixIcon: const Icon(CupertinoIcons.lock_fill),
                        validator: (val) {
                          if (val!.isEmpty) {
                            return 'Please confirm your new password';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Change Password Button
                    ElevatedButton(
                      onPressed: _onSubmit,
                      child: const Text('Change Password'),
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
}
