import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learning_bloc/logic/logic.dart';
import 'package:learning_bloc/models/user_model.dart';
import 'package:learning_bloc/views/add_user_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    context.read<LogicalService>().add(ReadUserEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Display User"),
      ),
      body: _buildBody,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const AddUserView()));
        },
        child: const Text("Add"),
      ),
    );
  }

  Widget get _buildBody {
    return BlocBuilder<LogicalService, LogicState>(builder: (context, state) {
      if (state is AddUserLoading) {
        bool isLoading = state.isLoading;
        if (!isLoading) {
          context.read<LogicalService>().add(ReadUserEvent());
        }
      }
      if (state is LogicInitializeState || state is LogicLoadingState) {
        return const Center(child: CircularProgressIndicator());
      } else if (state is LogicErrorState) {
        String err = state.error;
        return Center(child: Text(err));
      } else if (state is ReadUserState) {
        var data = state.userModel;
        return _buildListView(data);
      } else {
        return Container();
      }
    });
  }

  Widget _buildListView(List<UserModel> data) {
    return RefreshIndicator(
      onRefresh: () async {
        context.read<LogicalService>().add(ReadUserEvent());
      },
      child: ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(data[index].email),
            subtitle: Text(
              data[index].username,
            ),
          );
        },
      ),
    );
  }
}
