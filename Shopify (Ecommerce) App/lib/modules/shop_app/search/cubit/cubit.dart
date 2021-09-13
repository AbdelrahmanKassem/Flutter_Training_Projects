import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_first_app/models/user/shop_app/shop_search_model.dart';
import 'package:my_first_app/modules/shop_app/search/cubit/states.dart';
import 'package:my_first_app/shared/components/constants.dart';
import 'package:my_first_app/shared/network/end_points.dart';
import 'package:my_first_app/shared/network/remote/dio_helper.dart';

import 'states.dart';

class ShopSearchCubit extends Cubit<ShopSearchStates>
{
  ShopSearchCubit() : super(ShopSearchInitState());

  static ShopSearchCubit get(context) => BlocProvider.of(context);

  late SearchModel searchModel;

  void getUserSearch({
  required String text,
})
  {
    emit(ShopSearchLoadingState());
    DioHelper.postData(
        url: SEARCH,
        authorization: token,
        data: {
          'text' : text,
        },
    ).then((value) {
      searchModel = SearchModel.fromJson(value.data);
      emit(ShopSearchSuccessState(searchModel));
    }).catchError((error){
      print(error.toString());
      emit(ShopSearchErrorState(error: error.toString()));
    });
  }
}