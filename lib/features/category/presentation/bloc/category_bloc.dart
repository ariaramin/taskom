import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskom/di/di.dart';
import 'package:taskom/features/category/domain/usecase/get_all_categories.dart';
import 'package:taskom/features/category/presentation/bloc/category_event.dart';
import 'package:taskom/features/category/presentation/bloc/category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final GetAllCategories _getAllCategories = locator.get();

  CategoryBloc() : super(CategoryInitState()) {
    on<CategoryListRequestEvent>(
      (event, emit) async {
        emit(CategoryLoadingState());
        var categoryList = await _getAllCategories.call(null);
        emit(CategoryListResponse(categoryList: categoryList));
      },
    );
  }
}
