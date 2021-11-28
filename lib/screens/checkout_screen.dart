import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';
import 'package:quikk_customer/controller/cart_controller.dart';
import 'package:quikk_customer/controller/check_out_controller.dart';
import 'package:quikk_customer/helper/constants.dart';
import 'package:quikk_customer/helper/helper.dart';
import 'package:quikk_customer/screens/my_account/address/manage_address.dart';
import 'package:quikk_customer/services/razor_pay.dart';
import 'package:quikk_customer/widgets/custom_back_button.dart';
import 'package:quikk_customer/widgets/custom_loading.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({Key? key}) : super(key: key);

  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  int selectedIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Provider.of<RazorPayService>(context, listen: false).init(
      Provider.of<CheckOutController>(context, listen: false)
          .handlePaymentSuccess,
      Provider.of<CheckOutController>(context, listen: false)
          .handlePaymentError,
      Provider.of<CheckOutController>(context, listen: false)
          .handleExternalWallet,
    );
    Provider.of<CheckOutController>(context, listen: false).init(
      Provider.of<CartController>(context, listen: false)
          .getCart[0]
          .shopId
          .toString(),
      Provider.of<CartController>(context, listen: false)
          .getSubtotal
          .toString(),
    );
  }

  @override
  Widget build(BuildContext context) {
    var cartController = Provider.of<CartController>(context);
    var razorPayService = Provider.of<RazorPayService>(context);
    var controller = Provider.of<CheckOutController>(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: CustomBackButton(),
        title: Text(
          'Checkout',
          style: Theme.of(context).textTheme.headline6,
        ),
      ),
      body: controller.loading
          ? CustomLoading()
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: 8,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Delivering to',
                        style: Theme.of(context)
                            .textTheme
                            .subtitle1!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      TextButton(
                        onPressed: () => pushNewScreen(
                          context,
                          screen: ManageAddressScreen(),
                          withNavBar: false,
                        ).then(
                          (value) => controller.init(
                            Provider.of<CartController>(context, listen: false)
                                .getCart[0]
                                .shopId
                                .toString(),
                            Provider.of<CartController>(context, listen: false)
                                .getSubtotal
                                .toString(),
                          ),
                        ),
                        child: Text(
                          'Add new address',
                          style: Theme.of(context).textTheme.button!.copyWith(
                                color: Colors.black,
                              ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    child: controller.getAddresses.length < 1
                        ? Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'No address found',
                                  style: Theme.of(context).textTheme.caption,
                                ),
                                Text(
                                  'Add address to continue',
                                  style: Theme.of(context).textTheme.caption,
                                ),
                              ],
                            ),
                          )
                        : ListView.builder(
                            itemBuilder: (_, index) {
                              return CheckboxListTile(
                                tileColor: Colors.white,
                                onChanged: (v) {
                                  setState(() {
                                    selectedIndex = index;
                                  });
                                },
                                value: selectedIndex == index ? true : false,
                                // leading: Checkbox(
                                //   value: selectedIndex == index
                                //       ? true
                                //       : false,
                                //   onChanged: (v) {
                                //     setState(() {
                                //       selectedIndex = index;
                                //     });
                                //   },
                                // ),
                                title:
                                    Text(controller.getAddresses[index].type!),
                                subtitle: Text(
                                    '${controller.getAddresses[index].completeAddress!} ${controller.getAddresses[index].location!}'),
                              );
                            },
                            itemCount: controller.getAddresses.length,
                          ),
                  ),
                ),
                Column(
                  children: [
                    InkWell(
                      onTap: () =>
                          controller.onApplyCouponButtonPressed(context),
                      child: Container(
                        color: Colors.white,
                        padding: EdgeInsets.symmetric(
                          // horizontal: 8,
                          vertical: 8,
                        ),
                        child: controller.selectedCoupon == null
                            ? Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      'Offers',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .copyWith(
                                            fontWeight: FontWeight.bold,
                                          ),
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Image.asset(
                                              Constant.KAsset +
                                                  'coupon_icon.png',
                                              width: 18,
                                              height: 18,
                                            ),
                                            SizedBox(
                                              width: 4,
                                            ),
                                            Text(
                                              'Apply Coupon',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .caption!
                                                  .copyWith(
                                                    color: Colors.black,
                                                  ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              'View Offers',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .caption!
                                                  .copyWith(
                                                    color: Colors.red,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                            ),
                                            Icon(Icons.chevron_right),
                                          ],
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              )
                            : Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      'Offers',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .copyWith(
                                            fontWeight: FontWeight.bold,
                                          ),
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            CircleAvatar(
                                              radius: 12,
                                              backgroundColor: Colors.green,
                                              child: Icon(
                                                Icons.check,
                                                color: Colors.white,
                                                size: 16,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 8,
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Code ${controller.selectedCoupon!.code} applied!',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .caption!
                                                      .copyWith(
                                                        color: Colors.black,
                                                      ),
                                                ),
                                                Text(
                                                  '${controller.selectedCoupon!.description} upto ${controller.selectedCoupon!.maxDiscount}',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .caption,
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Column(
                                              children: [
                                                Text(
                                                  '- ₹${Provider.of<CartController>(context, listen: false).getCouponPrice.toString()}',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyText1!
                                                      .copyWith(
                                                        color: Colors.redAccent,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                ),
                                              ],
                                            ),
                                            Icon(Icons.chevron_right),
                                          ],
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    controller.coinEligibilityList!.isEmpty
                        ? SizedBox()
                        : controller.coinEligibilityList![0] >
                                cartController.getSubtotal
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8, bottom: 8),
                                    child: Text(
                                      controller.coinEligibilityList![1],
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle1!
                                          .copyWith(
                                            color: Colors.redAccent,
                                            fontWeight: FontWeight.bold,
                                          ),
                                    ),
                                  ),
                                ],
                              )
                            : controller.applyCoinList == null
                                ? InkWell(
                                    onTap: () {
                                      controller.applyCoin(
                                          cartController.getCart[0].shopId
                                              .toString(),
                                          cartController.getSubtotal.toString(),
                                          context);
                                    },
                                    child: Container(
                                      color: Colors.white,
                                      padding: EdgeInsets.symmetric(
                                        // horizontal: 8,
                                        vertical: 8,
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              'Quikk Coins',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1!
                                                  .copyWith(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                            ),
                                            SizedBox(
                                              height: 8,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    Image.asset(
                                                      Constant.KAsset +
                                                          'coupon_icon.png',
                                                      width: 18,
                                                      height: 18,
                                                    ),
                                                    SizedBox(
                                                      width: 4,
                                                    ),
                                                    Row(
                                                      children: [
                                                        Text(
                                                          'Available Coins : ',
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .caption!
                                                                  .copyWith(
                                                                    color: Colors
                                                                        .black,
                                                                  ),
                                                        ),
                                                        Text(
                                                          '${controller.referModel!.coinBalance}',
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .bodyText1!
                                                                  .copyWith(
                                                                    color: Colors
                                                                        .green,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                  ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Text(
                                                      'Use Coins',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .caption!
                                                          .copyWith(
                                                            color: Colors.red,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                    ),
                                                    Icon(Icons.chevron_right),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                                : InkWell(
                                    onTap: () {},
                                    child: Container(
                                      color: Colors.white,
                                      padding: EdgeInsets.symmetric(
                                        // horizontal: 8,
                                        vertical: 8,
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              'Quikk Coins Applied',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1!
                                                  .copyWith(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                            ),
                                            SizedBox(
                                              height: 8,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    Image.asset(
                                                      Constant.KAsset +
                                                          'quikk_coin.png',
                                                      width: 18,
                                                      height: 18,
                                                    ),
                                                    SizedBox(
                                                      width: 4,
                                                    ),
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Text(
                                                              'Coins Applied : ',
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .caption!
                                                                  .copyWith(
                                                                    color: Colors
                                                                        .black,
                                                                  ),
                                                            ),
                                                            Text(
                                                              '${controller.applyCoinList![1]}',
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .bodyText1!
                                                                  .copyWith(
                                                                    color: Colors
                                                                        .green,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                  ),
                                                            ),
                                                          ],
                                                        ),
                                                        Row(
                                                          children: [
                                                            Text(
                                                              'You will earn ',
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .caption!
                                                                  .copyWith(
                                                                    color: Colors
                                                                        .black,
                                                                  ),
                                                            ),
                                                            Text(
                                                              '${controller.applyCoinList![0]}',
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .bodyText1!
                                                                  .copyWith(
                                                                    color: Colors
                                                                        .green,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                  ),
                                                            ),
                                                            Text(
                                                              ' quikk coins in this order',
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .caption!
                                                                  .copyWith(
                                                                    color: Colors
                                                                        .black,
                                                                  ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    print('fssdfdsfs');
                                                    cartController
                                                        .setCoinPrice(0);
                                                    cartController
                                                        .calculateTotal();
                                                    controller.applyCoinList =
                                                        null;
                                                  },
                                                  child: Row(
                                                    children: [
                                                      Text(
                                                        'remove',
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .caption!
                                                            .copyWith(
                                                              color: Colors.red,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                            ),
                                                      ),
                                                      Icon(Icons.chevron_right),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                    Container(
                      height: 200,
                      padding: EdgeInsets.only(
                          left: 16, top: 16, right: 16, bottom: 8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Subtotal',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(
                                        // fontWeight: FontWeight.bold,
                                        ),
                              ),
                              Text(
                                Constant.KCurrency +
                                    '${cartController.getSubtotal.toStringAsFixed(2)}',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(
                                        // fontWeight: FontWeight.bold,
                                        ),
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Delivery charges',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(
                                        // fontWeight: FontWeight.bold,
                                        ),
                              ),
                              cartController.getDeliveryCharge < 1
                                  ? Text(
                                      'free',
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle2!,
                                    )
                                  : Text(
                                      Constant.KCurrency +
                                          '${cartController.getDeliveryCharge.toStringAsFixed(2)}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .copyWith(
                                              // fontWeight: FontWeight.bold,
                                              ),
                                    )
                            ],
                          ),
                          cartController.getMarketType == 1
                              ? Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Tax & charges',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .copyWith(
                                              // fontWeight: FontWeight.bold,
                                              ),
                                    ),
                                    Text(
                                      Constant.KCurrency +
                                          '${(cartController.getTax + cartController.getPackagingCharge).toStringAsFixed(2)}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .copyWith(
                                              // fontWeight: FontWeight.bold,
                                              ),
                                    )
                                  ],
                                )
                              : SizedBox(),
                          cartController.getCouponPrice == 0
                              ? SizedBox()
                              : Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Promo',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .copyWith(
                                              // fontWeight: FontWeight.bold,
                                              ),
                                    ),
                                    Text(
                                      '-' +
                                          Constant.KCurrency +
                                          '${cartController.getCouponPrice!.toStringAsFixed(2)}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .copyWith(
                                              // fontWeight: FontWeight.bold,
                                              ),
                                    )
                                  ],
                                ),
                          controller.applyCoinList == null
                              ? SizedBox()
                              : Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Quikk Coins',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .copyWith(
                                              // fontWeight: FontWeight.bold,
                                              ),
                                    ),
                                    Text(
                                      '-' +
                                          Constant.KCurrency +
                                          '${cartController.getCoinPrice!.toStringAsFixed(2)}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .copyWith(
                                              // fontWeight: FontWeight.bold,
                                              ),
                                    )
                                  ],
                                ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Total ${cartController.getCart.length} items in cart',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                              Text(
                                Constant.KCurrency +
                                    '${cartController.getTotal.toStringAsFixed(2)}',
                                style: Theme.of(context)
                                    .textTheme
                                    .headline5!
                                    .copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                              )
                            ],
                          ),
                          cartController.loading
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
                                  onPressed: () async {
                                    // print('CARTITEMS'+cartController.getCart[0].product.name.toString());
                                    // print('CARTITEMS'+cartController.getCart[1].product.name.toString());
                                    // print('CARTITEMS'+cartController.getCart[2].product.name.toString());
                                    // print('CARTITEMS'+cartController.getCart[0].product.variationss![0].id.toString());
                                    // // print('CARTITEMS'+cartController.getCart[2].product.variationss![0].name.toString());
                                    // print('CARTITEMS'+cartController.getCart[1].product.variationss![0].id.toString());
                                    // print('CARTITEMS 1'+cartController.getCart[0].variation.name.toString());
                                    // print('CARTITEMS 1'+cartController.getCart[0].variation.id.toString());
                                    // print('CARTITEMS 1'+cartController.getCart[1].variation.id.toString());
                                    // print('CARTITEMS 2'+cartController.getCart[1].variation.name.toString());
                                    // print('CARTITEMS 3'+cartController.getCart[1].variation.name.toString());
                                    if (controller.getAddresses.isEmpty) {
                                      Fluttertoast.showToast(
                                          msg: 'Please add address to continue');
                                      return;
                                    }
                                    Helper.showLoadingDialog(context);
                                    var res = await controller.onPlacePressed(
                                        cartController.getTotal);
                                    Navigator.pop(context);

                                    controller.onPlaceOrderButtonPressed(
                                      context,
                                      razorPayService.openCheckout(
                                        (cartController.getTotal * 100).toInt(),
                                        controller.phoneNo!,
                                        controller.email!,
                                        res!,
                                      ),
                                      cartController.getCart,
                                      '${controller.getAddresses[selectedIndex].completeAddress!} ${controller.getAddresses[selectedIndex].location!}',
                                      cartController.getTotal,
                                      cartController.getDeliveryCharge,
                                      cartController.getTax,
                                      cartController.getPackagingCharge,
                                      cartController.getSubtotal,
                                    );
                                  },
                                  child: Text('Click to place order'),
                                ),
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
    );
  }
}
