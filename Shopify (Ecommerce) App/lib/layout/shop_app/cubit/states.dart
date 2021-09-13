import 'package:my_first_app/models/user/shop_app/shop_change_favorites_model.dart';

abstract class ShopStates {}

class ShopInitState extends ShopStates {}

class ShopChangeBottomNavState extends ShopStates {}

class ShopLoadingHomeDataState extends ShopStates {}

class ShopSuccessHomeDataState extends ShopStates {}

class ShopErrorHomeDataState extends ShopStates {}

class ShopSuccessCategoriesState extends ShopStates {}

class ShopErrorCategoriesState extends ShopStates {}

class ShopSuccessFavoritesState extends ShopStates
{
  ChangeFavoritesModel? model;

  ShopSuccessFavoritesState(this.model);
}

class ShopUpdateFavoritesIconState extends ShopStates {}

class ShopErrorFavoritesState extends ShopStates {}

class ShopLoadingGetFavoritesState extends ShopStates {}

class ShopSuccessGetFavoritesState extends ShopStates {}

class ShopErrorGetFavoritesState extends ShopStates {}

class ShopLoadingUserDataState extends ShopStates {}

class ShopSuccessUserDataState extends ShopStates {}

class ShopErrorUserDataState extends ShopStates {}

class ShopLoadingUpdateProfileState extends ShopStates {}

class ShopSuccessUpdateProfileState extends ShopStates {}

class ShopErrorUpdateProfileState extends ShopStates {}
