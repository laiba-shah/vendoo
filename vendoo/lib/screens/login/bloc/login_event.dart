part of 'login_bloc.dart';

abstract class LoginEvent {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

//not yet implemeted
class LoginPageSubmitButtonPressedEvent extends LoginEvent{}


class LoginPageSignUpPageNavigateEvent extends LoginEvent{}