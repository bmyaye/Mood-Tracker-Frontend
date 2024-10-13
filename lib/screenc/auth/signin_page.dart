import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../components/components.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moody/blocs/signup_bloc/auth_app.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  final storage = const FlutterSecureStorage();

  IconData iconPassword = CupertinoIcons.eye_fill;
  bool obscurePassword = true;
  String? errorMsg;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(listener: (context, state) {
      if (state is SignInSuccess) {
        debugPrint('Signin Success');
        Navigator.pushNamed(context, '/home');
      } else if (state is SignInFailure) {
        debugPrint("Signin Error: ${state.error}");
        CreateDialog().showErrorDialog(context, 'Invalid username or password');
      } else if (state is SignInLoading) {
        debugPrint('Signin Loading...');
      }
    }, builder: (context, state) {
      if (state is SignInLoading) {
        return const Loading();
      } else {
        return Center(
          child: Form(
            key: _formKey,
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
                    errorMsg: errorMsg,
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
                    obscureText: obscurePassword,
                    keyboardType: TextInputType.visiblePassword,
                    prefixIcon: const Icon(CupertinoIcons.lock_fill),
                    errorMsg: errorMsg,
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
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          obscurePassword = !obscurePassword;
                          iconPassword = obscurePassword
                              ? CupertinoIcons.eye_fill
                              : CupertinoIcons.eye_slash_fill;
                        });
                      },
                      icon: Icon(iconPassword),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: TextButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        context.read<AuthBloc>().add(SignInEvent(
                              username: _email.text,
                              password: _password.text,
                            ));
                      }
                    },
                    style: TextButton.styleFrom(
                      elevation: 3.0,
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(60),
                      ),
                    ),
                    child: const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                      child: Text(
                        'Sign In',
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
    });
  }
}
