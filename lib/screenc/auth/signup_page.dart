import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:moody/blocs/signup_bloc/auth_app.dart';
import '../components/components.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _username = TextEditingController();

  bool containsUpperCase = false;
  bool containsLowerCase = false;
  bool containsNumber = false;
  bool containsSpecialChar = false;
  bool contains8Length = false;
  bool _isPasswordVisible = false;

  String? errorMessage;
  final storage = const FlutterSecureStorage();

  void checkPassword(String val) {
    setState(() {
      containsUpperCase = RegExp(r'[A-Z]').hasMatch(val);
      containsLowerCase = RegExp(r'[a-z]').hasMatch(val);
      containsNumber = RegExp(r'[0-9]').hasMatch(val);
      containsSpecialChar =
          RegExp(r'^(?=.*?[!@#\$&*~`)\%\-(_+=;:,.<>/?"[{\]}\|^])')
              .hasMatch(val);
      contains8Length = val.length >= 8;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is SignUpFailure) {
            setState(() {
              errorMessage = state.error;
              debugPrint('Sign up Error: $errorMessage');
            });
            _formKey.currentState!.validate();
          } else if (state is SignUpSuccess) {
            debugPrint('Signup Success');
            Navigator.pushNamed(context, '/welcome');
          } else if (state is SignUpLoading) {
            debugPrint('Signup Loading...');
          } else if (state is SignUpInitial) {
            debugPrint('Signup Initial');
            setState(() {
              errorMessage = null;
            });
          }
        },
        builder: (context, state) {
          if (state is SignUpLoading) {
            return const Loading();
          } else {
            return Form(
              key: _formKey,
              child: SingleChildScrollView(
                // Ensure the page is scrollable if content overflows
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: MyTextField(
                        controller: _email,
                        hintText: 'Email',
                        obscureText: false,
                        keyboardType: TextInputType.emailAddress,
                        prefixIcon: const Icon(CupertinoIcons.mail_solid),
                        validator: (val) {
                          if (val!.isEmpty) {
                            return 'Please fill in this field';
                          } else if (!RegExp(r'^[\w-\.]+@([\w-]+.)+[\w-]{2,4}$')
                              .hasMatch(val)) {
                            return 'Please enter a valid email';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: MyTextField(
                        controller: _password,
                        hintText: 'Password',
                        obscureText: !_isPasswordVisible,
                        keyboardType: TextInputType.visiblePassword,
                        prefixIcon: const Icon(CupertinoIcons.lock_fill),
                        onChanged: (val) => checkPassword(
                            val!), // Update password check in real-time
                        validator: (val) {
                          if (val!.isEmpty) {
                            return 'Please fill in this field';
                          } else if (!RegExp(
                                  r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~`)\%\-(_+=;:,.<>/?"[{\]}\|^]).{8,}$')
                              .hasMatch(val)) {
                            return 'Please enter a valid password';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("⚈  1 uppercase",
                                style: TextStyle(
                                    color: containsUpperCase
                                        ? Colors.green
                                        : Theme.of(context)
                                            .colorScheme
                                            .onBackground)),
                            Text("⚈  1 lowercase",
                                style: TextStyle(
                                    color: containsLowerCase
                                        ? Colors.green
                                        : Theme.of(context)
                                            .colorScheme
                                            .onBackground)),
                            Text("⚈  1 number",
                                style: TextStyle(
                                    color: containsNumber
                                        ? Colors.green
                                        : Theme.of(context)
                                            .colorScheme
                                            .onBackground)),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("⚈  1 special character",
                                style: TextStyle(
                                    color: containsSpecialChar
                                        ? Colors.green
                                        : Theme.of(context)
                                            .colorScheme
                                            .onBackground)),
                            Text("⚈  8 minimum character",
                                style: TextStyle(
                                    color: contains8Length
                                        ? Colors.green
                                        : Theme.of(context)
                                            .colorScheme
                                            .onBackground)),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: MyTextField(
                        controller: _username,
                        hintText: 'Name',
                        obscureText: false,
                        keyboardType: TextInputType.name,
                        prefixIcon: const Icon(CupertinoIcons.person_fill),
                        validator: (val) {
                          if (val!.isEmpty) {
                            return 'Please fill in this field';
                          } else if (val.length > 30) {
                            return 'Name too long';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                    state is SignUpLoading
                        ? const CircularProgressIndicator()
                        : SizedBox(
                            width: MediaQuery.of(context).size.width * 0.5,
                            child: TextButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  context.read<AuthBloc>().add(SignUpRequested(
                                      email: _email.text,
                                      password: _password.text,
                                      username: _username.text));
                                }
                              },
                              style: TextButton.styleFrom(
                                elevation: 3.0,
                                backgroundColor:
                                    Theme.of(context).colorScheme.primary,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(60),
                                ),
                              ),
                              child: const Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 25, vertical: 5),
                                child: Text(
                                  'Sign Up',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
