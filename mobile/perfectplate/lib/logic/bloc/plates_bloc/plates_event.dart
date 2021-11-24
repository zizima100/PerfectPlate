part of 'plates_bloc.dart';

abstract class PlatesEvent extends Equatable {}

class UserAuthenticated extends PlatesEvent {
  final int userId;

  UserAuthenticated({required this.userId});

  @override
  List<Object?> get props => [userId];
}

class PlateInsertedEvent extends PlatesEvent {
  final Plate plate;
  PlateInsertedEvent(this.plate);
  
  @override
  List<Object?> get props => [];
}
