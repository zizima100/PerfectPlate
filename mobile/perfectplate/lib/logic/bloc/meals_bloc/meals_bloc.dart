import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'meals_event.dart';
part 'meals_state.dart';

class MealsBloc extends Bloc<MealsEvent, MealsState> {
  int? _userId;

  MealsBloc() : super(MealsInitial()) {
    on<UserAuthenticated>(_onUserAuthenticated);
  }

  void _onUserAuthenticated(UserAuthenticated event, _) {
    _userId = event.userId;
  }

  int? get userId => _userId;
}
