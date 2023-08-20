

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wishlist/auth_controller.dart';
import 'package:wishlist/provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  TextEditingController priceController=TextEditingController();
  TextEditingController wishController=TextEditingController();


  final CollectionReference _wishes =
  FirebaseFirestore.instance.collection('wishes');

  Future<void> _create([DocumentSnapshot? documentSnapshot]) async {
    if (documentSnapshot != null) {
      wishController.text = documentSnapshot['wish'];
      priceController.text = documentSnapshot['price'].toString();
    }
    await showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom + 100,
              top: 16,
              left: 16,
              right: 16
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.add_a_photo,size: 36,color: Colors.grey.shade400,),
                  ),
                  Spacer(),
                  Expanded(
                    child: TextFormField(
                      controller: priceController,
                      decoration: InputDecoration(
                        hintText: 'Price', // Use labelText for labels
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        fillColor: Colors.grey.shade300,
                        filled: true,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              TextFormField(
                controller: wishController,
                decoration: InputDecoration(
                  hintText: 'Your wish',
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  fillColor: Colors.grey.shade300,
                  filled: true,
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  final String wishesName = wishController.text;
                  final double? price = double.parse(priceController.text);
                  if (price != null) {
                    await _wishes.add({'wish': wishesName, 'price': price});
                    wishController.text = '';
                    priceController.text = '';
                  }
                  Navigator.pop(context);
                },
                child: Text('Add to my list', style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                  color: Colors.white,
                ),),
                style: ElevatedButton.styleFrom(fixedSize: Size(MediaQuery.of(context).size.width, 50),backgroundColor: Colors.black),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context){
        
        final object= Provider.of<Provider_class>(context);
        List titleStore=object.titleWish;
        List priceStore=object.priceWish;
        
        return Scaffold(
          body: DefaultTabController(
            length: 2,
            child: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 20, left: 20, top: 12),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Wish list",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 25,
                              color: Colors.black,
                            ),
                          ),
                          Row(
                            children: [
                              const CircleAvatar(
                                radius: 18,
                                backgroundColor: Colors.black,
                                child: Text(
                                  "O",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              IconButton(
                                  onPressed: (){
                                    AuthController.instance.logout();
                                  },
                                  icon: const Icon(Icons.logout,color: Colors.black,)
                              )
                            ],
                          ),

                        ]),
                  ),
                  const SizedBox(height: 10),
                  TabBar(
                    indicatorSize: TabBarIndicatorSize.label,
                    labelStyle:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
                    labelColor: Colors.black,
                    unselectedLabelColor: Colors.grey.shade600,
                    indicator: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.transparent, // Remove the underline color
                          width: 2.0, // Set the indicator thickness
                        ),
                      ),
                    ),
                    padding: EdgeInsets.only(top: 0, bottom: 20),
                    tabs: [
                      Tab(text: "Wishes"),
                      Tab(text: "Fulfilled"),
                    ],
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        Column(
                          children: [
                            StreamBuilder(
                              stream: _wishes.snapshots(),
                              builder: (BuildContext context,
                                  AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                                if (streamSnapshot.hasData) {
                                  return ListView.separated(
                                    itemBuilder: (context,index){
                                      final DocumentSnapshot documentSnapshot =
                                      streamSnapshot.data!.docs[index];
                                      return Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Image.asset('images/quote1.jpg',
                                                  width: 50,
                                                  height: 50,
                                                ),
                                                const SizedBox(width: 22,),
                                                Column(
                                                  mainAxisAlignment: MainAxisAlignment.start ,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text(documentSnapshot['wish'],style: TextStyle(
                                                        fontWeight: FontWeight.bold,
                                                        fontSize: 18
                                                    ),),
                                                    SizedBox(height: 6,),
                                                    Text('\$ ${documentSnapshot['price']}')
                                                  ],
                                                ),
                                              ],
                                            ),
                                            IconButton(
                                                onPressed: (){
                                                  object.fulfilled(documentSnapshot['wish'], documentSnapshot['price'].toString());
                                                },
                                                icon: object.icn_change(documentSnapshot['wish']) ?
                                                Icon(Icons.check_box) :
                                                Icon(Icons.check_box_outline_blank)
                                            )
                                          ],
                                        ),
                                      );
                                    },
                                    separatorBuilder: (BuildContext context, int index) => const Divider(),
                                    itemCount: streamSnapshot.data!.docs.length,
                                    shrinkWrap: true,
                                  );
                                }
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              },
                            )
                          ],
                        ),
                        Column(
                          children: [
                            ListView.separated(
                              scrollDirection: Axis.vertical,
                              itemBuilder: (context,index){
                                if (index < titleStore.length && index < priceStore.length) {
                                  return Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Image.asset('images/quote1.jpg',
                                              width: 50,
                                              height: 50,
                                            ),
                                            const SizedBox(width: 22,),
                                            Column(
                                              mainAxisAlignment: MainAxisAlignment.start ,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(titleStore[index],style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18
                                                ),),
                                                SizedBox(height: 6,),
                                                Text('\$ ${priceStore[index]}')
                                              ],
                                            ),
                                          ],
                                        ),
                                        IconButton(
                                            onPressed: (){
                                              object.fulfilled(titleStore[index], priceStore[index]);
                                            },
                                            icon: object.icn_change(titleStore[index]) ?
                                            Icon(Icons.check_box) :
                                            Icon(Icons.check_box_outline_blank)
                                        )
                                      ],
                                    ),
                                  );
                                }
                                else{
                                  return Center(child: CircularProgressIndicator(),);
                                }
                              },
                              separatorBuilder: (BuildContext context, int index) => const Divider(),
                              itemCount: titleStore.length,
                              shrinkWrap: true,
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.black,
            onPressed: () {
              _create();
            },
            child: const Icon(
              Icons.add,
              size: 30,
            ),
          ),
        );
      },
    );
  }

}
