import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskom/config/components/cached_image.dart';
import 'package:taskom/config/components/section_title.dart';
import 'package:taskom/config/theme/app_colors.dart';
import 'package:taskom/features/task/data/models/gallery.dart';
import 'package:taskom/features/task/presentation/bloc/task_detail/task_detail_bloc.dart';
import 'package:taskom/features/task/presentation/bloc/task_detail/task_detail_state.dart';

class TaskImageList extends StatefulWidget {
  final String? currentImage;

  final Function(Gallery image) onImageTaped;

  const TaskImageList({
    super.key,
    this.currentImage,
    required this.onImageTaped,
  });

  @override
  State<TaskImageList> createState() => _TaskImageListState();
}

class _TaskImageListState extends State<TaskImageList> {
  int _selectedImage = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 18),
      child: Column(
        children: [
          const SectionTitle(
            title: "عکس تسک",
            visibleLeadingText: false,
          ),
          const SizedBox(height: 6),
          BlocConsumer<TaskDetailBloc, TaskDetailState>(
            listener: (context, state) {
              if (state is TaskImageListResponse) {
                state.imageList.fold((l) => null, (response) {
                  var currentIndex = response.indexWhere(
                      (element) => element.image == widget.currentImage);
                  setState(() {
                    currentIndex != -1
                        ? _selectedImage = currentIndex
                        : _selectedImage = 0;
                  });
                });
              }
            },
            builder: (context, state) {
              if (state is TaskDetailLoadingState) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is TaskImageListResponse) {
                return state.imageList.fold(
                  (failure) {
                    return Center(child: Text(failure.message));
                  },
                  (response) {
                    widget.onImageTaped(response[_selectedImage]);
                    return SizedBox(
                      height: 198,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: response.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                _selectedImage = index;
                              });
                              widget.onImageTaped(response[index]);
                            },
                            child: Container(
                              margin: const EdgeInsets.all(8),
                              padding: const EdgeInsets.all(10),
                              width: 162,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  width: 2,
                                  color: (_selectedImage == index)
                                      ? AppColors.primaryColor
                                      : Colors.transparent,
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child:
                                  CachedImage(imageUrl: response[index].image),
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
