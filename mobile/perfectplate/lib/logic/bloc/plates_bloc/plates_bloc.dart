import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:perfectplate/data/models/meals/plates.dart';
import 'package:perfectplate/data/repositories/plates_repository.dart';

part 'plates_event.dart';
part 'plates_state.dart';

class PlatesBloc extends Bloc<PlatesEvent, PlatesState> {
  int? _userId;
  final PlatesRepository _repository = PlatesRepository();

  PlatesBloc() : super(MealsInitial()) {
    on<UserAuthenticated>(_onUserAuthenticated);
    on<PlateInsertionStartedEvent>(_onPlateInsertionStarted);
  }

  void _onUserAuthenticated(UserAuthenticated event, _) {
    _userId = event.userId;
  }

  Future<void> _onPlateInsertionStarted(PlateInsertionStartedEvent event, _) async {
    int? plateId = await _repository.insertPlate(
      Plate(_userId!, 'Teste pelo flutter', DateTime.now())
    );

    print('plateId = $plateId');

  }

  int? get userId => _userId;
}
