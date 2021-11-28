import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';
import 'package:quikk_customer/controller/cart_controller.dart';
import 'package:quikk_customer/controller/home_screen_controller.dart';
import 'package:quikk_customer/helper/constants.dart';
import 'package:quikk_customer/models/account_refer_model.dart';
import 'package:quikk_customer/models/addressmodel.dart';
import 'package:quikk_customer/models/cart_model.dart';
import 'package:quikk_customer/models/coupon_model.dart';
import 'package:quikk_customer/repository/add_address_repo.dart';
import 'package:quikk_customer/repository/coupon_repo.dart';
import 'package:quikk_customer/repository/order_repo.dart';
import 'package:quikk_customer/repository/user_repo.dart';
import 'package:quikk_customer/screens/order_success_screen.dart';
import 'package:quikk_customer/widgets/payment_processing_dialog.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CheckOutController extends ChangeNotifier {
  bool loading = false;
  late BuildContext _context;
  late SharedPreferences _preferences;
  late List<CartModel> _cart;
  late List<CouponModel> _coupons;

  String? _address;
  late List<AddressModel> _addresses;
  String? email;
  String? phoneNo;
  double? _subTotal;
  double? _totalAmount;
  int? _deliveryCharges;
  double? _tax;
  double? _packagingCharge;

  CouponModel? selectedCoupon;
  List? coinEligibilityList;
  List? applyCoinList;
  AccountReferModel? referModel;

  void init(String shopId, String sbTotal) async {
    _preferences = await SharedPreferences.getInstance();
    email = _preferences.getString('email');
    phoneNo = _preferences.getString('phone');
    _addresses = [];
    _coupons = [];
    coinEligibilityList = [];
    selectedCoupon = null;
    referModel = null;
    applyCoinList = null;
    // getReferDetails();
    // getAddress();
    // getCoupons();
    coinEligibility(shopId, sbTotal);
  }

  void getCoupons() async {
    _preferences = await SharedPreferences.getInstance();
    String token = _preferences.getString('token')!;
    _coupons = [];
    _coupons = await getCouponsRepo(token);
    loading = false;
    notifyListeners();
  }

  void getReferDetails() async {
    _preferences = await SharedPreferences.getInstance();
    String token = _preferences.getString('token')!;
    referModel = await getReferDetailsRepo(token);
    getCoupons();
    notifyListeners();
  }

  Future<void> applyCoin(
      String shopId, String subTotal, BuildContext context) async {
    loading = true;
    notifyListeners();
    _preferences = await SharedPreferences.getInstance();
    String token = _preferences.getString('token')!;
    applyCoinList = await coinApplyRepo(token, shopId, subTotal);
    loading = false;
    notifyListeners();
    if (applyCoinList!.isNotEmpty) {
      Provider.of<CartController>(context, listen: false).setCoinPrice(
        double.parse(applyCoinList![2].toString()),
      );
      Provider.of<CartController>(context, listen: false).calculateTotal();
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (_) => AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Lottie.asset(Constant.KLottieAsset + 'coupon_apply_success.json'),
              Text(
                'Coin Applied',
                style: Theme.of(context).textTheme.headline6!.copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ],
          ),
        ),
      );
      Future.delayed(
        Duration(seconds: 2),
      ).then(
        (value) => Navigator.pop(context),
      );
    } else {
      Fluttertoast.showToast(msg: 'Coin Applied fails');
    }
  }

  Future<void> getAddress() async {
    _preferences = await SharedPreferences.getInstance();
    String token = _preferences.getString('token')!;
    _addresses = await getAddressRepo(token);
    getReferDetails();
    print(_addresses.length);
  }

  List<AddressModel> get getAddresses {
    return _addresses;
  }

  Future<String?> onPlacePressed(
    double totalAmount,
  ) async {
    return await getOrderIdRazorPayRepo(
        ((totalAmount * 100).toInt()).toString());
  }

  void onPlaceOrderButtonPressed(
    BuildContext context,
    void razorPay,
    List<CartModel> cart,
    String address,
    double totalAmount,
    int deliveryCharges,
    double tax,
    double packCharge,
    double subtotal,
  ) {
    // print('asas');
    _context = context;
    _cart = cart;
    _address = address;
    _subTotal = subtotal;
    _totalAmount = totalAmount;
    _deliveryCharges = deliveryCharges;
    _tax = tax;
    _packagingCharge = packCharge;
  }

  void handlePaymentSuccess(PaymentSuccessResponse response) async {
    showDialog(
        context: _context,
        builder: (_) {
          return PaymentProcessDialog();
        });
    _preferences = await SharedPreferences.getInstance();
    String token = _preferences.getString('token')!;
    List<Map<String, String>>? orderRes = await orderPlaced();
    if (orderRes != null) {
      var paymentResponse = await handlePaymentSuccessRepo(
          token,
          orderRes[0]['orderId'].toString(),
          orderRes[0]['total_amount'].toString(),
          response.paymentId!);
      if (paymentResponse) {
        Provider.of<CartController>(_context, listen: false).clearCart();
        pushNewScreen(
          _context,
          screen: OrderSuccessScreen(),
          withNavBar: false,
        );
      }
    }
    // Do something when payment succeeds
  }

  void handlePaymentError(PaymentFailureResponse response) {
    Fluttertoast.showToast(msg: 'Payment fails');
    print('payment fail');
    print(response.code);
    print(response.message);
    // Do something when payment fails
  }

  void coinEligibility(String shopId, String subTotal) async {
    loading = true;
    notifyListeners();
    coinEligibilityList = await coinEligibilityRepo(shopId, subTotal);
    getAddress();
    notifyListeners();
  }

  void handleExternalWallet(ExternalWalletResponse response) async {
    print('Wallet +${response.walletName}');
  }

  Future<List<Map<String, String>>?> orderPlaced() async {
    String? lat =
        Provider.of<HomeScreenController>(_context, listen: false).lat;
    // print('form orderrrrrrrr');
    // print(lat);
    String? lng =
        Provider.of<HomeScreenController>(_context, listen: false).lng;
    print(lng);
    _preferences = await SharedPreferences.getInstance();
    String token = _preferences.getString('token')!;
    String mobileNo = _preferences.getString('phone')!;
    String email = _preferences.getString('email')!;
    List<Map<String, String>>? res = await submitOrderRepo(
      token,
      _cart,
      mobileNo,
      _address!,
      _deliveryCharges.toString(),
      lat!,
      lng!,
      _totalAmount.toString(),
      selectedCoupon == null ? '' : selectedCoupon!.id.toString(),
      Provider.of<CartController>(_context, listen: false)
          .getCouponPrice
          .toString(),
      _tax!,
      _packagingCharge!,
      _subTotal.toString(),
      applyCoinList == null ? '0' : applyCoinList![1].toString(),
      applyCoinList == null ? '0' : applyCoinList![0].toString(),
    );

    if (res != null) {
      return res;
    }
    return null;
  }

  bool checkCouponValidity(BuildContext context, CouponModel coupon) {
    if (DateTime.parse(coupon.expiresAt!).isAfter(DateTime.now())) {
      //checking if coupon shop id == 0 then apply thi to all shops
      if (coupon.shopId == 0 ||
          coupon.shopId ==
              Provider.of<CartController>(context, listen: false)
                  .getCart[0]
                  .shopId) {
        if (coupon.minOrder! <=
            Provider.of<CartController>(context, listen: false)
                .getSubtotal
                .toInt()) {
          if (coupon.discountType == 'percent') {
            double discount =
                (Provider.of<CartController>(context, listen: false).getTotal *
                        coupon.discount!.toDouble()) /
                    100;
            if (discount > double.parse(coupon.maxDiscount!)) {
              Provider.of<CartController>(context, listen: false)
                  .setCouponPrice(double.parse(coupon.maxDiscount!));
              Provider.of<CartController>(context, listen: false)
                  .calculateTotal();
              return true;
            } else {
              Provider.of<CartController>(context, listen: false)
                  .setCouponPrice(discount);
              Provider.of<CartController>(context, listen: false)
                  .calculateTotal();
              return true;
            }
          } else {
            print('flat discount');
            Provider.of<CartController>(context, listen: false)
                .setCouponPrice(coupon.discount!.toDouble());
            Provider.of<CartController>(context, listen: false)
                .calculateTotal();
            return true;
          }
        } else {
          Fluttertoast.showToast(
              msg: 'Minimum order value must be ${coupon.minOrder}');
          return false;
        }
      }
      //checking if coupon shop id == cart shop id then apply thi to all shops
      else {
        Fluttertoast.showToast(msg: 'Coupon not applicable');
        return false;
      }
    } else {
      Fluttertoast.showToast(msg: 'Coupon expired');
      return false;
    }
  }

  void onApplyCouponButtonPressed(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      barrierColor: Colors.black.withAlpha(1),
      builder: (_) => StatefulBuilder(
        builder: (_, setState) {
          return Container(
            // color: Colors.transparent,
            // padding: EdgeInsets.only(left: 16, top: 32),
            height: MediaQuery.of(context).size.height * .6,
            child: Column(
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: CircleAvatar(
                    backgroundColor: Colors.black,
                    child: Icon(
                      Icons.close,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                  width: double.infinity,
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Available Offers',
                        style: Theme.of(context).textTheme.headline6!.copyWith(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      Divider(
                        thickness: 1,
                      ),
                    ],
                  ),
                ),
                _coupons.isEmpty
                    ? Expanded(
                        child: Container(
                          color: Colors.white,
                          child: Center(
                            child: Text('No coupon available'),
                          ),
                        ),
                      )
                    : Expanded(
                        child: ListView.builder(
                          itemBuilder: (_, index) {
                            return Container(
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              color: Colors.white,
                              height: 140,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    _coupons[index].by!,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline4!
                                        .copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                  ),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  Text(
                                    _coupons[index].discountType == 'percent'
                                        ? '${_coupons[index].description} up to ₹${_coupons[index].maxDiscount}'
                                        : '${_coupons[index].description}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .copyWith(
                                          color: Colors.black,
                                        ),
                                  ),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  Text(
                                    'Valid on orders with minimum order value of ₹${_coupons[index].minOrder}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .caption!
                                        .copyWith(
                                            // color: Colors.black,
                                            ),
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 16, vertical: 4),
                                        decoration: BoxDecoration(
                                            color: Colors.blue.withOpacity(.1),
                                            border: Border.all(
                                              color:
                                                  Colors.blue.withOpacity(.3),
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(4)),
                                        child: Text(
                                          '${_coupons[index].code}',
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline6!
                                              .copyWith(
                                                  // color: Colors.black,
                                                  ),
                                        ),
                                      ),
                                      selectedCoupon == _coupons[index]
                                          ? TextButton(
                                              onPressed: () {},
                                              child: Text('APPLIED'),
                                            )
                                          : TextButton(
                                              onPressed: () {
                                                var res = checkCouponValidity(
                                                    context, _coupons[index]);
                                                if (res) {
                                                  setState(() {
                                                    selectedCoupon =
                                                        _coupons[index];
                                                  });

                                                  Navigator.pop(context);
                                                  Future.delayed(
                                                    Duration(milliseconds: 400),
                                                  ).then(
                                                    (value) => showDialog(
                                                      context: context,
                                                      barrierDismissible: false,
                                                      builder: (_) =>
                                                          AlertDialog(
                                                        content: Column(
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Lottie.asset(Constant
                                                                    .KLottieAsset +
                                                                'coupon_apply_success.json'),
                                                            Text(
                                                              'Coupon Applied',
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .headline6!
                                                                  .copyWith(
                                                                    color: Colors
                                                                        .black,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                  ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                  Future.delayed(
                                                          Duration(seconds: 2))
                                                      .then(
                                                    (value) =>
                                                        Navigator.pop(context),
                                                  );
                                                }
                                              },
                                              child: Text('APPLY'),
                                            )
                                    ],
                                  )
                                ],
                              ),
                            );
                          },
                          itemCount: _coupons.length,
                        ),
                      )
              ],
            ),
          );
        },
      ),
    );
  }

  List<CouponModel> get getCoupon {
    return _coupons;
  }
}
