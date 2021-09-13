class PostModel
{
  String? profileImage;
  String? name;
  String? uId;
  String? dateTime;
  String? postText;
  String? postImage;

  PostModel({
    required this.name,
    required this.uId,
    required this.dateTime,
    required this.postText,
    required this.postImage,
    required this.profileImage,
  });
  PostModel.fromJSON(Map<String,dynamic> json)
  {
    name = json['name'];
    uId = json['uId'];
    dateTime = json['dateTime'];
    postText = json['postText'];
    postImage = json['postImage'];
    profileImage = json['profileImage'];
  }

  Map<String,dynamic> toMap()
  {
    return {
      'name' : name,
      'uId' : uId,
      'dateTime' : dateTime,
      'postText' : postText,
      'postImage' : postImage,
      'profileImage' : profileImage,
    };
  }
}