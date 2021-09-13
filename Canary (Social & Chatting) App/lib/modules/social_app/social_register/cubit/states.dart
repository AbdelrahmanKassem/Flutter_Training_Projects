
abstract class SocialRegisterStates {}

class SocialRegisterInitState extends SocialRegisterStates {}

class SocialRegisterLoadingState extends SocialRegisterStates {}

class SocialRegisterSuccessState extends SocialRegisterStates {/*
  SocialLoginModel loginModel;
  SocialRegisterSuccessState(this.loginModel);*/
}

class SocialRegisterErrorState extends SocialRegisterStates {
  final String error;

  SocialRegisterErrorState({
    required this.error,
});
}

class SocialCreateUserLoadingState extends SocialRegisterStates {}

class SocialCreateUserSuccessState extends SocialRegisterStates {/*
  SocialLoginModel loginModel;
  SocialRegisterSuccessState(this.loginModel);*/
}

class SocialCreateUserErrorState extends SocialRegisterStates {
  final String error;

  SocialCreateUserErrorState({
    required this.error,
  });
}

class SocialRegisterChangePassVisibilityState extends SocialRegisterStates {}