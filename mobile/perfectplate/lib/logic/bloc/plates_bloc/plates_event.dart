part of 'plates_bloc.dart';

abstract class PlatesEvent extends Equatable {}

class UserAuthenticated extends PlatesEvent {
  final int userId;

  UserAuthenticated({required this.userId});

  @override
  List<Object?> get props => [userId];
}
