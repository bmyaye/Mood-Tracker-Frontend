import 'package:equatable/equatable.dart';

abstract class AuthState extends Equatable {
  @override
  List<Object?> get props => [];
}

class SignUpInitial extends AuthState {}

class SignUpLoading extends AuthState {}

class SignUpSuccess extends AuthState {}

class SignUpFailure extends AuthState {
  final String error;

  SignUpFailure({required this.error});

  @override
  List<Object?> get props => [error];
}

class SignInSuccess extends AuthState {}

class SignInLoading extends AuthState {}

class SignInFailure extends AuthState {
  final String error;

  SignInFailure({required this.error});

  List<Object> get props => [error];
}
