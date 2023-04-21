import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import 'package:taskom/config/components/app_button.dart';
import 'package:taskom/config/constants/constants.dart';
import 'package:taskom/features/authentication/data/util/auth_manager.dart';
import 'package:taskom/features/category/presentation/bloc/category_bloc.dart';
import 'package:taskom/features/category/presentation/bloc/category_event.dart';
import 'package:taskom/features/task/data/models/gallery.dart';
import 'package:taskom/features/task/data/models/task.dart';
import 'package:taskom/features/task/domain/params/task_params.dart';
import 'package:taskom/features/task/presentation/bloc/task/task_bloc.dart';
import 'package:taskom/features/task/presentation/bloc/task/task_event.dart';
import 'package:taskom/features/task/presentation/bloc/task/task_state.dart';
import 'package:taskom/features/task/presentation/bloc/task_detail/task_detail_bloc.dart';
import 'package:taskom/features/task/presentation/bloc/task_detail/task_detail_event.dart';
import 'package:taskom/features/task/presentation/widgets/appbar_title.dart';
import 'package:taskom/features/task/presentation/widgets/task_category_list.dart';
import 'package:taskom/features/task/presentation/widgets/task_datetime.dart';
import 'package:taskom/features/task/presentation/widgets/task_form_textfields.dart';
import 'package:taskom/features/task/presentation/widgets/task_image_list.dart';

class TaskBody extends StatefulWidget {
  final TaskModel? taskModel;
  const TaskBody({super.key, this.taskModel});

  @override
  State<TaskBody> createState() => _TaskBodyState();
}

class _TaskBodyState extends State<TaskBody> {
  final TextEditingController _titleEditingController = TextEditingController();
  final TextEditingController _noteEditingController = TextEditingController();
  bool _titleHasError = false;
  String _selectedCategoryId = "";
  TimeOfDay _selectedTime = TimeOfDay.now();
  Jalali _selectedDate = Jalali.now();
  late Gallery _selectedImage;

  @override
  void initState() {
    BlocProvider.of<CategoryBloc>(context).add(CategoryListRequestEvent());
    BlocProvider.of<TaskDetailBloc>(context).add(TaskImageListRequestEvent());
    _setTaskData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        CustomScrollView(
          slivers: [
            const SliverToBoxAdapter(
              child: AppBarTitle(title: "تسکام"),
            ),
            SliverToBoxAdapter(
              child: TaskFormTextFields(
                titleEditingController: _titleEditingController,
                noteEditingController: _noteEditingController,
                titleHasError: _titleHasError,
              ),
            ),
            SliverToBoxAdapter(
              child: TaskCategoryList(
                currentCategoryId: widget.taskModel?.categoryId,
                onCategoryTaped: (String selectedCategoryId) {
                  _selectedCategoryId = selectedCategoryId;
                },
              ),
            ),
            SliverToBoxAdapter(
              child: TaskDatetime(
                currentDate: _selectedDate,
                currentTime: _selectedTime,
                onDateChanged: (selectedDate) {
                  _selectedDate = selectedDate;
                },
                onTimeChanged: (selectedTime) {
                  _selectedTime = selectedTime;
                },
              ),
            ),
            SliverToBoxAdapter(
              child: TaskImageList(
                currentImage: widget.taskModel?.thumbnail,
                onImageTaped: (Gallery selectedImage) {
                  _selectedImage = selectedImage;
                },
              ),
            ),
            const SliverPadding(padding: EdgeInsets.only(bottom: 82)),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: 14,
            right: 14,
            bottom: 18,
          ),
          child: BlocConsumer<TaskBloc, TaskState>(
            listener: (context, state) {
              if (state is TaskResponse) {
                state.task.fold((failure) {
                  final snackBar = Constants.getSnackBar(
                    title: Constants.ERROR_MESSAGE,
                    message: failure.message,
                    type: ContentType.failure,
                  );
                  ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(snackBar);
                }, (response) {
                  final snackBar = Constants.getSnackBar(
                    title: Constants.SUCCESS_MESSAGE,
                    message: response,
                    type: ContentType.success,
                  );
                  ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(snackBar);
                  Navigator.pop(context);
                });
              }
            },
            builder: (context, state) {
              return AppButton(
                text: "ثبت",
                isLoading: state is TaskLoadingState ? true : false,
                onPressed: () => _saveTask(),
              );
            },
          ),
        ),
      ],
    );
  }

  _saveTask() {
    if (_titleEditingController.text.isNotEmpty &&
        _selectedCategoryId.isNotEmpty) {
      setState(() {
        _titleHasError = false;
      });
      var task = _getNewTask();
      if (widget.taskModel != null) {
        BlocProvider.of<TaskBloc>(context).add(
            UpdateTaskRequestEvent(taskParams: TaskParams(taskModel: task)));
      } else {
        BlocProvider.of<TaskBloc>(context)
            .add(AddTaskRequestEvent(taskParams: TaskParams(taskModel: task)));
      }
    } else {
      setState(() {
        _titleHasError = true;
      });
    }
  }

  TaskModel _getNewTask() {
    return TaskModel(
      id: widget.taskModel?.id,
      userId: AuthManager.getUserId(),
      title: _titleEditingController.text,
      note: _noteEditingController.text,
      categoryId: _selectedCategoryId,
      thumbnail: _selectedImage.image,
      dateTime: DateTime(
          _selectedDate.toGregorian().year,
          _selectedDate.toGregorian().month,
          _selectedDate.toGregorian().day,
          _selectedTime.hour,
          _selectedTime.minute),
      isDone: widget.taskModel?.isDone ?? false,
    );
  }

  _setTaskData() {
    if (widget.taskModel != null) {
      _titleEditingController.value = TextEditingValue(
        text: widget.taskModel!.title!,
      );
      _noteEditingController.value = TextEditingValue(
        text: widget.taskModel!.note!,
      );
      var date = widget.taskModel!.dateTime!;
      setState(() {
        _selectedDate = date.toJalali();
        _selectedTime = TimeOfDay(
          hour: date.hour,
          minute: date.minute,
        );
      });
    }
  }
}
