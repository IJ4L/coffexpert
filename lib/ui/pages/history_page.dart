// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables

import 'package:coffe_brain/cubit/history/history_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HistoryLoadedPage extends StatefulWidget {
  const HistoryLoadedPage({Key? key}) : super(key: key);

  @override
  State<HistoryLoadedPage> createState() => _HistoryLoadedState();
}

class _HistoryLoadedState extends State<HistoryLoadedPage> {
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard"),
        actions: const [],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(10.0),
          child: BlocConsumer<HistoryCubit, HistoryState>(
            listener: (context, state) {
              if (state is HistoryLoaded) {
                print('isi : ${state.history}');
              }
            },
            builder: (context, state) {
              return const Column(
                children: [],
              );
            },
          ),
        ),
      ),
    );
  }
}
