import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repositories/data_repository.dart';
import '../../logic/cubit/add_count/add_count_cubit.dart';
import '../../logic/cubit/cart_item/add_to_cart_cubit.dart';
import '../../logic/cubit/food_items/food_items_cubit.dart';
import '../../logic/cubit/food_items_vertical/food_items_vertical_cubit.dart';
import '../../logic/cubit/week_offer/week_offer_cubit.dart';
import 'app.dart';

class BlocAndRepositoryProvider extends StatelessWidget {
  const BlocAndRepositoryProvider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
        providers: [
          RepositoryProvider(
            create: (context) => DataRepository(),
          ),
        ],
        child: MultiBlocProvider(providers: [
          BlocProvider(create: (_) => WeekOfferCubit()),
          BlocProvider(create: (_) => FoodItemsCubit()),
          BlocProvider(create: (_) => FoodItemsVerticalCubit()),
          BlocProvider(create: (_) => AddCountCubit()),
          BlocProvider(create: (_) => AddToCartCubit()),
        ], child: const App()));
  }
}
