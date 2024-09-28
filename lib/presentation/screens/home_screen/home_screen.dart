import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/colors/app_colors.dart';
import '../../../core/constants/constant_text.dart';
import '../../../core/constants/font_weight.dart';
import '../../../data/model/week_offer.dart';
import '../../../logic/cubit/add_count/add_count_cubit.dart';
import '../../../logic/cubit/cart_item/add_to_cart_cubit.dart';
import '../../../logic/cubit/food_items_vertical/food_items_vertical_cubit.dart';
import '../../../logic/cubit/week_offer/week_offer_cubit.dart';
import '../../../logic/cubit/food_items/food_items_cubit.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/line_indicator.dart';
import '../cart_screen/cart_screen.dart';
import '../food_details_screen/food_details_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  final PageController _pageController = PageController();
  int _currentPageIndex = 0;
  final _scaffoldKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        _currentPageIndex = _pageController.page!.round();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: navigationAppBar(),
      body: LayoutBuilder(builder: (context, constraint) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraint.maxHeight),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.all(15.0),
                  child: CustomText(
                    text: "Hits of the week",
                    size: 20,
                    fontWeight: semiBold,
                    clr: black000000Color,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                BlocBuilder<WeekOfferCubit, WeekOfferState>(
                  builder: (context, offerState) {
                    if (offerState is WeekOfferLoading) {
                      return const Center(
                        child:
                        CircularProgressIndicator(color: theme00b894Color),
                      );
                    } else if (offerState is WeekOfferLoaded) {
                      if (offerState.weekOffers.isNotEmpty) {
                        return buildBannerWidget(offerState.weekOffers);
                      } else {
                        return buildBannerWidget(itemsWeekOffers);
                      }
                    }
                    return buildBannerWidget(itemsWeekOffers);
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                BlocBuilder<FoodItemsCubit, FoodItemsState>(
                  builder: (context, foodState) {
                    if (foodState is FoodItemsLoading) {
                      return const Center(
                        child:
                        CircularProgressIndicator(color: theme00b894Color),
                      );
                    } else if (foodState is FoodItemsLoaded) {
                      if (foodState.foodItems.isNotEmpty) {
                        return foodCategories(foodState.foodItems);
                      } else {
                        return foodCategories(foodItem);
                      }
                    }
                    return foodCategories(foodItem);
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                BlocBuilder<FoodItemsVerticalCubit, FoodItemsVerticalState>(
                  builder: (context, offerState) {
                    if (offerState is FoodItemsVerticalLoading) {
                      return const Center(
                        child:
                        CircularProgressIndicator(color: theme00b894Color),
                      );
                    } else if (offerState is FoodItemsVerticalLoaded) {
                      if (offerState.foodItems.isNotEmpty) {
                        return foodItemsVertical(offerState.foodItems);
                      } else {
                        return foodItemsVertical(
                            itemsWeekOffers.reversed.toList());
                      }
                    }
                    return foodItemsVertical(itemsWeekOffers.reversed.toList());
                  },
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  navigationAppBar() {
    return AppBar(
      leading: const Icon(Icons.menu),
      title: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: const BoxDecoration(
            color: black101010Color,
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: const Padding(
          padding: EdgeInsets.only(left: 20.0, right: 20),
          child: CustomText(
            text: "100a Ealing Rd · 24 mins",
            size: 14,
            fontWeight: semiBold,
            clr: whiteFFF5F5F5Color,
          ),
        ),
      ),
      actions: const [
        Icon(
          Icons.search_rounded,
          size: 25,
        ),
        SizedBox(
          width: 15,
        ),
      ],
    );
  }

  Widget buildBannerWidget(List<WeekOfferInfo> weeklyOffers) {
    return Column(
      children: [
        SizedBox(
          height: 250,
          child: PageView.builder(
            controller: _pageController,
            itemCount: weeklyOffers.length,
            onPageChanged: (index) {
              setState(() {
                _currentPageIndex = index; // Update the current index
              });
            },
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  // Handle tap for more details
                },
                child: Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.all(15),
                      padding: const EdgeInsets.all(10),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        gradient: LinearGradient(
                          colors: [
                            weeklyOffers[index].colorBegin!,
                            weeklyOffers[index].colorEnd!
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: CustomText(
                                  text: weeklyOffers[index].name!,
                                  size: 16,
                                  fontWeight: semiBold,
                                  clr: black101010Color,
                                ),
                              ),
                              const SizedBox(width: 20),
                              foodPriceWidget(weeklyOffers[index].price!,
                                  whiteFFFFFFColor, black101010Color),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Image.asset(
                        "assets/images/${weeklyOffers[index].image}",
                        height: 150,
                        width: 150,
                        fit: BoxFit.cover,
                        semanticLabel: weeklyOffers[index].name,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
          child: LineIndicator(
            itemCount: weeklyOffers.length,
            currentIndex: _currentPageIndex,
          ),
        ),
      ],
    );
  }

  Widget foodPriceWidget(double price,
      Color textClr,
      Color clr,) {
    return Container(
      decoration:
      BoxDecoration(borderRadius: BorderRadius.circular(20), color: clr),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      child: CustomText(
        text: "\$${price.toStringAsFixed(2)}",
        size: 14,
        fontWeight: semiBold,
        clr: textClr,
      ),
    );
  }

  Widget foodCategories(List<String> foodItems) {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0),
      child: SizedBox(
        height: 40, // Set a height for the horizontal list
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: foodItems.length + 1,
          itemBuilder: (context, index) {
            if (index == 0) {
              return Container(
                width: 40,
                margin: const EdgeInsets.symmetric(horizontal: 5),
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: greys9E9E9EColor.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(10),
                ),
                alignment: Alignment.center,
                child: Image.asset("assets/images/filter_icon.png",
                    fit: BoxFit.cover),
              );
            }
            return Container(
              width: 100,
              margin: const EdgeInsets.symmetric(horizontal: 5),
              decoration: BoxDecoration(
                color: greys9E9E9EColor.withOpacity(0.3),
                borderRadius: BorderRadius.circular(10),
              ),
              alignment: Alignment.center,
              child: CustomText(
                text: foodItems[index - 1],
                size: 14,
                fontWeight: semiBold,
                clr: black101010Color,
              ),
            );
          },
        ),
      ),
    );
  }

  Widget foodItemsVertical(List<WeekOfferInfo> weeklyOffers) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: ListView.separated(
        separatorBuilder: (context, index) => const SizedBox(height: 30),
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: weeklyOffers.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              BlocProvider.of<AddCountCubit>(context).clear();
              setState(() {});
              openFoodDetails(weeklyOffers[index]);
            },
            child: Container(
              width: 100,
              margin: const EdgeInsets.symmetric(horizontal: 5),
              child: Row(
                children: [
                  Image.asset(
                    "assets/images/${weeklyOffers[index].image}",
                    height: 95,
                    width: 95,
                    fit: BoxFit.cover,
                    semanticLabel: itemsWeekOffers[index].name,
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          text: weeklyOffers[index].name!,
                          size: 14,
                          fontWeight: semiBold,
                          clr: black101010Color,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              foodPriceWidget(
                                  weeklyOffers[index].price!,
                                  black101010Color,
                                  greys9E9E9EColor.withOpacity(0.2)),
                              const SizedBox(width: 10),
                              CustomText(
                                text: "${weeklyOffers[index].kcal} kcal",
                                size: 13,
                                fontWeight: semiBold,
                                clr: greys9E9E9EColor,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  openFoodDetails(WeekOfferInfo foodItemDetails) {
    return showModalBottomSheet(
      context: context,
      useSafeArea: true,
      enableDrag: true,
      isDismissible: true,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return FoodDetailsScreen(
            foodItemDetails: foodItemDetails,
            itemAddedToCart: (value) => itemAddedToCartCallback(value));
      },
    );
  }

  itemAddedToCartCallback(bool value) {
    if (value) {
      cartButtonSection();
    }
    setState(() {});
  }

  void cartButtonSection() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      // Allows full height
      backgroundColor: Colors.transparent,
      // Make background transparent
      barrierColor: Colors.black.withOpacity(0.5),
      builder: (BuildContext context) {
        return BlocBuilder<AddToCartCubit, AddToCartState>(
          builder: (context, state) {
            double estimatedPrice = 0.0;
            if (state is AddToCartTotal) {
              estimatedPrice = state.estimateAmount;
            } else {
              estimatedPrice = 0.0;
            }

            return Container(
              height: 100,
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 30),
              child: CustomButton(
                onPress: () {
                  Navigator.pop(context);
                  openCartItemScreen();
                },
                borderRadius: 15,
                height: 60,
                padding: const EdgeInsets.all(10),
                backgroundColor: black101010Color,
                textSize: 14,
                child: Row(
                  children: [
                    const CustomText(
                      text: "Cart",
                      size: 14,
                      fontWeight: semiBold,
                      clr: whiteFFFFFFColor,
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        const CustomText(
                          text: "· 24 mins",
                          size: 13,
                          fontWeight: semiBold,
                          clr: whiteFFFFFFColor,
                        ),
                        const SizedBox(width: 8),
                        CustomText(
                          text: "\$${estimatedPrice.toStringAsFixed(2)}",
                          size: 14,
                          fontWeight: semiBold,
                          clr: whiteFFFFFFColor,
                        ),
                        const SizedBox(width: 8),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  openCartItemScreen() {
    return showModalBottomSheet(
      context: context,
      useSafeArea: true,
      enableDrag: true,
      isDismissible: true,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return const CartScreen();
      },
    );
  }
}

typedef ItemAddedToCart = void Function(bool flag);
