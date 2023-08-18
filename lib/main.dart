
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wishlist/auth_controller.dart';
import 'package:wishlist/wishlistLogReg.dart';

Future <void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp().then((value)=>Get.put(AuthController()));
  runApp(
    GetMaterialApp(
      home: WishlistLoginRegi(),
      debugShowCheckedModeBanner: false,
    )
  );
}