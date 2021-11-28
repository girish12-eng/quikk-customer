import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';
import 'package:quikk_customer/controller/cart_controller.dart';
import 'package:quikk_customer/helper/constants.dart';
import 'package:quikk_customer/screens/checkout_screen.dart';
import 'package:quikk_customer/widgets/cart_item_card.dart';
import 'package:quikk_customer/widgets/custom_back_button.dart';

class CartScreen extends StatelessWidget {
  static const id = 'CartScreen';
  final bool isFromMarket;

  const CartScreen({
    Key? key,
    this.isFromMarket = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Provider.of<CartController>(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: isFromMarket
            ? CustomBackButton()
            : Center(
                child: Text(
                  'Cart',
                  style: Theme.of(context).textTheme.headline5,
                ),
              ),
        title: isFromMarket
            ? Text(
                'Cart',
                style: Theme.of(context).textTheme.headline5,
              )
            : SizedBox(),
        actions: [
          TextButton(
            onPressed: () => controller.clearCart(),
            child: Text(
              'Clear all',
              // '${controller.getCart.length}',
              style: Theme.of(context).textTheme.caption!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
        ],
      ),
      body: controller.getCart.isEmpty
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(Constant.KAsset + 'empty_cart.png'),
                Text(
                  'cart empty',
                  style: Theme.of(context).textTheme.headline6,
                ),
              ],
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: ListView.builder(
                    itemBuilder: (_, index) {
                      return CartItemCard(
                        product: controller.getCart[index].product,
                        quantity: controller.getCart[index].quantity,
                        index: index,
                        variation: controller.getCart[index].variation,
                      );
                    },
                    itemCount: controller.getCart.length,
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(
                    left: 16,
                    right: 16,
                    top: 16,
                  ),
                  height: 210,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.horizontal(
                      left: Radius.circular(16),
                      right: Radius.circular(16),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Subtotal',
                            style:
                                Theme.of(context).textTheme.subtitle2!.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black45,
                                    ),
                          ),
                          Text(
                            Constant.KCurrency +
                                '${controller.getSubtotal.toStringAsFixed(2)}',
                            style:
                                Theme.of(context).textTheme.subtitle2!.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black45,
                                    ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      // controller.getMarketType == 1
                      //     ? Row(
                      //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //         children: [
                      //           Text(
                      //             'Packaging Charge',
                      //             style: Theme.of(context)
                      //                 .textTheme
                      //                 .subtitle2!
                      //                 .copyWith(
                      //                   fontWeight: FontWeight.bold,
                      //                   color: Colors.black45,
                      //                 ),
                      //           ),
                      //           Text(
                      //             Constant.KCurrency +
                      //                 '${controller.getPackagingCharge}',
                      //             style: Theme.of(context)
                      //                 .textTheme
                      //                 .subtitle2!
                      //                 .copyWith(
                      //                   fontWeight: FontWeight.bold,
                      //                   color: Colors.black45,
                      //                 ),
                      //           )
                      //         ],
                      //       )
                      //     : SizedBox(),
                      // SizedBox(
                      //   height: 8,
                      // ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Delivery charges',
                            style:
                                Theme.of(context).textTheme.subtitle2!.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black45,
                                    ),
                          ),
                          controller.loading
                              ? SizedBox(
                                  width: 16,
                                  height: 16,
                                  child: CircularProgressIndicator(
                                    color: Color(Constant.KPrimaryColor),
                                  ))
                              : controller.getDeliveryCharge < 1
                                  ? Text(
                                      'free',
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle2!
                                          .copyWith(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black45,
                                          ),
                                    )
                                  : Text(
                                      Constant.KCurrency +
                                          '${controller.getDeliveryCharge}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle2!
                                          .copyWith(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black45,
                                          ),
                                    )
                        ],
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      controller.getMarketType == 1
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Tax & charges  ${controller.getTax} / ${controller.getPackagingCharge}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle2!
                                      .copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black45,
                                      ),
                                ),
                                Text(
                                  Constant.KCurrency +
                                      '${(controller.getTax + controller.getPackagingCharge).toStringAsFixed(2)}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle2!
                                      .copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black45,
                                      ),
                                )
                              ],
                            )
                          : SizedBox(),
                      Divider(
                        thickness: 2,
                        height: 32,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Total',
                            style:
                                Theme.of(context).textTheme.bodyText1!.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                          ),
                          Text(
                            Constant.KCurrency +
                                '${controller.getTotal.toStringAsFixed(2)}',
                            style:
                                Theme.of(context).textTheme.headline6!.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                          )
                        ],
                      ),
                      controller.loading
                          ? ElevatedButton(
                              onPressed: () {},
                              child: SizedBox(
                                height: 16,
                                width: 16,
                                child: CircularProgressIndicator(
                                  color: Color(Constant.KPrimaryColor),
                                  backgroundColor: Colors.white,
                                ),
                              ),
                            )
                          : ElevatedButton(
                              onPressed: () => pushNewScreen(
                                context,
                                screen: CheckoutScreen(),
                                withNavBar:
                                    false, // OPTIONAL VALUE. True by default.
                                pageTransitionAnimation:
                                    PageTransitionAnimation.cupertino,
                              ).then((value) {
                                print("CART ITEM DATA" + controller.getCart.toString());
                                controller.setCouponPrice(0);
                                controller.setCoinPrice(0);
                                controller.calculateTotal();
                              }),
                              child: Text('Proceed to checkout'),
                            )
                    ],
                  ),
                )
              ],
            ),
    );
  }
}
