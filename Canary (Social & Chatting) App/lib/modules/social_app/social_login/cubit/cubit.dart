import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_first_app/modules/social_app/social_login/cubit/states.dart';
import 'package:my_first_app/shared/network/end_points.dart';
import 'package:my_first_app/shared/network/remote/dio_helper.dart';

class SocialLoginCubit extends Cubit<SocialLoginStates>
{
  SocialLoginCubit() : super(SocialLoginInitState());

  static SocialLoginCubit get(context) => BlocProvider.of(context);

  void userLogin({
    required String email,
    required String password,
})
  {
    emit(SocialLoginLoadingState());
    FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    ).then((value) {
      print(value.user!.email);
      emit(SocialLoginSuccessState(value.user!.uid));
    }).catchError((error){
      print(error.toString());
      print(error.toString());
      emit(SocialLoginErrorState(error: error.toString()));
    });
  }

  bool isPassword = true;
  void changePasswordVisibility()
  {
    isPassword = !isPassword;
    emit(SocialLoginChangePassVisibilityState());
  }
}