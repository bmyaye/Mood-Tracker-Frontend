import 'package:equatable/equatable.dart';

abstract class AuthState extends Equatable {
  final User? user;
  final String message;
  final List<User> usersList;

  AuthState({this.user, this.message = ' ', this.usersList = const []});

  @override
  List<Object?> get props => [user]; // รวม user ใน props
}

class User extends Equatable {
  final String username;
  final String email;

  const User({required this.username, required this.email});

  factory User.fromMap(Map<String, dynamic> json) {
    return User(
      username: json['username'],
      email: json['email'],
    );
  }

  @override
  List<Object?> get props => [username, email];

  static empty() {}
}

// สถานะเริ่มต้นเมื่อทำงานครั้งแรก
class SignUpInitial extends AuthState {
  @override
  List<Object?> get props => []; // props ว่าง
}

// สถานะเมื่ออยู่ระหว่างการทำงาน
class SignUpLoading extends AuthState {
  @override
  List<Object?> get props => []; // props ว่าง
}

// สถานะเมื่อการสมัครสำเร็จและต้องการเก็บข้อมูล user
class SignUpSuccess extends AuthState {
  SignUpSuccess({required User user})
      : super(user: user); // รับ user เป็น parameter

  @override
  List<Object?> get props => [user]; // รวม user ใน props
}

// สถานะเมื่อการสมัครล้มเหลว
class SignUpFailure extends AuthState {
  final String error;

  SignUpFailure({required this.error});

  @override
  List<Object?> get props => [error];
}

// สถานะเมื่อเข้าสู่ระบบสำเร็จ
class SignInSuccess extends AuthState {
  SignInSuccess({required User user})
      : super(user: user); // รับ user เป็น parameter

  @override
  List<Object?> get props => [user];
}

class SignInLoading extends AuthState {
  @override
  List<Object?> get props => []; // props ว่าง
}

class SignInFailure extends AuthState {
  final String error;

  SignInFailure({required this.error});

  @override
  List<Object?> get props => [error];
}

// สถานะเมื่อดึงข้อมูลผู้ใช้สำเร็จ
class UserSuccess extends AuthState {
  UserSuccess({required super.message}) : super(user: User.empty());

  @override
  List<Object?> get props => [user];
}

class UserInitial extends AuthState {
  @override
  List<Object?> get props => []; // props ว่าง
}

// สถานะเมื่อดึงข้อมูลผู้ใช้อยู่
class UserLoading extends AuthState {
  @override
  List<Object?> get props => []; // props ว่าง
}

// สถานะเมื่อการดึงข้อมูลผู้ใช้ล้มเหลว
class UserFailure extends AuthState {
  final String error;

  UserFailure({required this.error});

  @override
  List<Object?> get props => [error];
}

class ReadyUserState extends AuthState {
  ReadyUserState({required super.user, super.usersList});
}

class AllUsersLoaded extends AuthState {
  AllUsersLoaded({required super.user, required super.usersList});
}
