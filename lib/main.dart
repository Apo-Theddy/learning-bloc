import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learning_bloc/logic/logic.dart';
import 'package:learning_bloc/services/service.dart';
import 'package:learning_bloc/views/home_view.dart';

void main() {
  RestAPIService _service = RestAPIService();
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider<LogicalService>(
          create: (context) => LogicalService(_service))
    ],
    child:
        const MaterialApp(debugShowCheckedModeBanner: false, home: HomeView()),
  ));
}
