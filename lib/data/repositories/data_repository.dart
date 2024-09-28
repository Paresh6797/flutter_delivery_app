import '../../core/constants/constant_text.dart';
import '../model/week_offer.dart';

class DataRepository {

  Future<List<WeekOfferInfo>> weeklyOffersRepository() async {
    return itemsWeekOffers;
  }

  Future<List<String>> foodItemRepository() async {
    return foodItem;
  }

  Future<List<WeekOfferInfo>> foodItemsVertRepository() async {
    return itemsWeekOffers.reversed.toList();
  }
}
