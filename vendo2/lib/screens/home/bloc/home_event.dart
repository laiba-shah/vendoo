part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class HomeInitialEvent extends HomeEvent{}

class HomepageLoginButtonNavigateEvent extends HomeEvent{}

class HomepageSignUpButtonNavigateEvent extends HomeEvent{}

class HomepageChatButtonNavigateEvent extends HomeEvent{}