part of 'add_to_cart_cubit.dart';

@immutable
sealed class AddToCartState {}

final class AddToCartInitial extends AddToCartState {}

final class AddToCartLoading extends AddToCartState {}

final class AddToCartTotal extends AddToCartState {
  final double estimateAmount;
  final List<SelectFood> cartItems;

  AddToCartTotal(this.estimateAmount, this.cartItems);
}
