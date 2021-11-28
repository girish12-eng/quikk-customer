import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:quikk_customer/models/order_model.dart';
import 'package:quikk_customer/repository/order_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrderHistoryController extends ChangeNotifier {
  late SharedPreferences _preferences;
  late List<OrderModel> _orders;
  bool _loading = false;
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  Future<void> init() async {
    _orders = [];
    getOrderHistory();
  }

  bool get getLoading {
    return _loading;
  }

  List<OrderModel> get getOrders {
    return _orders;
  }

  void getOrderHistory() async {
    _loading = true;
    // notifyListeners();
    _preferences = await SharedPreferences.getInstance();
    String? token = _preferences.getString('token');
    _orders = await getOrderHistoryRepo(token!);
    _loading = false;
    notifyListeners();
  }

  void setOrderRating(String orderId, String rating) async {
    _loading = true;
    bool res = await setRatingOrderRepo(orderId, rating);
    if (res) {
      Fluttertoast.showToast(msg: 'Thank you! your rating matters a lot');
      init();
      return;
    }

    _loading = false;
  }

  RefreshController get getRefreshController {
    return _refreshController;
  }
}
