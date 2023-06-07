part of 'login_bloc.dart';

abstract class LoginState{
  const LoginState();
  
  @override
  List<Object> get props => [];
}

abstract class LoginActionState extends LoginState{}

class LoginInitial extends LoginState {}

class LoginSubmittedInfoState extends LoginState{}

// class LoadingSubmitState extends LoginState {}

// class SuccessfulSubmitState extends LoginState {}

// class ErrorSubmitState extends LoginState{}

class SignUpPageNavigateState extends LoginActionState {}