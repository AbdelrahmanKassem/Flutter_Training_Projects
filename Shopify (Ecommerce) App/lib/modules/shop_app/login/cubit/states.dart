import 'package:my_first_app/models/user/shop_app/shop_login_model.dart';

abstract class ShopLoginStates {}

class ShopLoginInitState extends ShopLoginStates {}

class ShopLoginLoadingState extends ShopLoginStates {}

class ShopLoginSuccessState extends ShopLoginStates {
  ShopLoginModel loginModel;
  ShopLoginSuccessState(this.loginModel);
}

class ShopLoginErrorState extends ShopLoginStates {
  final String error;

  ShopLoginErrorState({
    required this.error,
});
}

class ShopLoginChangePassVisibilityState extends ShopLoginStates {}