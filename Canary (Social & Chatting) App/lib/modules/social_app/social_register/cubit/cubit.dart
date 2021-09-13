
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_first_app/models/user/social_app/social_users_model.dart';
import 'package:my_first_app/modules/social_app/social_register/cubit/states.dart';

class SocialRegisterCubit extends Cubit<SocialRegisterStates> {
  SocialRegisterCubit() : super(SocialRegisterInitState());

  static SocialRegisterCubit get(context) => BlocProvider.of(context);

  void userRegister({
    required String name,
    required String email,
    required String password,
    required String phone,
  }) {
    emit(SocialRegisterLoadingState());
    FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    ).then((value) {
      print(value.user!.uid);
      userCreate(
          name: name,
          email: email,
          uId: value.user!.uid,
          phone: phone,
      );
      emit(SocialRegisterSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(SocialRegisterErrorState(error: error));
    });
  }

  void userCreate({
    required String name,
    required String email,
    required String uId,
    required String phone,
  }) {
    emit(SocialCreateUserLoadingState());
    SocialUserModel socialUserModel = SocialUserModel(
        name: name,
        uId: uId,
        phone: phone,
        email: email,
        isEmailVerified: false,
        profileImage : 'https://image.freepik.com/free-photo/portrait-beautiful-young-woman-standing-grey-wall_231208-10760.jpg',
        coverImage : 'https://image.freepik.com/free-photo/albino-girl-with-white-skin-natural-lips-white-hair-neon-light-isolated-black-studio-background_155003-21895.jpg',
        bio : 'We are Nigan',
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(socialUserModel.toMap(),)
      .then((value){
          emit(SocialCreateUserSuccessState());
    }).catchError((error){
          print(error.toString());
          emit(SocialCreateUserErrorState(error: error));
    });
  }

  bool isPassword = true;
  void changePasswordVisibility() {
    isPassword = !isPassword;
    emit(SocialRegisterChangePassVisibilityState());
  }
}