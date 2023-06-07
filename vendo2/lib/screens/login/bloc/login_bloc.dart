import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginPageSignUpPageNavigateEvent>((event, emit) {
      emit(SignUpPageNavigateState());
    });
    on<LoginPageSubmitButtonPressedEvent>((event, emit) {
      emit(LoginSubmittedInfoState());
    });
  }
}
