import 'package:bloc/bloc.dart';

part 'newroom_event.dart';
part 'newroom_state.dart';

class NewroomBloc extends Bloc<NewroomEvent, NewroomState> {
  NewroomBloc() : super(NewroomInitial()) {
    on<NewroomEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
