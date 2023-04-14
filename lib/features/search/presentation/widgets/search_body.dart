import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskom/config/components/task_list.dart';
import 'package:taskom/config/constants/constants.dart';
import 'package:taskom/features/search/presentation/bloc/search_bloc.dart';
import 'package:taskom/features/search/presentation/bloc/search_event.dart';
import 'package:taskom/features/search/presentation/bloc/search_state.dart';
import 'package:taskom/features/search/presentation/widgets/custom_back_button.dart';
import 'package:taskom/features/search/presentation/widgets/search_field.dart';

class SearchBody extends StatefulWidget {
  const SearchBody({super.key});

  @override
  State<SearchBody> createState() => _SearchBodyState();
}

class _SearchBodyState extends State<SearchBody> {
  @override
  void initState() {
    _getData("");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 18),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const CustomBackButton(),
                Expanded(
                  child: SearchField(
                    onChange: (value) {
                      _getData(value);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        BlocBuilder<SearchBloc, SearchState>(
          builder: (context, state) {
            if (state is SearchLoadingState) {
              return const SliverFillRemaining(
                child: Center(
                  child: SizedBox(
                    width: 32,
                    height: 32,
                    child: CircularProgressIndicator(),
                  ),
                ),
              );
            }
            if (state is SearchResponseState) {
              return state.taskList.fold(
                (failure) {
                  return SliverToBoxAdapter(
                    child: Center(child: Text(failure.message)),
                  );
                },
                (response) {
                  return response.isEmpty
                      ? const SliverToBoxAdapter(
                          child: Center(
                            child: Text(Constants.NO_TASK_MESSAGE),
                          ),
                        )
                      : TaskList(taskList: response);
                },
              );
            }
            return const SliverFillRemaining();
          },
        ),
      ],
    );
  }

  _getData(String text) {
    BlocProvider.of<SearchBloc>(context).add(SearchRequest(text: text));
  }
}
