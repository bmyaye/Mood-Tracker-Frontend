import 'package:bloc/bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:moody/blocs/blocs.dart';
import 'package:moody/repositories/mood.dart';

class MoodBloc extends Bloc<MoodEvent, MoodState> {
  final storage = const FlutterSecureStorage();
  final MoodRepository moodRepository;

  MoodBloc(this.moodRepository) : super(MoodInitial()) {
    on<MoodAddedEvent>(_moodadded);
  }

  Future<void> _moodadded(MoodAddedEvent event, Emitter<MoodState> emit) async {
    emit(MoodLoading()); // Emit loading state while processing

    try {
      // Call the repository to add the mood
      final message = await moodRepository.addMood(
        moodType: event.moodType,
        description: event.description,
        userId: event.userId,
      );

      // Emit success state with message
      emit(MoodSuccess(message: message));
    } catch (e) {
      // Emit failure state if something goes wrong
      emit(MoodFailure(error: e.toString()));
    }
  }
}
