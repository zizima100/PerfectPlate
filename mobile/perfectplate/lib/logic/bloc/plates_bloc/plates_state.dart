part of 'plates_bloc.dart';

abstract class PlatesState {}

class MealsInitial extends PlatesState {}

class PlatesInserted extends PlatesState {}

class PlatesInsertionFail extends PlatesState {}

class PlatesNameEmpty extends PlatesState {}

class PlateIngredientsEmpty extends PlatesState {}

class NumberOfPortionsEmpty extends PlatesState {}

class PlateInsertionLoading extends PlatesState {}