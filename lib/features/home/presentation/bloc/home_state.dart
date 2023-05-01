import 'package:equatable/equatable.dart';
import 'package:taskom/features/authentication/presentation/bloc/auth/auth_state.dart';
import 'package:taskom/features/category/presentation/bloc/category_state.dart';

class HomeState extends Equatable {
  final AuthState authState;
  final CategoryState categoryState;

  const HomeState({
    required this.authState,
    required this.categoryState,
  });

  HomeState copyWith({
    AuthState? authState,
    CategoryState? categoryState,
  }) {
    return HomeState(
      authState: authState ?? this.authState,
      categoryState: categoryState ?? this.categoryState,
    );
  }

  @override
  List<Object?> get props => [authState, categoryState];
}
