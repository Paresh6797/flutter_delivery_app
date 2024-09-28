part of 'week_offer_cubit.dart';

@immutable
sealed class WeekOfferState {}

final class WeekOfferInitial extends WeekOfferState {}

final class WeekOfferLoading extends WeekOfferState {}

final class WeekOfferLoaded extends WeekOfferState {
  final List<WeekOfferInfo> weekOffers;

  WeekOfferLoaded(this.weekOffers);
}

final class WeekOfferError extends WeekOfferState {
  final String error;

  WeekOfferError(this.error);
}
