part of 'food_items_vertical_cubit.dart';

@immutable
sealed class FoodItemsVerticalState {}

final class FoodItemsVerticalInitial extends FoodItemsVerticalState {}

final class FoodItemsVerticalLoading extends FoodItemsVerticalState {}

final class FoodItemsVerticalLoaded extends FoodItemsVerticalState {
  final List<WeekOfferInfo> foodItems;

  FoodItemsVerticalLoaded(this.foodItems);
}

final class FoodItemsVerticalError extends FoodItemsVerticalState {
  final String error;

  FoodItemsVerticalError(this.error);
}

