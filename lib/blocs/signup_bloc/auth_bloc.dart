import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:moody/blocs/signup_bloc/auth_event.dart';
import 'package:moody/blocs/signup_bloc/auth_state.dart';
import 'package:moody/repositories/auth_repository.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;
  final storage = const FlutterSecureStorage();

  AuthBloc(this.authRepository) : super(SignUpInitial()) {
    on<SignUpRequested>(_onSignup);
    on<SignInEvent>(_onSignin);
  }

  Future<void> _onSignup(SignUpRequested event, Emitter<AuthState> emit) async {
    try {
      // emit(SignupLoading());
      await AuthRepository().signUp(
        email: event.email,
        password: event.password,
        username: event.username,
      );
      emit(SignUpLoading());
      emit(SignUpSuccess());
    } catch (e) {
      emit(SignUpFailure(error: e.toString().replaceAll('Exception: ', '')));
    }
  }

  Future<void> _onSignin(SignInEvent event, Emitter<AuthState> emit) async {
    try {
      // emit(SignupLoading());
      await AuthRepository().signInUser(
        username: event.username,
        password: event.password,
      );

      String? storedToken = await storage.read(key: "accesstoken");
      if (storedToken != null) {
        emit(SignInLoading());
        emit(SignInSuccess());
      }
    } catch (e) {
      emit(SignInFailure(error: e.toString()));
    }
  }
}
