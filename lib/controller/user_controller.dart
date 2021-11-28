import 'package:flutter/cupertino.dart';
import 'package:quikk_customer/models/user_model.dart';

class UserController extends ChangeNotifier {
  late UserModel _model;

  UserModel get getUserModel {
    return _model;
  }

  set setUserModel(UserModel model) {
    _model = model;
  }
}
