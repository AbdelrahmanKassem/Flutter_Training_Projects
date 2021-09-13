import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_first_app/models/user/shop_app/shop_login_model.dart';
import 'package:my_first_app/modules/shop_app/login/cubit/states.dart';
import 'package:my_first_app/modules/shop_app/register/cubit/states.dart';
import 'package:my_first_app/shared/network/end_points.dart';
import 'package:my_first_app/shared/network/remote/dio_helper.dart';

class ShopRegisterCubit extends Cubit<ShopRegisterStates>
{
  ShopRegisterCubit() : super(ShopRegisterInitState());

  static ShopRegisterCubit get(context) => BlocProvider.of(context);

  late ShopLoginModel loginModel;

  void userRegister({
    required String name,
    required String email,
    required String password,
    required String phone,
})
  {
    emit(ShopRegisterLoadingState());
    DioHelper.postData(
        url: REGISTER,
        data: {
          'name':name,
          'email':email,
          'password' : password,
          'phone' : phone,
        },
    ).then((value) {
      loginModel = ShopLoginModel.fromJson(json: value.data);
      emit(ShopRegisterSuccessState(loginModel));
    }).catchError((error){
      print(error.toString());
      emit(ShopRegisterErrorState(error: error.toString()));
    });
  }

  bool isPassword = true;
  void changePasswordVisibility()
  {
    isPassword = !isPassword;
    emit(ShopRegisterChangePassVisibilityState());
  }
}