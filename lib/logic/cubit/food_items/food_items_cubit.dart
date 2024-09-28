import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../data/repositories/data_repository.dart';

part 'food_items_state.dart';

class FoodItemsCubit extends Cubit<FoodItemsState> {
  FoodItemsCubit() : super(FoodItemsInitial()){
    foodItems();
  }

  DataRepository dataRepository = DataRepository();

  void foodItems() async {
    if (isClosed) return;
    try {
      emit(FoodItemsLoading());
      List<String> list = await dataRepository.foodItemRepository();
      if (!isClosed) {
        emit(FoodItemsLoaded(list));
      }
    } catch (ex) {
      if (!isClosed) {
        emit(FoodItemsError('something went wrong'));
      }
    }
  }
}