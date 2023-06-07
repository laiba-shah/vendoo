part of 'message_screen_bloc.dart';


abstract class MessageScreenEvent {}

enum MessageType { text, image, emoji }

class SendMessageScreenEvent extends MessageScreenEvent {
  // final ChatUser user;
  // final String message;
  // final Type type;

  // SendMessageScreenEvent({
  //   required this.user,
  //   required this.message,
  //   required this.type,
  // });

  // String? get text => null;
}

class LoadMessagesEvent extends MessageScreenEvent {
  // ChatUser? get user => null;
}

class ToggleEmojiVisibilityEvent extends MessageScreenEvent {}

class PickImageFromGalleryEvent extends MessageScreenEvent {}

class PickImageFromCameraEvent extends MessageScreenEvent {}

class MessageErrorEvent extends MessageScreenEvent {
  // final String message;

  // MessageErrorEvent(this.message);

  // @override
  // List<Object?> get props => [message];
}
