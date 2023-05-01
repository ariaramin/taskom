import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskom/features/category/presentation/bloc/category_state.dart';
import 'package:taskom/features/home/presentation/bloc/home_bloc.dart';
import 'package:taskom/features/home/presentation/bloc/home_state.dart';
import 'package:taskom/features/home/presentation/widgets/category_list.dart';

class HomeCategoryList extends StatelessWidget {
  const HomeCategoryList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state.categoryState is CategoryLoadingState) {
          return const SliverToBoxAdapter(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        if (state.categoryState is CategoryListResponse) {
          var categoryState = state.categoryState as CategoryListResponse;
          return categoryState.categoryList.fold((failure) {
            return SliverToBoxAdapter(
              child: Center(child: Text(failure.message)),
            );
          }, (response) {
            return SliverPadding(
              padding: const EdgeInsets.only(top: 22),
              sliver: SliverToBoxAdapter(
                child: CategoryList(categoryList: response),
              ),
            );
          });
        }
        return const SliverToBoxAdapter(child: SizedBox());
      },
    );
  }
}
