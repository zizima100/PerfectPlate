import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:perfectplate/core/exceptions/auth_exceptions.dart';
import 'package:perfectplate/core/utils/plate_utils.dart';
import 'package:perfectplate/data/models/plates/plates.dart';
import 'package:perfectplate/data/repositories/plates_repository.dart';

part 'plates_event.dart';
part 'plates_state.dart';

class PlatesBloc extends Bloc<PlatesEvent, PlatesState> {
  int? _userId;
  final PlatesRepository _repository = PlatesRepository();

  PlatesBloc() : super(MealsInitial()) {
    on<UserAuthenticated>(_onUserAuthenticated);
    on<PlateInsertedEvent>(_onPlateInsertionStarted);
  }

  void _onUserAuthenticated(UserAuthenticated event, _) {
    _userId = event.userId;
  }

  Future<void> _onPlateInsertionStarted(
    PlateInsertedEvent event, 
    Emitter<PlatesState> emit
  ) async {
    try {
      emit(PlateInsertionLoading());
      _validatePlate(event.plate);
      await _insertPlate(event.plate);
      emit(PlatesInserted());
    } on PlateNameEmptyException {
      emit(PlatesNameEmpty());
    } on PlatesIngredientsEmptyException {
      emit(PlateIngredientsEmpty());
    } on NumberOfPortionsEmptyException {
      emit(NumberOfPortionsEmpty());
    } on Exception {
      emit(PlatesInsertionFail());
    }
  }

  void _validatePlate(Plate plate) {
    if(plate.name.isEmpty) {
      throw PlateNameEmptyException();
    } if(plate.plateIngredients.isEmpty) {
      throw PlatesIngredientsEmptyException();
    }
    for (var ingredient in plate.plateIngredients) {
      if(ingredient.numberOfPortions == null) {
        throw NumberOfPortionsEmptyException();
      }
    }
  }

  Future<void> _insertPlate(Plate plate) async {
    int? plateId = await _repository.insertPlate(
        RawPlate(userId: _userId!, name: plate.name, date: plate.date));

    for (var plateIngredient in plate.plateIngredients) {
      await _repository.insertPlateIngredient(
        RawPlateIngredient(
          ingredientId: plateIngredient.ingredientId!,
          plateId: plateId!,
          numberOfPortions: plateIngredient.numberOfPortions!,
        ),
      );
    }
  }

  Future<List<Ingredient>> retrieveAllIngredients() async {
    List<RawIngredient>? ingredients =
        await _repository.retrieveAllIngredients();

    if (ingredients == null) {
      throw Exception();
    }

    return ingredients.map((i) {
      return Ingredient(
        id: i.id,
        name: i.name,
        classification: PlateUtils.parseStringEnumToEnum(i.classification),
        onePortionQuantity: i.onePortionWeight,
      );
    }).toList();
  }
}
