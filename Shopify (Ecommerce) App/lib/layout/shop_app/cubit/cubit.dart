import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_first_app/layout/shop_app/cubit/states.dart';
import 'package:my_first_app/models/user/shop_app/shop_categories_model.dart';
import 'package:my_first_app/models/user/shop_app/shop_change_favorites_model.dart';
import 'package:my_first_app/models/user/shop_app/shop_favorites_model.dart';
import 'package:my_first_app/models/user/shop_app/shop_home_model.dart';
import 'package:my_first_app/models/user/shop_app/shop_login_model.dart';
import 'package:my_first_app/modules/shop_app/categories/categories_screen.dart';
import 'package:my_first_app/modules/shop_app/favorites/favorites_screen.dart';
import 'package:my_first_app/modules/shop_app/products/products_screen.dart';
import 'package:my_first_app/modules/shop_app/settings/settings_screen.dart';
import 'package:my_first_app/shared/components/components.dart';
import 'package:my_first_app/shared/components/constants.dart';
import 'package:my_first_app/shared/network/end_points.dart';
import 'package:my_first_app/shared/network/local/cache_helper.dart';
import 'package:my_first_app/shared/network/remote/dio_helper.dart';

class ShopCubit extends Cubit<ShopStates>
{
  ShopCubit() : super(ShopInitState());

  static ShopCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> bottomScreens = [
    ProductsScreen(),
    CategoriesScreen(),
    FavoritesScreen(),
    SettingsScreen(),
  ];

  void changeNavBar(index)
  {
    currentIndex = index;
    emit(ShopChangeBottomNavState());
  }

  HomeModel? homeModel;
  Map<int?,bool?> favorites = {};

  void getHomeData()
  {
    emit(ShopLoadingHomeDataState());

    DioHelper.getData(
      url: HOME,
      token: token,
    ).then((value)
    {
      homeModel = HomeModel.fromJson(value.data);
      homeModel!.data!.products.forEach((element) {
        favorites.addAll({
          element.id : element.inFavorites,
        });
      });
      emit(ShopSuccessHomeDataState());
    }).catchError((error)
    {
      print(error.toString());
      emit(ShopErrorHomeDataState());
    });
  }

  CategoriesModel? categoriesModel;

  void getCategoriesData()
  {
    DioHelper.getData(
      url: CATEGORIES,
    ).then((value)
    {
      categoriesModel = CategoriesModel.fromJson(value.data);
      emit(ShopSuccessCategoriesState());
    }).catchError((error)
    {
      print(error.toString());
      emit(ShopErrorCategoriesState());
    });
  }

  ChangeFavoritesModel? changeFavoritesModel;

  void changeFavorites(int? productID)
  {
    if(favorites[productID] != null)
      {
        bool? x = favorites[productID];
        favorites[productID] = ((x != null)? !x : null);
      }
    emit(ShopUpdateFavoritesIconState());
    emit(ShopLoadingGetFavoritesState());
    DioHelper.postData(
      url: FAVORITES,
      data: {
        'product_id' : productID,
      },
      authorization: token,
    ).then((value)
    {
      changeFavoritesModel = ChangeFavoritesModel.fromJson(value.data);
      if(changeFavoritesModel!.status == false)
        {
          if(favorites[productID] != null)
          {
            bool? x = favorites[productID];
            favorites[productID] = ((x != null)? !x : null);
          }
        }
      else
        {
          getFavoritesData();
        }
      emit(ShopSuccessFavoritesState(changeFavoritesModel));
    }).catchError((error)
    {
      print(error.toString());
      emit(ShopErrorFavoritesState());
    });
  }

  FavoritesModel? favoritesModel;

  void getFavoritesData()
  {
    DioHelper.getData(
      url: FAVORITES,
      token: token,
    ).then((value)
    {
      favoritesModel = FavoritesModel.fromJson(value.data);
      emit(ShopSuccessGetFavoritesState());
    }).catchError((error)
    {
      print(error.toString());
      emit(ShopErrorGetFavoritesState());
    });
  }

  ShopLoginModel? shopUserData;

  void getUserData()
  {
    emit(ShopLoadingUserDataState());
    DioHelper.getData(
      url: PROFILE,
      token: token,
    ).then((value)
    {
      shopUserData = ShopLoginModel.fromJson(json: value.data);
      emit(ShopSuccessUserDataState());
    }).catchError((error)
    {
      print(error.toString());
      emit(ShopErrorUserDataState());
    });
  }

  ShopLoginModel? shopUpdateProfile;

  void updateUserProfile({
  required String name,
  required String email,
  required String phone,
})
  {
    emit(ShopLoadingUpdateProfileState());
    DioHelper.putData(
      url: UPDATE,
      authorization: token,
      data: {
        'name' : name,
        'email' : email,
        'phone' : phone,
      }
    ).then((value)
    {
      shopUpdateProfile = ShopLoginModel.fromJson(json: value.data);
      emit(ShopSuccessUpdateProfileState());
    }).catchError((error)
    {
      print(error.toString());
      emit(ShopErrorUpdateProfileState());
    });
  }
}