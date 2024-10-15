import 'package:equatable/equatable.dart';

sealed class MoodEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class MoodAddedEvent extends MoodEvent {
  final String moodType;
  final String description;
  final int userId;

  MoodAddedEvent({
    required this.moodType,
    required this.description,
    required this.userId,
  });
}
