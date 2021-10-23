part of 'meals_bloc.dart';

abstract class MealsState extends Equatable {
  const MealsState();
  
  @override
  List<Object> get props => [];
}

class MealsInitial extends MealsState {}
