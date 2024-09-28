import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../data/model/week_offer.dart';
import '../../../data/repositories/data_repository.dart';

part 'food_items_vertical_state.dart';

class FoodItemsVerticalCubit extends Cubit<FoodItemsVerticalState> {
  FoodItemsVerticalCubit() : super(FoodItemsVerticalInitial()) {
    foodItemVertical();
  }

  DataRepository dataRepository = DataRepository();

  void foodItemVertical() async {
    if (isClosed) return;
    try {
      emit(FoodItemsVerticalLoading());
      List<WeekOfferInfo> list = await dataRepository.foodItemsVertRepository();
      if (!isClosed) {
        emit(FoodItemsVerticalLoaded(list));
      }
    } catch (ex) {
      if (!isClosed) {
        emit(FoodItemsVerticalError('something went wrong'));
      }
    }
  }
}
