part of 'meals_bloc.dart';

abstract class MealsEvent extends Equatable {}

class UserAuthenticated extends MealsEvent {
  final int userId;

  UserAuthenticated({required this.userId});

  @override
  List<Object?> get props => [userId];
}
