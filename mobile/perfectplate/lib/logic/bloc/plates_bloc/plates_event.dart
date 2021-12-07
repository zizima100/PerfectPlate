part of 'plates_bloc.dart';

abstract class PlatesEvent extends Equatable {}

class PlateInsertedEvent extends PlatesEvent {
  final PlateDAO plate;
  PlateInsertedEvent(this.plate);

  @override
  List<Object?> get props => [];
}
