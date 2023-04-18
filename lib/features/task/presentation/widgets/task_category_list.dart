import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:taskom/config/components/continuous_rectangle.dart';
import 'package:taskom/config/components/section_title.dart';
import 'package:taskom/features/category/presentation/bloc/category_bloc.dart';
import 'package:taskom/features/category/presentation/bloc/category_state.dart';

class TaskCategoryList extends StatefulWidget {
  const TaskCategoryList({super.key});

  @override
  State<TaskCategoryList> createState() => _TaskCategoryListState();
}

class _TaskCategoryListState extends State<TaskCategoryList> {
  int _selectedCategory = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 18),
      child: Column(
        children: [
          const SectionTitle(
            title: "دسته‌بندی تسک",
            visibleLeadingText: false,
          ),
          const SizedBox(
            height: 12,
          ),
          BlocBuilder<CategoryBloc, CategoryState>(
            builder: (context, state) {
              if (state is CategoryLoadingState) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is CategoryListResponse) {
                return state.categoryList.fold(
                  (failure) {
                    return Center(child: Text(failure.message));
                  },
                  (response) {
                    return SizedBox(
                      height: 88,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: response.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _selectedCategory = index;
                                });
                              },
                              child: Column(
                                children: [
                                  ContinuousRectangle(
                                    size: 56,
                                    backgroundColor:
                                        HexColor(response[index].color!),
                                    hasShadow: _selectedCategory == index,
                                    widget: Center(
                                      child: SvgPicture.network(
                                          response[index].icon!),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Text(
                                    response[index].title!,
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: _selectedCategory == index
                                          ? FontWeight.bold
                                          : FontWeight.normal,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                );
              }
              return const SizedBox();
            },
          ),
        ],
      ),
    );
  }
}
