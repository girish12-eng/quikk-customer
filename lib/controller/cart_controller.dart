import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quikk_customer/helper/constants.dart';
import 'package:quikk_customer/models/cart_model.dart';
import 'package:quikk_customer/models/product_model.dart';
import 'package:quikk_customer/repository/market_repo.dart';

class CartController extends ChangeNotifier {
  late List<bool> isFirstSelected;
  List<CartModel> _cart = [];
  double _subTotal = 0.0;
  double _total = 0.0;
  double _cartTotal = 0.0;
  double _tax = 0.0;
  double _packagingCharge = 0.0;
  int _deliveryCharge = 0;
  int? _marketType;
  bool loading = false;
  double _couponPrice = 0;
  double _coinPrice = 0;

  void addOnCart(ProductModel product, int quantity, int shopId,
      BuildContext context, double packCharge, Variationss? chosenVariation) {
    print('i add to cart called');
    _packagingCharge = packCharge;
    CartModel cart = CartModel();
    cart.product = product;
    cart.quantity = quantity;
    cart.shopId = shopId;
    cart.variation = chosenVariation ?? Variationss();
    // cart.variationIndex = variationIndex ?? -1;
    if (_cart.isEmpty) {
      _cart.add(cart);
      // print('i add to cart called' + cart.product.name.toString());
      // print('i add to cart called' + cart.product.variationss!.join(''));
      // print('i add to cart called' + cart.product.variationss![0].name.toString());
      // print('i add to cart called' + cart.product.toString().toString());
      calculateTotal();
    } else if (_cart[0].shopId == shopId) {
      int i = _cart.indexWhere((element) => element.product.id == product.id);
      if (i != -1) {
        _cart[i].quantity++;
        calculateTotal();
        return;
      }
      _cart.add(cart);
      calculateTotal();
    } else {
      showDialog(
          context: context,
          builder: (_) {
            return AlertDialog(
              title: Text(
                'Replace cart item?',
              ),
              content: Text(
                'Your cart contains products from other market.Do you want to discard the selection and add products from this market?',
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      color: Colors.black38,
                    ),
              ),
              actions: [
                TextButton(
                  style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all(
                      Color(Constant.KPrimaryColor),
                    ),
                  ),
                  onPressed: () =>
                      Future.delayed(Duration(milliseconds: 400)).then(
                    (value) => Navigator.pop(context),
                  ),
                  child: Text(
                    'Cancel',
                    style: Theme.of(context).textTheme.button!.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Color(Constant.KPrimaryColor)),
                  ),
                ),
                // ElevatedButton(
                // ),
                TextButton(
                  style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all(
                      Color(Constant.KPrimaryColor),
                    ),
                  ),
                  onPressed: () {
                    Future.delayed(Duration(milliseconds: 400)).then((value) {
                      clearCart();
                      _cart.add(cart);
                      calculateTotal();

                      Navigator.pop(context);
                    });
                  },
                  child: Text(
                    'Accept',
                    style: Theme.of(context).textTheme.button!.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Color(Constant.KPrimaryColor),
                        ),
                  ),
                )
              ],
            );
          });
    }
    notifyListeners();
  }

  void incrementQuantity(int index) {
    _cart[index].quantity++;
    calculateTotal();
    notifyListeners();
  }

  void decrementQuantity(int index) {
    if (_cart[index].quantity > 1) {
      _cart[index].quantity--;
      calculateTotal();
    } else {
      _cart.removeAt(index);
      calculateTotal();
    }
    notifyListeners();
  }



  void clearCart() {
    _cart.clear();
    _couponPrice = 0;
    _coinPrice = 0;
    _subTotal = 0.0;
    _tax = 0.0;
    _coinPrice = 0;
    _couponPrice = 0;
    // _packagingCharge = 0.0;
    // _deliveryCharge = 0;
    _total = 0.0;
    _cartTotal = 0;
    notifyListeners();
  }

  void calculateTotal() async {
    _subTotal = 0.0;
    _total = 0.0;
    _cartTotal = 0;
    _tax = 0;
    if (_cart.isEmpty) {
      // _deliveryCharge = 0;
    }


    _cart.forEach((element) {
      print("with variation 3");
      print("with variation 3" +element.variation.price.toString());
      print("with variation 3" + element.variation.discountPrice.toString());
      if(element.variation.name == null)
        {
          print("without variation 1");
          print("with variation 1" +element.product.unitPrice.toString());
          print("with variation 1" + element.product.discountPrice.toString());
          _subTotal += (double.parse(element.product.unitPrice!) -
              double.parse(element.product.discountPrice!)) *
              element.quantity;
          notifyListeners();
        }
      else{
        print("with variation 2");
        print("with variation 2" +element.variation.price.toString());
        print("with variation 2" + element.variation.discountPrice.toString());

        _subTotal += (double.parse(element.variation.price!) -
            double.parse(element.variation.discountPrice!)) *
            element.quantity;
        notifyListeners();
      }

      // deliveryCharge =
    });
    print('before');
    print(_subTotal);
    print('after');
    print(_subTotal);
    //api call for delivery charge

    await setDeliveryCharges();
    if (_marketType == 1) {
      _tax = ((_subTotal + _deliveryCharge + _packagingCharge) * 5) / 100;
      _cartTotal += _subTotal + _deliveryCharge + _tax + _packagingCharge;
    } else {
      _cartTotal += _subTotal + _deliveryCharge + _packagingCharge;
    }
    _total += _cartTotal - _couponPrice - _coinPrice;
    notifyListeners();
  }

  List<CartModel> get getCart {
    // print("CART ITEM DATA" + _cart[0].variation.name.toString());
    // print("CART ITEM DATA" + _cart[0].product.name.toString());
    // print("CART ITEM DATA" + _cart[0].quantity.toString());
    // print("CART ITEM DATA" + _cart[0].product.unitPrice.toString());
    return _cart;
  }

  Future<void> setDeliveryCharges() async {
    loading = true;
    // await Future.delayed(Duration(seconds: 4));
    _deliveryCharge = await getDeliveryChargeRepo(_subTotal.toInt());
    loading = false;
    notifyListeners();
  }

  int get getDeliveryCharge {
    return _deliveryCharge;
  }

  double get getSubtotal {
    return _subTotal;
  }

  double get getTotal {
    return _total;
  }

  void setPackagingCharge(String packagingCharge) async {
    _packagingCharge = double.parse(packagingCharge);
  }

  void setMarketType(int type) async {
    _marketType = type;
  }

  double get getPackagingCharge {
    return _packagingCharge;
  }

  int get getMarketType {
    return _marketType!;
  }

  double get getTax {
    return _tax;
  }

  double? get getCouponPrice {
    return _couponPrice;
  }

  double? get getCoinPrice {
    return _coinPrice;
  }

  void setCouponPrice(double value) {
    _couponPrice = value;
    notifyListeners();
  }

  void setCoinPrice(double value) {
    _coinPrice = value;
    notifyListeners();
  }
}
