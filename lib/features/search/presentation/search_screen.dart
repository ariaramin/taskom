import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskom/features/search/presentation/bloc/search_bloc.dart';
import 'package:taskom/features/search/presentation/widgets/search_body.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchBloc(),
      child: const Scaffold(
        body: SafeArea(
          child: SearchBody(),
        ),
      ),
    );
  }
}
