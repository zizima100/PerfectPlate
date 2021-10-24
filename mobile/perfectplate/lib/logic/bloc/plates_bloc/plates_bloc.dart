import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:perfectplate/data/models/plates/plates.dart';
import 'package:perfectplate/data/repositories/plates_repository.dart';

part 'plates_event.dart';
part 'plates_state.dart';

class PlatesBloc extends Bloc<PlatesEvent, PlatesState> {
  int? _userId;
  final PlatesRepository _repository = PlatesRepository();

  PlatesBloc() : super(MealsInitial()) {
    on<UserAuthenticated>(_onUserAuthenticated);
  }

  void _onUserAuthenticated(UserAuthenticated event, _) {
    _userId = event.userId;
  }

  Future<void> insertPlate(Plate plate) async {
    int? plateId = await _repository.insertPlate(
        RawPlate(userId: _userId!, name: plate.name, date: plate.date));

    for (var plateIngredient in plate.plateIngredients) {
      await _repository.insertPlateIngredient(
        RawPlateIngredient(
          ingredientId: plateIngredient.ingredientId,
          plateId: plateId!,
          numberOfPortions: plateIngredient.numberOfPortions!,
        ),
      );
    }
  }
}
