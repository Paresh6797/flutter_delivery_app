import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../data/model/week_offer.dart';
import '../../../data/repositories/data_repository.dart';

part 'week_offer_state.dart';

class WeekOfferCubit extends Cubit<WeekOfferState> {
  WeekOfferCubit() : super(WeekOfferInitial()) {
    weeklyOffers();
  }

  DataRepository dataRepository = DataRepository();

  void weeklyOffers() async {
    if (isClosed) return;
    try {
      emit(WeekOfferLoading());
      List<WeekOfferInfo> list = await dataRepository.weeklyOffersRepository();
      if (!isClosed) {
        emit(WeekOfferLoaded(list));
      }
    } catch (ex) {
      if (!isClosed) {
        emit(WeekOfferError('something went wrong'));
      }
    }
  }
}
