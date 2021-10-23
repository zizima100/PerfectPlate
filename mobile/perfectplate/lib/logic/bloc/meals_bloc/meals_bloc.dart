import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:perfectplate/data/models/meals/plates.dart';
import 'package:perfectplate/data/repositories/meals_repository.dart';

part 'meals_event.dart';
part 'meals_state.dart';

class MealsBloc extends Bloc<MealsEvent, MealsState> {
  int? _userId;
  MealsRepository _repository = MealsRepository();

  MealsBloc() : super(MealsInitial()) {
    on<UserAuthenticated>(_onUserAuthenticated);
    on<MealsInsertionStarted>(_onMealsInsertionStarted);
  }

  void _onUserAuthenticated(UserAuthenticated event, _) {
    _userId = event.userId;
  }

  Future<void> _onMealsInsertionStarted(MealsInsertionStarted event, _) async {
    int? plateId = await _repository.insertPlate(
      Plate(_userId!, 'Teste pelo flutter', DateTime.now())
    );

    print('plateId = $plateId');

  }

  int? get userId => _userId;
}
