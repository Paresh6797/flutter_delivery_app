import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/colors/app_colors.dart';
import '../../../core/constants/font_weight.dart';
import '../../../data/model/select_food.dart';
import '../../../data/model/week_offer.dart';
import '../../../logic/cubit/add_count/add_count_cubit.dart';
import '../../../logic/cubit/cart_item/add_to_cart_cubit.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

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
                  const SizedBox(
                    height: 10,
                  ),
                  const CustomText(
                    text: "We will deliver in \n24 minutes to the address:",
                    size: 20,
                    fontWeight: semiBold,
                    clr: black000000Color,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Row(
                    children: [
                      CustomText(
                        text: "100a Ealing Rd",
                        size: 14,
                        fontWeight: medium,
                        clr: black101010Color,
                      ),
                      SizedBox(width: 10),
                      CustomText(
                        text: "Change address",
                        size: 13,
                        fontWeight: normal,
                        clr: greys9E9E9EColor,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  BlocBuilder<AddToCartCubit, AddToCartState>(
                    builder: (context, cartState) {
                      if (cartState is AddToCartLoading) {
                        return const Center(
                          child: CircularProgressIndicator(
                              color: theme00b894Color),
                        );
                      } else if (cartState is AddToCartTotal) {
                        if (cartState.cartItems.isNotEmpty) {
                          return foodCartItems(cartState.cartItems);
                        } else {
                          return Container();
                        }
                      }
                      return Container();
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            text: "Delivery",
                            size: 14,
                            fontWeight: bold,
                            clr: black101010Color,
                          ),
                          SizedBox(height: 5),
                          CustomText(
                            text: "Free delivery from \$30",
                            size: 13,
                            fontWeight: medium,
                            clr: greys9E9E9EColor,
                          ),
                        ],
                      ),
                      Spacer(),
                      CustomText(
                        text: "\$0.00",
                        size: 14,
                        fontWeight: bold,
                        clr: black101010Color,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  const CustomText(
                    text: "Payment method",
                    size: 13,
                    fontWeight: normal,
                    clr: greys9E9E9EColor,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  applePaySection(),
                  const SizedBox(
                    height: 30,
                  ),
                  paySection()
                ],
              ),
            )),
      ],
    );
  }

  Widget foodCartItems(List<SelectFood> cartItem) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: ListView.separated(
        separatorBuilder: (context, index) => const SizedBox(height: 30),
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: cartItem.isNotEmpty ? cartItem.length + 1 : cartItem.length,
        itemBuilder: (context, index) {
          if (index == cartItem.length) {
            return _buildAdditionalOptions(context);
          }
          // Otherwise, build the cart item
          return _buildCartItem(context, cartItem[index]);
        },
      ),
    );
  }

  Widget _buildAdditionalOptions(BuildContext context,) {
    return Row(
      children: [
        const SizedBox(width: 10),
        Image.asset(
          "assets/images/cutlery.png",
          height: 30,
          width: 30,
          alignment: Alignment.center,
          fit: BoxFit.fill,
        ),
        const SizedBox(width: 30),
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Expanded(
                child: CustomText(
                  text: "Cutlery",
                  size: 14,
                  fontWeight: normal,
                  clr: black101010Color,
                ),
              ),
              const SizedBox(width: 10),
              Row(
                children: [
                  InkWell(
                      onTap: () {},
                      child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                              color: greys9E9E9EColor.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(8)),
                          child: Icon(
                            Icons.remove,
                            size: 20,
                            color: black101010Color.withOpacity(0.5),
                          ))),
                  const SizedBox(width: 10),
                  const CustomText(
                    text: "1",
                    size: 14,
                    fontWeight: normal,
                    clr: black101010Color,
                  ),
                  const SizedBox(width: 10),
                  InkWell(
                      onTap: () {},
                      child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                              color: greys9E9E9EColor.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(8)),
                          child: Icon(
                            Icons.add,
                            size: 20,
                            color: black101010Color.withOpacity(0.5),
                          ))),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCartItem(BuildContext context, SelectFood item) {
    return Row(
      children: [
        Image.asset(
          "assets/images/${item.image}",
          height: 50,
          width: 50,
          fit: BoxFit.cover,
          semanticLabel: item.name,
        ),
        const SizedBox(width: 20),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: CustomText(
                      text: item.name!,
                      size: 14,
                      fontWeight: normal,
                      clr: black101010Color,
                    ),
                  ),
                  const SizedBox(width: 10),
                  CustomText(
                    text:
                    "\$${(int.parse(item.quantity ?? "1") * item.price!)
                        .toStringAsFixed(2)}",
                    size: 14,
                    fontWeight: bold,
                    clr: black101010Color,
                  ),
                ],
              ),
              const SizedBox(height: 5),
              BlocBuilder<AddToCartCubit, AddToCartState>(
                builder: (context, state) {
                  if (state is AddToCartTotal) {
                    return Row(
                      children: [
                        InkWell(
                            onTap: () {
                              WeekOfferInfo foodItem = WeekOfferInfo(
                                  id: item.id,
                                  name: item.name,
                                  desc: "",
                                  qty: item.quantity,
                                  kcal: 325,
                                  image: item.image,
                                  price: item.price,
                                  colorBegin: blue87C6FEColor,
                                  colorEnd: colorCBCAFF);

                              BlocProvider.of<AddToCartCubit>(context)
                                  .removeItemFromCart(foodItem);
                            },
                            child: Container(
                                padding: const EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                    color: greys9E9E9EColor.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(8)),
                                child: Icon(
                                  Icons.remove,
                                  size: 20,
                                  color: black101010Color.withOpacity(0.5),
                                ))),
                        const SizedBox(width: 10),
                        CustomText(
                          text: "${item.quantity}",
                          size: 14,
                          fontWeight: normal,
                          clr: black101010Color,
                        ),
                        const SizedBox(width: 10),
                        InkWell(
                            onTap: () {
                              WeekOfferInfo foodItem = WeekOfferInfo(
                                  id: item.id,
                                  name: item.name,
                                  desc: "",
                                  qty: item.quantity,
                                  kcal: 325,
                                  image: item.image,
                                  price: item.price,
                                  colorBegin: blue87C6FEColor,
                                  colorEnd: colorCBCAFF);

                              BlocProvider.of<AddToCartCubit>(context)
                                  .addItemToCart(foodItem);
                            },
                            child: Container(
                                padding: const EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                    color: greys9E9E9EColor.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(8)),
                                child: Icon(
                                  Icons.add,
                                  size: 20,
                                  color: black101010Color.withOpacity(0.5),
                                ))),
                      ],
                    );
                  } else {
                    return Container();
                  }
                },
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget applePaySection() {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: greys9E9E9EColor),
            borderRadius: BorderRadius.circular(5),
            // shape: BoxShape.rectangle
          ),
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 3),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.apple,
                size: 12,
              ),
              SizedBox(width: 4), // Add space between icon and text
              CustomText(
                text: "Pay",
                size: 10,
                clr: black101010Color,
                fontWeight: semiBold,
              ),
            ],
          ),
        ),
        const SizedBox(width: 10),
        const CustomText(
          text: "Apple pay",
          size: 14,
          clr: black101010Color,
          fontWeight: semiBold,
        ),
        const Spacer(),
        const Icon(
          Icons.arrow_forward_ios_rounded,
          size: 15,
        ),
      ],
    );
  }

  Widget paySection() {
    return BlocBuilder<AddToCartCubit, AddToCartState>(
      builder: (context, state) {
        double estimatedPrice = 0.0;
        if (state is AddToCartTotal) {
          estimatedPrice = state.estimateAmount;
        } else {
          estimatedPrice = 0.0;
        }
        return CustomButton(
          onPress: () {
            Navigator.pop(context);
          },
          borderRadius: 15,
          height: 60,
          padding: const EdgeInsets.all(10),
          backgroundColor: black101010Color,
          textSize: 14,
          child: Row(
            children: [
              const CustomText(
                text: "Pay",
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
        );
      },
    );
  }
}
