import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class SignUpRequested extends AuthEvent {
  final String email;
  final String password;
  final String username;

  SignUpRequested(
      {required this.email, required this.password, required this.username});

  @override
  List<Object?> get props => [email, password, username];
}

class SignInEvent extends AuthEvent {
  final String username;
  final String password;

  SignInEvent({
    required this.username,
    required this.password,
  });
}
