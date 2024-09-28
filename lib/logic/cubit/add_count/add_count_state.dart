part of 'add_count_cubit.dart';

@immutable
sealed class AddCountState {}

final class AddCountInitial extends AddCountState {}

final class AddCountTotal extends AddCountState {
  final double estimateAmount;
  final int count;

  AddCountTotal(this.estimateAmount, this.count);
}