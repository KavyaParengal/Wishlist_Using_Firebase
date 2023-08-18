import 'package:flutter/material.dart';
import 'package:wishlist/auth_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  TextEditingController priceController=TextEditingController();
  TextEditingController wishController=TextEditingController();

  @override
  Widget build(BuildContext context) {
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
                            backgroundColor: Colors.lightBlue,
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
                              icon: const Icon(Icons.logout,color: Colors.lightBlue,)
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
                        ListView.separated(
                            itemBuilder: (context,index){
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
                                        const Column(
                                          mainAxisAlignment: MainAxisAlignment.start ,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text('Motivation wish',style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18
                                            ),),
                                            SizedBox(height: 6,),
                                            Text('\$ 400')
                                          ],
                                        ),
                                      ],
                                    ),
                                    IconButton(
                                        onPressed: (){},
                                        icon: const Icon(Icons.check_box_outline_blank)
                                    )
                                  ],
                                ),
                              );
                            },
                            separatorBuilder: (BuildContext context, int index) => const Divider(),
                            itemCount: 3,
                          shrinkWrap: true,
                        )
                      ],
                    ),
                    Column(
                      children: [
                        ListView.separated(
                          itemBuilder: (context,index){
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
                                      const Column(
                                        mainAxisAlignment: MainAxisAlignment.start ,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text('Motivation wish',style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18
                                          ),),
                                          SizedBox(height: 6,),
                                          Text('\$ 4000')
                                        ],
                                      ),
                                    ],
                                  ),
                                  IconButton(
                                      onPressed: (){},
                                      icon: const Icon(Icons.check_box_outline_blank)
                                  )
                                ],
                              ),
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) => const Divider(),
                          itemCount: 3,
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
        backgroundColor: Colors.lightBlue,
        onPressed: () {
          _showBottomSheet();
        },
        child: const Icon(
          Icons.add,
          size: 30,
        ),
      ),
    );
  }

  void _showBottomSheet() {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(16),
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
                        labelText: 'Price', // Use labelText for labels
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
                  labelText: 'Your wish', // Use labelText for labels
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  fillColor: Colors.grey.shade300,
                  filled: true,
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {},
                child: Text('Add to my list', style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                  color: Colors.white,
                ),),
                style: ElevatedButton.styleFrom(fixedSize: Size(MediaQuery.of(context).size.width, 50),backgroundColor: Colors.lightBlue),
              ),
            ],
          ),
        );
      },
    );
  }

}
