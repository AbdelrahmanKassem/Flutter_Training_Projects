import 'package:my_first_app/models/user/shop_app/shop_search_model.dart';
import 'package:my_first_app/models/user/shop_app/shop_search_model.dart';

abstract class ShopSearchStates {}

class ShopSearchInitState extends ShopSearchStates {}

class ShopSearchLoadingState extends ShopSearchStates {}

class ShopSearchSuccessState extends ShopSearchStates {
  SearchModel searchModel;
  ShopSearchSuccessState(this.searchModel);
}

class ShopSearchErrorState extends ShopSearchStates {
  final String error;

  ShopSearchErrorState({
    required this.error,
});
}

class ShopSearchChangePassVisibilityState extends ShopSearchStates {}