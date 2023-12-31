
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:wishlist/wishlistLogReg.dart';

import 'homepage.dart';

class AuthController extends GetxController{
  static AuthController instance=Get.find();
  late Rx<User?> _user;
  FirebaseAuth auth=FirebaseAuth.instance;

  @override
  void onReady(){
    super.onReady();
    _user = Rx<User?>(auth.currentUser);
    _user.bindStream(auth.userChanges());
    ever(_user, _initialScreen);
  }

  _initialScreen(User? user) {
    if(user==null){
      print("Login page");
      Get.offAll(()=>WishlistLoginRegi());
    }
    else{
      Get.offAll(()=>HomePage());
      print('Email= ${user.email}');
    }
  }

  void register(String email,password) async {
    try{
      await auth.createUserWithEmailAndPassword(email: email, password: password);
      Get.offAll(()=>WishlistLoginRegi());
    }
    catch(e){
      Get.snackbar("About user", "User message", backgroundColor: Colors.red,
          snackPosition: SnackPosition.BOTTOM,
          titleText: Text("Account creation failed"),
          messageText: Text(e.toString()));
    }
  }

  void login(String email,password) async {
    try{
      await auth.signInWithEmailAndPassword(email: email, password: password);
    }
    catch(e){
      Get.snackbar("About Login", "Login message", backgroundColor: Colors.red,
          snackPosition: SnackPosition.BOTTOM,
          titleText: Text("Login failed"),
          messageText: Text(e.toString()));
    }
  }

  void logout() async{
    await auth.signOut();
  }
}


