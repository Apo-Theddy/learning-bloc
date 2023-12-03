import "package:bloc/bloc.dart";
import "package:flutter/material.dart";
import "package:learning_bloc/models/user_model.dart";
import "package:learning_bloc/services/service.dart";
import "package:learning_bloc/main.dart";

abstract class LogicState {}

abstract class LogicEvent {}

class LogicInitializeState extends LogicState {}

class LogicErrorState extends LogicState {
  final String error;
  LogicErrorState({required this.error});
}

class ReadUserState extends LogicState {
  final List<UserModel> userModel;
  ReadUserState(this.userModel);
}

class ReadUserEvent extends LogicEvent {}

class LogicLoadingState extends LogicState {}

class AddUserEvent extends LogicEvent {
  final String username;
  final String email;
  final BuildContext context;
  AddUserEvent(
      {required this.username, required this.email, required this.context});
}

class AddUserLoading extends LogicState {
  bool isLoading;
  AddUserLoading({required this.isLoading});
}

class LogicalService extends Bloc<LogicEvent, LogicState> {
  final RestAPIService _service;
  LogicalService(this._service) : super(LogicInitializeState()) {
    on<AddUserEvent>((event, emit) async {
      emit(AddUserLoading(isLoading: true));
      await _service.addUserService(event.email, event.username).then((value) {
        emit(AddUserLoading(isLoading: false));
        Future.delayed(const Duration(milliseconds: 500)).then((_) {
          Navigator.pop(event.context);
        });
      }).onError((error, stackTrace) {
        emit(LogicErrorState(error: error.toString()));
      });
    });

    on<ReadUserEvent>((event, emit) async {
      emit(LogicLoadingState());
      await _service.readUserService().then((value) {
        emit(ReadUserState(value));
      }).onError((error, stackTrace) {
        emit(LogicErrorState(error: error.toString()));
      });
    });
  }
}
