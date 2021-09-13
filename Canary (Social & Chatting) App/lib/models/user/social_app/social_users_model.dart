class SocialUserModel
{
  String? name;
  String? uId;
  String? phone;
  String? email;
  bool? isEmailVerified;
  String? profileImage;
  String? coverImage;
  String? bio;

  SocialUserModel({
    required this.name,
    required this.uId,
    required this.phone,
    required this.email,
    required this.isEmailVerified,
    required this.profileImage,
    required this.coverImage,
    required this.bio,
});
  SocialUserModel.fromJSON(Map<String,dynamic> json)
  {
    name = json['name'];
    uId = json['uId'];
    phone = json['phone'];
    email = json['email'];
    isEmailVerified = json['isEmailVerified'];
    profileImage = json['profileImage'];
    coverImage = json['coverImage'];
    bio = json['bio'];
  }

  Map<String,dynamic> toMap()
  {
    return {
      'name' : name,
      'uId' : uId,
      'phone' : phone,
      'email' : email,
      'isEmailVerified' : isEmailVerified,
      'profileImage' : profileImage,
      'coverImage' : coverImage,
      'bio' : bio,
    };
  }
}