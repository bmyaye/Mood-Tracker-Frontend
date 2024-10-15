import 'package:equatable/equatable.dart';

sealed class MoodState extends Equatable {
  const MoodState();

  @override
  List<Object> get props => [];
}

class MoodInitial extends MoodState {}

class MoodLoading extends MoodState {}

class MoodSuccess extends MoodState {
  final String message;
  MoodSuccess({required this.message});
}

class MoodFailure extends MoodState {
  final String error;
  MoodFailure({required this.error});
}
