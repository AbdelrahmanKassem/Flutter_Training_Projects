

import 'package:my_first_app/models/user/social_app/social_users_model.dart';

abstract class SocialLoginStates {}

class SocialLoginInitState extends SocialLoginStates {}

class SocialLoginLoadingState extends SocialLoginStates {}

class SocialLoginSuccessState extends SocialLoginStates {
  String uId;
  SocialLoginSuccessState(this.uId);
}

class SocialLoginErrorState extends SocialLoginStates {
  final String error;

  SocialLoginErrorState({
    required this.error,
});
}

class SocialLoginChangePassVisibilityState extends SocialLoginStates {}