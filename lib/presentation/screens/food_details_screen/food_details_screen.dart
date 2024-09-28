import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/colors/app_colors.dart';
import '../../../core/constants/font_weight.dart';
import '../../../data/model/week_offer.dart';
import '../../../logic/cubit/add_count/add_count_cubit.dart';
import '../../../logic/cubit/cart_item/add_to_cart_cubit.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text.dart';
import '../home_screen/home_screen.dart';

class FoodDetailsScreen extends StatelessWidget {
  FoodDetailsScreen({super.key, required this.foodItemDetails, required this.itemAddedToCart});

  WeekOfferInfo foodItemDetails;
  final ItemAddedToCart itemAddedToCart;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        AnimatedContainer(
          transform: Matrix4.translationValues(0.0, 40, 0.0),
          duration: const Duration(milliseconds: 200),
          width: 50,
          // Dynamic size
          height: 5,
          margin: const EdgeInsets.symmetric(horizontal: 5),
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(5),
            color: whiteFFFFFFColor,
          ),
        ),
        Container(
            transform: Matrix4.translationValues(0.0, 50, 0.0),
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30)),
                shape: BoxShape.rectangle,
                color: Colors.grey.shade100),
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
            child: SizedBox(
              width: double.infinity,
              height: MediaQuery
                  .of(context)
                  .size
                  .height - 150,
              child: ListView(
                shrinkWrap: true,
                children: [
                  SizedBox(
                    height: 250,
                    child: Center(
                      child: Image.asset(
                          "assets/images/${foodItemDetails.image}",
                          fit: BoxFit.fill),
                    ),
                  ),
                  CustomText(
                    text: foodItemDetails.name!,
                    size: 20,
                    fontWeight: semiBold,
                    clr: black000000Color,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomText(
                    text: foodItemDetails.desc!,
                    size: 14,
                    clr: greys9E9E9EColor,
                    fontWeight: medium,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  kalContainer(),
                  const SizedBox(
                    height: 20,
                  ),
                  const ListTile(
                    title: CustomText(
                      text: "Add in poke",
                      size: 14,
                      clr: black101010Color,
                      fontWeight: semiBold,
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 15,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  addToCartSection(foodItemDetails)
                ],
              ),
            )),
      ],
    );
  }

  Widget addToCartSection(WeekOfferInfo foodItemDetails) {
    return BlocBuilder<AddCountCubit, AddCountState>(
      builder: (context, state) {
        double estimatedPrice = 0.0;
        int quantity = 1;
        if (state is AddCountTotal) {
          quantity = state.count;
          estimatedPrice = state.estimateAmount;
          foodItemDetails.qty = quantity.toString();
        } else {
          quantity = 1;
          estimatedPrice = foodItemDetails.price!;
          foodItemDetails.qty = "1";
        }
        return Row(
          children: [
            Container(
              height: 60,
              width: 120,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: greys9E9E9EColor.withOpacity(0.2)),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                      onTap: quantity > 1 ? () {
                        BlocProvider.of<AddCountCubit>(context).removeItem(
                            foodItemDetails);
                      } : null,
                      child: const Icon(Icons.remove, size: 20)),
                  const SizedBox(width: 10),
                  CustomText(
                    text: "$quantity",
                    size: 14,
                    fontWeight: semiBold,
                    clr: black101010Color,
                  ),
                  const SizedBox(width: 10),
                  InkWell(
                      onTap: () {
                        BlocProvider.of<AddCountCubit>(context)
                            .addItem(foodItemDetails);
                      },
                      child: const Icon(Icons.add, size: 20)),
                ],
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: CustomButton(
                onPress: () {
                  BlocProvider.of<AddToCartCubit>(context)
                      .addItemToCart(foodItemDetails);
                  Navigator.pop(context);
                  itemAddedToCart(true);
                },
                borderRadius: 15,
                height: 60,
                padding: const EdgeInsets.all(10),
                text: 'Add to cart  \$${estimatedPrice.toStringAsFixed(2)}',
                textColor: whiteFFFFFFColor,
                backgroundColor: black101010Color,
                textSize: 14,
              ),
            ),
          ],
        );
      },
    );
  }

  Widget kalContainer() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: greys9E9E9EColor)),
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            children: [
              CustomText(
                text: "${foodItemDetails.kcal}",
                size: 16,
                fontWeight: bold,
                clr: black101010Color,
              ),
              const CustomText(
                text: "kcal",
                size: 13,
                fontWeight: semiBold,
                clr: greys9E9E9EColor,
              ),
            ],
          ),
          const Column(
            children: [
              CustomText(
                text: "420",
                size: 16,
                fontWeight: bold,
                clr: black101010Color,
              ),
              CustomText(
                text: "grams",
                size: 13,
                fontWeight: semiBold,
                clr: greys9E9E9EColor,
              ),
            ],
          ),
          const Column(
            children: [
              CustomText(
                text: "21",
                size: 16,
                fontWeight: bold,
                clr: black101010Color,
              ),
              CustomText(
                text: "proteins",
                size: 13,
                fontWeight: semiBold,
                clr: greys9E9E9EColor,
              ),
            ],
          ),
          const Column(
            children: [
              CustomText(
                text: "19",
                size: 16,
                fontWeight: bold,
                clr: black101010Color,
              ),
              CustomText(
                text: "fats",
                size: 13,
                fontWeight: semiBold,
                clr: greys9E9E9EColor,
              ),
            ],
          ),
          const Column(
            children: [
              CustomText(
                text: "65",
                size: 16,
                fontWeight: bold,
                clr: black101010Color,
              ),
              CustomText(
                text: "carbs",
                size: 13,
                fontWeight: semiBold,
                clr: greys9E9E9EColor,
              ),
            ],
          ),
        ],
      ),
    );
  }
}