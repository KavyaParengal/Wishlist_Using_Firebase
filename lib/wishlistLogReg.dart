import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:wishlist/auth_controller.dart';
import 'package:wishlist/homepage.dart';

class WishlistLoginRegi extends StatefulWidget {
  const WishlistLoginRegi({Key? key}) : super(key: key);

  @override
  State<WishlistLoginRegi> createState() => _WishlistLoginRegiState();
}

class _WishlistLoginRegiState extends State<WishlistLoginRegi> {

  TextEditingController uNameController=TextEditingController();
  TextEditingController passwordController=TextEditingController();
  TextEditingController emailController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 2,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: MediaQuery.of(context).size.height*.22),
            const Text(
              "Wishly",
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 41,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 30),

            TabBar(
              indicatorSize: TabBarIndicatorSize.label,
              labelStyle: const TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.w900
              ),
              indicator: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.transparent, // Remove the underline color
                    width: 2.0, // Set the indicator thickness
                  ),
                ),
              ),
              labelColor: Colors.black,
              unselectedLabelColor: Colors.grey.shade600,
              padding: const EdgeInsets.only(top: 15,bottom: 28),
              tabs: [
                Tab(text: "Login"),
                Tab(text: "Register"),
              ],
            ),

            Expanded(
              child: TabBarView(
                children: [
                  Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: 30, left: 30),
                        child: TextField(
                          controller: uNameController,
                          decoration: InputDecoration(
                            hintText: "Username",
                            hintStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 20,
                            ),
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            fillColor: Colors.grey.shade300,
                            filled: true,
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Padding(
                        padding: EdgeInsets.only(right: 30, left: 30),
                        child: TextField(
                          controller: passwordController,
                          decoration: InputDecoration(
                            hintText: "Password",
                            hintStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 20,
                            ),
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            fillColor: Colors.grey.shade300,
                            filled: true,
                          ),
                        ),
                      ),
                      SizedBox(height: 35),
                      ElevatedButton(
                        onPressed: () {
                          AuthController.instance.login(uNameController.text.trim(), passwordController.text.trim());
                        },
                        child: Text(
                          "Login",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          fixedSize: Size(240, 54),
                          primary: Colors.black,
                        ),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: 30, left: 30),
                        child: TextField(
                          controller: emailController,
                          decoration: InputDecoration(
                            hintText: "Email",
                            hintStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 20,
                            ),
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            fillColor: Colors.grey.shade300,
                            filled: true,
                          ),
                        ),
                      ),
                      // SizedBox(height: 20),
                      // Padding(
                      //   padding: EdgeInsets.only(right: 30, left: 30),
                      //   child: TextField(
                      //     controller: uNameController,
                      //     decoration: InputDecoration(
                      //       hintText: "Username",
                      //       hintStyle: TextStyle(
                      //         color: Colors.grey,
                      //         fontSize: 20,
                      //       ),
                      //       enabledBorder: InputBorder.none,
                      //       focusedBorder: InputBorder.none,
                      //       fillColor: Colors.grey.shade300,
                      //       filled: true,
                      //     ),
                      //   ),
                      // ),
                      SizedBox(height: 20),
                      Padding(
                        padding: EdgeInsets.only(right: 30, left: 30),
                        child: TextField(
                          controller: passwordController,
                          decoration: InputDecoration(
                            hintText: "Password",
                            hintStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 20,
                            ),
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            fillColor: Colors.grey.shade300,
                            filled: true,
                          ),
                        ),
                      ),
                      SizedBox(height: 35),
                      ElevatedButton(
                        onPressed: () {
                          AuthController.instance.register(emailController.text.trim(), passwordController.text.trim());
                        },
                        child: Text(
                          "Register",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          fixedSize: Size(240, 54),
                          primary: Colors.black,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}