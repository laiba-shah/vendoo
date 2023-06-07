part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();
  
  @override
  List<Object> get props => [];
}

abstract class HomeActionState extends HomeState{}

class HomeInitial extends HomeState {}

class HomeLoadedSuccessState extends HomeState{}

class HomeLoadingState extends HomeState{}

class HomeErrorState extends HomeState{}

class HomeLoginPageNavigateActionState extends HomeActionState{
}

class HomeSignPageUpNavigateActionState extends HomeActionState{}

class HomeChatPageNavigateActionState extends HomeActionState{}

