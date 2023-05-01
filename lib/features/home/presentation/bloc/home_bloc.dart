import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskom/di/di.dart';
import 'package:taskom/features/authentication/domain/usecase/get_user.dart';
import 'package:taskom/features/authentication/presentation/bloc/auth/auth_state.dart';
import 'package:taskom/features/category/presentation/bloc/category_state.dart';
import 'package:taskom/features/home/presentation/bloc/home_event.dart';
import 'package:taskom/features/home/presentation/bloc/home_state.dart';
import 'package:taskom/features/category/domain/usecase/get_all_categories.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetUser _getUser = locator.get();
  final GetAllCategories _getAllCategories = locator.get();

  HomeBloc()
      : super(HomeState(
          authState: AuthLoadingState(),
          categoryState: CategoryLoadingState(),
        )) {
    on<HomeDataRequestEvent>(
      (event, emit) async {
        emit(state.copyWith(
          authState: AuthLoadingState(),
          categoryState: CategoryLoadingState(),
        ));
        var user = await _getUser.call(null);
        var categoryList = await _getAllCategories.call(null);
        emit(state.copyWith(
          authState: UserResponseState(user),
          categoryState: CategoryListResponse(categoryList: categoryList),
        ));
      },
    );
  }
}
