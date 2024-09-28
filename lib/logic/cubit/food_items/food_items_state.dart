part of 'food_items_cubit.dart';

@immutable
sealed class FoodItemsState {}

final class FoodItemsInitial extends FoodItemsState {}

final class FoodItemsLoading extends FoodItemsState {}

final class FoodItemsLoaded extends FoodItemsState {
  final List<String> foodItems;

  FoodItemsLoaded(this.foodItems);
}

final class FoodItemsError extends FoodItemsState {
  final String error;

  FoodItemsError(this.error);
}
