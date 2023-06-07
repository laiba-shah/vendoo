import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'message_screen_event.dart';
part 'message_screen_state.dart';

class MessageScreenBloc extends Bloc<MessageScreenEvent, MessageScreenState> {
  MessageScreenBloc() : super(MessageInitial()) {
    on<SendMessageScreenEvent>((event, emit) {
      emit(MessageSentState());
    });
    on<ToggleEmojiVisibilityEvent>((event, emit) {
      emit(EmojiVisibilityState());
    });
    on<MessageErrorEvent>((event, emit) {
      emit((MessageErrorState()));
    });
  }
}
