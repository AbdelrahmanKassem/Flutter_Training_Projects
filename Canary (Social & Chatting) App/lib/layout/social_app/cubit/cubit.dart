import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:my_first_app/layout/social_app/cubit/states.dart';
import 'package:my_first_app/models/user/social_app/chats_model.dart';
import 'package:my_first_app/models/user/social_app/post_model.dart';
import 'package:my_first_app/models/user/social_app/social_users_model.dart';
import 'package:my_first_app/modules/social_app/social_chats/chats_screen.dart';
import 'package:my_first_app/modules/social_app/social_feed/feeds_screen.dart';
import 'package:my_first_app/modules/social_app/social_notifications/notifications_screen.dart';
import 'package:my_first_app/modules/social_app/social_settings/settings_screen.dart';
import 'package:my_first_app/modules/social_app/social_users/users_screen.dart';
import 'package:my_first_app/shared/components/constants.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class SocialCubit extends Cubit<SocialState>
{
  SocialCubit() : super(SocialInitState());

  static SocialCubit get(context) => BlocProvider.of(context);

  SocialUserModel? model;

  void getUserData()
  {
    emit(SocialGetUserLoadingState());
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .get()
        .then((value){
          model = SocialUserModel.fromJSON(value.data()??{});
          print('isEmailVerified: ${model!.isEmailVerified}');
          emit(SocialGetUserSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(SocialGetUserErrorState());
    });

  }

  int currentIndex = 0;

  List<Widget> screens = [
    FeedsScreen(),
    ChatsScreen(),
    NotificationsScreen(),
    UsersScreen(),
    SettingsScreen(),
  ];

  List<String> titles = [
    'Home',
    'Chats',
    'Notifications',
    'Users',
    'Profile',
  ];

  void changeBottomNav(index){
    currentIndex = index;
    emit(SocialChangeBottomNavState());
  }

  var profileImage;
  var profilePicker = ImagePicker();
  Future getProfileImage() async
  {
    var pickedFile = await profilePicker.pickImage(source: ImageSource.gallery);
    if(pickedFile != null)
      {
        profileImage = pickedFile;
        emit(SocialEditProfileImageSuccessState());
        uploadProfilePicture();
      }
    else
      {
        print('No image selected.');
        emit(SocialEditProfileImageErrorState());
      }
  }
  var coverImage;
  var coverPicker = ImagePicker();
  Future getCoverImage() async
  {
    var pickedFile = await coverPicker.pickImage(source: ImageSource.gallery);
    if(pickedFile != null)
    {
      coverImage = pickedFile;
      emit(SocialEditCoverImageSuccessState());
      uploadCoverPicture();
    }
    else
    {
      print('No image selected.');
      emit(SocialEditCoverImageErrorState());
    }
  }

  String? profileImageUrl;
  void uploadProfilePicture()
  {
    firebase_storage.FirebaseStorage.instance.ref()
        .child('users/${Uri.file(profileImage.path).pathSegments.last}')
        .putFile(File(profileImage.path))
        .then((value){
          value.ref.getDownloadURL()
              .then((value){
                profileImageUrl = value;
                emit(SocialUploadProfileImageSuccessState());

          }).catchError((error){
            print(error.toString());
            emit(SocialUploadProfileImageErrorState());
          });
    })
        .catchError((error){
        print(error.toString());
        emit(SocialUploadProfileImageErrorState());
    });
  }

  String? coverImageUrl;
  void uploadCoverPicture()
  {
    firebase_storage.FirebaseStorage.instance.ref()
        .child('users/${Uri.file(coverImage.path).pathSegments.last}')
        .putFile(File(coverImage.path))
        .then((value){
      value.ref.getDownloadURL()
          .then((value){
        coverImageUrl = value;
        emit(SocialUploadCoverImageSuccessState());
      }).catchError((error){
        print(error.toString());
        emit(SocialUploadCoverImageErrorState());
      });
    })
        .catchError((error){
      print(error.toString());
      emit(SocialUploadCoverImageErrorState());
    });
  }
  
  void updateUser({
  required String name,
  required String bio,
  required String phone,
})
  {
    emit(SocialUpdateUserDataLoadingState());

    var updatedModel = model;
    updatedModel!.name = name;
    updatedModel!.bio = bio;
    updatedModel!.phone = phone;

    if(profileImage != null)
      {
        updatedModel.profileImage = profileImageUrl;
      }
    if(coverImage != null)
      {
        updatedModel.coverImage = coverImageUrl;
      }

    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .update(updatedModel.toMap())
        .then((value){
          emit(SocialUpdateUserDataSuccessState());
          getUserData();
    })
        .catchError((error){
      print(error.toString());
      emit(SocialUpdateUserDataErrorState());
    });
  }

  void clearUnsavedData()
  {
    profileImage = null;
    profileImageUrl = null;
    coverImage = null;
    coverImageUrl = null;
  }

  var postImage;
  var postPicker = ImagePicker();
  Future getPostImage() async
  {
    var pickedFile = await postPicker.pickImage(source: ImageSource.gallery);
    if(pickedFile != null)
    {
      postImage = pickedFile;
      emit(SocialAddPostImageSuccessState());
    }
    else
    {
      print('No image selected.');
      emit(SocialAddPostImageErrorState());
    }
  }

  void removePostImage()
  {
    postImage = null;
    postImageUrl = null;
    emit(SocialRemovePostImageState());
  }

  String? postImageUrl;
  void uploadPostImageAndCreatePost({
  required String postText,
})
  {
    firebase_storage.FirebaseStorage.instance.ref()
        .child('posts/${Uri.file(postImage.path).pathSegments.last}')
        .putFile(File(postImage.path))
        .then((value){
      value.ref.getDownloadURL()
          .then((value){
        postImageUrl = value;
        emit(SocialUploadPostImageSuccessState());
        createPost(postText: postText);
      }).catchError((error){
        print(error.toString());
        emit(SocialUploadPostImageErrorState());
      });
    })
        .catchError((error){
      print(error.toString());
      emit(SocialUploadPostImageErrorState());
    });
  }

  void createPost({
    required String postText,
  })
  {
    emit(SocialCreatePostLoadingState());

    var postModel = PostModel.fromJSON({
      'name': model!.name,
      'uId': model!.uId,
      'profileImage': model!.profileImage,
      'postText': postText,
      'postImage': postImageUrl??'',
      'dateTime': DateFormat.yMMMd().add_Hm().format(DateTime.now()),
    });

    FirebaseFirestore.instance
        .collection('posts')
        .add(postModel.toMap())
        .then((value){
      emit(SocialCreatePostSuccessState());
      getPosts();
    })
        .catchError((error){
          print(error.toString());
      emit(SocialCreatePostErrorState());
    });
  }

  List<PostModel> postsModel = [];
  List<String> postsId = [];
  List<int> likes = [];
  List<bool> isLiked = [];
  void getPosts()
  {
    emit(SocialGetPostsLoadingState());
    postsModel = [];
    FirebaseFirestore.instance
        .collection('posts')
        .orderBy('dateTime',descending: true)
        .get()
        .then((value){
      value.docs.forEach((element) {
        checkLikeButtonState(element.id).then((value){
            isLiked.add(value);
            element.reference
                .collection('likes')
                .get()
                .then((value){
              likes.add(value.docs.length);
              postsId.add('${element.id}');
              postsModel.add(PostModel.fromJSON(element.data()));
              emit(SocialGetPostsSuccessState());
            })
                .catchError((error){
              print(error.toString());
              emit(SocialGetPostsErrorState());
            });
          });
      });
    }).catchError((error){
      print(error.toString());
      emit(SocialGetPostsErrorState());
    });
  }

  void likePost(String postId)
  {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .doc(model!.uId)
        .set({
      'like':true,
    })
        .then((value){
          emit(SocialLikePostsSuccessState());
    })
        .catchError((error){
          emit(SocialLikePostsErrorState());
    });
  }

  void unLikePost(String postId)
  {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .doc(model!.uId)
        .delete()
        .then((value){
      emit(SocialUnLikePostsSuccessState());
    })
        .catchError((error){
      emit(SocialUnLikePostsErrorState());
    });
  }

  Future<bool> checkLikeButtonState(String postId)
  {
    late bool isPostLiked;
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .doc(model!.uId)
        .get()
        .then((value){
          if(value.data()?['like'] == null || value.data()!['like'] == false)
            {
              FirebaseFirestore.instance
                  .collection('posts')
                  .doc(postId)
                  .collection('likes')
                  .doc(model!.uId)
                  .delete()
                  .then((value){
                    isPostLiked = false;
              }).catchError((error){
                print(error.toString());
                isPostLiked = false;
              });
            }
          else
            {
              isPostLiked = true;
            }
    })
        .catchError((error){
          print(error.toString());
          isPostLiked = false;
    });

    return Future.delayed(Duration(seconds: 1),(){return isPostLiked;});
  }

  List<SocialUserModel> allUsersModel = [];
  void getAllUsers()
  {
    emit(SocialGetAllUsersLoadingState());
    allUsersModel = [];
    FirebaseFirestore.instance
        .collection('users')
        .get()
        .then((value){
      value.docs.forEach((element) {
        if(element.data()['uId'] != model!.uId)
          {
            allUsersModel.add(SocialUserModel.fromJSON(element.data()));
          }
        emit(SocialGetAllUsersSuccessState());
      });
    }).catchError((error){
      print(error.toString());
      emit(SocialGetAllUsersErrorState());
    });
  }

  void sendMessage({
  required String text,
  required String receiverId,
})
  {
    emit(SocialSendMessagesLoadingState());
    FirebaseFirestore.instance
        .collection('users')
        .doc(model!.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .add({
      'text' : text,
      'dateTime' : DateFormat.yMMMd().add_Hm().format(DateTime.now()),
      'senderId' : model!.uId,
      'receiverId' : receiverId,
    })
        .then((value){
          emit(SocialSendMessagesSuccessState());
    })
        .catchError((error){
          print(error.toString());
          emit(SocialSendMessagesErrorState());
    });

    FirebaseFirestore.instance
        .collection('users')
        .doc(receiverId)
        .collection('chats')
        .doc(model!.uId)
        .collection('messages')
        .add({
      'text' : text,
      'dateTime' : DateFormat.yMMMd().add_Hm().format(DateTime.now()),
      'senderId' : model!.uId,
      'receiverId' : receiverId,
    })
        .then((value){
      emit(SocialSendMessagesSuccessState());
    })
        .catchError((error){
      print(error.toString());
      emit(SocialSendMessagesErrorState());
    });
  }

  List<ChatsModel> messages = [];
  void getMessages({
  required String receiverId,
})
  {
    FirebaseFirestore.instance
        .collection('users')
        .doc(model!.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .orderBy('dateTime')
        .snapshots()
        .listen((event) {
          messages = [];
          event.docs.forEach((element) {
            messages.add(ChatsModel.fromJSON(element.data()));
          });
          emit(SocialGetMessagesSuccessState());
    });
  }


}