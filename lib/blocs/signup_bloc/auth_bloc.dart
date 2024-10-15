import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:moody/blocs/blocs.dart';
import 'package:moody/repositories/auth.dart';
import 'package:flutter/widgets.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;
  final storage = const FlutterSecureStorage();

  AuthBloc(this.authRepository) : super(SignUpInitial()) {
    on<SignUpRequested>(_onSignup);
    on<SignInEvent>(_onSignin);
    on<LoadUsersEvent>(_onLoadUser);
    on<LogoutUserEvent>(_onLogoutUser);
    on<ChangePasswordEvent>(_onChangePassword);
  }

  // Sign Up Event
  Future<void> _onSignup(SignUpRequested event, Emitter<AuthState> emit) async {
    try {
      emit(SignUpLoading()); // ส่ง state loading ก่อน

      // Call the signUp method and get the user
      final user = await authRepository.signUp(
        email: event.email,
        password: event.password,
        username: event.username,
      );

      emit(SignUpSuccess(user: user));
    } catch (e) {
      emit(SignUpFailure(error: e.toString().replaceAll('Exception: ', '')));
    }
  }

  // Sign In Event
  Future<void> _onSignin(SignInEvent event, Emitter<AuthState> emit) async {
    try {
      emit(SignInLoading()); // ส่ง state loading ก่อน

      // Call the signInUser method and get the user
      final user = await authRepository.signInUser(
        username: event.username,
        password: event.password,
      );

      // Check if the token is stored successfully
      String? storedToken = await storage.read(key: "accesstoken");
      if (storedToken != null) {
        emit(SignInSuccess(user: user)); // Emit success state with user
      } else {
        emit(SignInFailure(error: "Token not found"));
      }
    } catch (e) {
      emit(SignInFailure(error: e.toString()));
    }
  }

  // Load User Event
  Future<void> _onLoadUser(
      LoadUsersEvent event, Emitter<AuthState> emit) async {
    try {
      emit(UserLoading()); // Emit loading state

      // Get the User object from the repository
      final user = await authRepository.getMeUser();

      debugPrint("loadsuccess: ${user.toString()}");
      emit(ReadyUserState(user: user)); // Emit UserSuccess with the User object
    } catch (e) {
      debugPrint("loadfail: ${e.toString()}");
      emit(UserFailure(error: e.toString())); // Emit UserFailure with error
    }
  }

  Future<void> _onLogoutUser(
      LogoutUserEvent event, Emitter<AuthState> emit) async {
    emit(UserLoading()); // แสดงสถานะโหลด
    try {
      await authRepository.logoutUser();
      emit(UserInitial()); // ส่งสถานะเริ่มต้นหลังจากออกจากระบบ
    } catch (e) {
      emit(UserFailure(error: e.toString())); // ส่งข้อผิดพลาด
    }
  }

  Future<void> _onChangePassword(
      ChangePasswordEvent event, Emitter<AuthState> emit) async {
    try {
      emit(UserLoading()); // Emit loading state

      // Call updatePassword method in the repository
      await authRepository.updatePassword(
        currentPassword: event.currentPassword,
        newPassword: event.newPassword,
      );

      // Fetch updated user data
      final updatedUser = await authRepository.getMeUser();
      emit(ReadyUserState(
          user: updatedUser)); // Emit success state with updated user

      emit(UserSuccess(message: 'Password changed successfully'));

      await Future.delayed(const Duration(seconds: 2));
      emit(UserInitial()); // Reset to initial state
      await Future.delayed(const Duration(seconds: 1));

      emit(UserSuccess(
          message:
              'Password changed successfully')); // Emit success with welcome message
      add(LoadUsersEvent()); // Reload the user
    } catch (e) {
      emit(UserFailure(error: e.toString())); // Emit failure if error occurs
    }
  }
}
