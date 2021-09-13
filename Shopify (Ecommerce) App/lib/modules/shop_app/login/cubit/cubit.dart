import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_first_app/models/user/shop_app/shop_login_model.dart';
import 'package:my_first_app/modules/shop_app/login/cubit/states.dart';
import 'package:my_first_app/shared/network/end_points.dart';
import 'package:my_first_app/shared/network/remote/dio_helper.dart';

class ShopLoginCubit extends Cubit<ShopLoginStates>
{
  ShopLoginCubit() : super(ShopLoginInitState());

  static ShopLoginCubit get(context) => BlocProvider.of(context);

  late ShopLoginModel loginModel;

  void userLogin({
    required String email,
    required String password,
})
  {
    emit(ShopLoginLoadingState());
    DioHelper.postData(
        url: LOGIN,
        data: {
          'email':email,
          'password' : password,
        },
    ).then((value) {
      loginModel = ShopLoginModel.fromJson(json: value.data);
      emit(ShopLoginSuccessState(loginModel));
    }).catchError((error){
      print(error.toString());
      emit(ShopLoginErrorState(error: error.toString()));
    });
  }

  bool isPassword = true;
  void changePasswordVisibility()
  {
    isPassword = !isPassword;
    emit(ShopLoginChangePassVisibilityState());
  }
}