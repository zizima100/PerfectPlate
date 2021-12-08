import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:perfectplate/core/exceptions/auth_exceptions.dart';
import 'package:perfectplate/core/utils/plate_utils.dart';
import 'package:perfectplate/data/models/auth/auth_models.dart';
import 'package:perfectplate/data/models/ingredients/ingredients.dart';
import 'package:perfectplate/data/models/plates/plates.dart';
import 'package:perfectplate/data/models/plates/plates_list.dart';
import 'package:perfectplate/data/repositories/plates_repository_interface.dart';

part 'plates_event.dart';
part 'plates_state.dart';

class PlatesBloc extends Bloc<PlatesEvent, PlatesState> {
  final IPlatesRepository _repository;

  PlatesBloc(this._repository) : super(MealsInitial()) {
    on<PlateInsertedEvent>(_onPlateInsertionStarted);
  }

  Future<void> _onPlateInsertionStarted(
      PlateInsertedEvent event, Emitter<PlatesState> emit) async {
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

  void _validatePlate(PlateDAO plate) {
    if (plate.name.isEmpty) {
      throw PlateNameEmptyException();
    }
    if (plate.plateIngredients.isEmpty) {
      throw PlatesIngredientsEmptyException();
    }
    for (var ingredient in plate.plateIngredients) {
      print('checking = $ingredient');
      if (ingredient.numberOfPortions == null) {
        throw NumberOfPortionsEmptyException();
      }
    }
  }

  Future<void> _insertPlate(PlateDAO plateDAO) async {
    int? plateId = await _repository.insertPlate(RawPlate(
        userId: GetIt.I<User>().id!, name: plateDAO.name, date: plateDAO.date));

    print('plateId = $plateId');

    for (var plateIngredient in plateDAO.plateIngredients) {
      await _repository.insertPlateIngredient(
        RawPlateIngredient(
          ingredientId: plateIngredient.ingredientId!,
          plateId: plateId!,
          numberOfPortions: plateIngredient.numberOfPortions!,
        ),
      );
      print('plateIngredient inserted = $plateIngredient');
    }

    await _insertInGetItList(plateDAO);
  }

  Future<void> _insertInGetItList(PlateDAO plateDAO) async {
    List<RawIngredient>? allIngredients =
        await _repository.retrieveAllIngredients();
    List<Ingredient> ingredients = [];
    for (PlateIngredientDAO p in plateDAO.plateIngredients) {
      try {
        RawIngredient rawIngredient = allIngredients!
            .firstWhere((ingredient) => ingredient.id == p.ingredientId);
        ingredients.add(Ingredient.fromRaw(
          rawIngredient,
          p.numberOfPortions!,
        ));
      } on StateError catch (_) {
        continue;
      }
    }

    Plate plate = Plate(
        name: plateDAO.name, date: plateDAO.date, ingredients: ingredients);

    GetIt.I<PlatesList>().insert(plate);

    print('GetIt.I<PlatesList>().plates => ${GetIt.I<PlatesList>().plates}');
  }

  Future<List<IngredientDAO>> retrieveAllIngredients() async {
    List<RawIngredient>? ingredients =
        await _repository.retrieveAllIngredients();

    if (ingredients == null) {
      throw Exception();
    }

    return ingredients.map((i) {
      return IngredientDAO(
        id: i.id,
        name: i.name,
        classification: PlateUtils.parseStringEnumToEnum(i.classification),
        onePortionQuantity: i.onePortionWeight,
      );
    }).toList();
  }

  Future<void> mapAllUserPlates() async {
    print('mapAllUserPlates');
    List<Plate> plates = await _retrieveAllUserPlates();
    GetIt.I<PlatesList>().insertAll(plates);
    print('GetIt.I<PlatesList>().plates = ${GetIt.I<PlatesList>().plates}');
  }

  Future<List<Plate>> _retrieveAllUserPlates() async {
    print('_retrieveAllUserPlates');
    List<Plate>? plates =
        await _repository.retrieveAllUserPlates(GetIt.I<User>().id!);

    if (plates == null) {
      throw Exception();
    }

    return plates;
  }
}
