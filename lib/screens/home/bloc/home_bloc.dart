import 'package:bloc/bloc.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<HomepageLoginButtonNavigateEvent>(
        (event, emit) { 
          emit(HomeLoginPageNavigateActionState());});
    on<HomepageSignUpButtonNavigateEvent>(
        (event, emit) => emit(HomeSignPageUpNavigateActionState()));
    on<HomepageChatButtonNavigateEvent>(
        (event, emit) => emit(HomeChatPageNavigateActionState()));


  }
}
