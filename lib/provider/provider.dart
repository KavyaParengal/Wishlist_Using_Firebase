import 'package:flutter/cupertino.dart';

class Provider_class extends ChangeNotifier{
  List _wish=[];
  List _price=[];
  List get titleWish=>_wish;
  List get priceWish=>_price;

  void fulfilled(String title, String price){
    final fulfillItem=_wish.contains(title);
    if(fulfillItem){
      _wish.remove(title);
      _price.remove(price);
    }
    else{
      _wish.add(title);
      _price.add(price);
    }
    notifyListeners();
  }

  bool icn_change(String title){
    final fulfillIcn=_wish.contains(title);
    return fulfillIcn;
  }
}
