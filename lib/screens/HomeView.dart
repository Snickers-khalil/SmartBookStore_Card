import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:iconsax/iconsax.dart';
import 'package:logger/logger.dart';
import '../controllers/HomeController.dart';
import 'package:badges/badges.dart' as badges;
import '../database/db_helper.dart';
import '../model/cart_model.dart';
import '../model/item_model.dart';
import '../controllers/CartController.dart';
import 'Book_details.dart';
import 'CartView.dart';

class HomeView extends GetView<HomeController> {
  HomeView({Key key}) : super(key: key);

  // final List<dynamic> _services = [
  //   ['Transfer', Iconsax.export_1, Colors.blue],
  //   ['Top-up', Iconsax.import, Colors.pink],
  //   ['Bill', Iconsax.wallet_3, Colors.orange],
  //   ['More', Iconsax.more, Colors.green],
  // ];
  // final List<dynamic> _transactions = [
  //   [
  //     'Amazon',
  //     'https://img.icons8.com/color/2x/amazon.png',
  //     '6:25pm',
  //     '\$8.90'
  //   ],
  //   [
  //     'Cash from ATM',
  //     'https://img.icons8.com/external-kiranshastry-lineal-color-kiranshastry/2x/external-atm-banking-and-finance-kiranshastry-lineal-color-kiranshastry.png',
  //     '5:50pm',
  //     '\$200.00'
  //   ],
  //   [
  //     'Netflix',
  //     'https://img.icons8.com/color-glass/2x/netflix.png',
  //     '2:22pm',
  //     '\$13.99'
  //   ],
  //   [
  //     'Apple Store',
  //     'https://img.icons8.com/color/2x/mac-os--v2.gif',
  //     '6:25pm',
  //     '\$4.99'
  //   ],
  //   [
  //     'Cash from ATM',
  //     'https://img.icons8.com/external-kiranshastry-lineal-color-kiranshastry/2x/external-atm-banking-and-finance-kiranshastry-lineal-color-kiranshastry.png',
  //     '5:50pm',
  //     '\$200.00'
  //   ],
  //   [
  //     'Netflix',
  //     'https://img.icons8.com/color-glass/2x/netflix.png',
  //     '2:22pm',
  //     '\$13.99'
  //   ]
  // ];

  DBHelper dbHelper = DBHelper();

  List<Item> products = [
    Item(
        id:1,
        title: 'Don t Fear',
        author: 'khalil',
        description: 'description description description ',
        price: 20,
        image: 'assets/images/book-cover4.jpg'),
    Item(
        id:2,
        title: 'Stop Breathing',
        author: 'khalil',
        description: 'description description description ',
        price: 30,
        image: 'assets/images/book-cover1.jpg'),
    Item(
        id:3,
        title: 'Banana Life',
        author: 'khalil',
        description: 'description description description ',
        price: 10,
        image: 'assets/images/book-cover7.jpg'),
    Item(
        id:4,
        title: 'Live of pie',
        author: 'khalil',
        description: 'description description description ',
        price: 8,
        image: 'assets/images/book-cover1.jpg'),
    Item(
      id:7,
        title: 'Water Melon',
        author: 'Kg',
        description: 'description description description ',
        price: 25,
        image: 'assets/images/book-cover5.jpg'),
    Item(
        id:5,
        title: 'BookMoney',
        author: 'khalil',
        description: '',
        price: 40,
        image: 'assets/images/book-cover3.jpg'),
    Item(
        id:6,
        title: 'Titanic',
        author: 'khalil',
        description: 'description description description ',
        price: 15,
        image: 'assets/images/book-cover2.jpg'),
    Item(
        id:9,
        title: 'absolute true',
        author: 'khalil',
        description: 'description description description ',
        price: 8,
        image: 'assets/images/book-cover4.jpg'),
    Item(
        id:10,
        title: 'Strawberry',
        author: 'Kg',
        description: 'description description description ',
        price: 12,
        image: 'assets/images/book-cover7.jpg'),
    Item(
        id:8,
        title: 'Never Mind',
        author: 'Kg',
        description: 'description description description ',
        price: 55,
        image: 'assets/images/book-cover6.jpg'),
  ];

  List<bool> clicked = List.generate(10, (index) => false, growable: true);

  // final List<String> _listItem = [
  //   'assets/images/book-cover1.jpg',
  //   'assets/images/book-cover2.jpg',
  //   'assets/images/book-cover3.jpg',
  //   'assets/images/book-cover4.jpg',
  //   'assets/images/book-cover5.jpg',
  //   'assets/images/book-cover6.jpg',
  //   'assets/images/book-cover7.jpg',
  //   'assets/images/book-cover1.jpg',
  //   'assets/images/book-cover4.jpg',
  // ];

  // @override
  // void initState() {
  //   // _scrollController = ScrollController();
  //   _scrollController.addListener(_listenToScrollChange);
  //   // super.initState();
  // }

  // void _listenToScrollChange() {
  //   if (_scrollController.offset >= 100.0) {
  //     setState(() {
  //       _isScrolled = true;
  //     });
  //   } else {
  //     setState(() {
  //       _isScrolled = false;
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    CartController cartController = Get.find<CartController>();
    void saveData(int index) {
      dbHelper
          .insert(
        Cart(
          id: index,
          productId: index.toString(),
          productName: products[index].title,
          initialPrice: products[index].price,
          productPrice: products[index].price,
          quantity: ValueNotifier(1),
          unitTag: products[index].author,
          image: products[index].image,
        ),
      )
          .then((value) {
        cartController.addTotalPrice(products[index].price.toDouble());
        cartController.addCounter();
        print('Book Added to cart');
        Get.snackbar(
          "Success",
          "Book Added to cart",
          colorText: Colors.white,
          backgroundColor: Colors.lightBlue,
          icon: const Icon(Icons.shopping_cart_checkout),
        );
      }).onError((error, stackTrace) {
        print(error.toString());
        Logger().d(error.toString());
        Get.snackbar(
          "Error",
          error.toString(),
          colorText: Colors.white,
          backgroundColor: Colors.redAccent,
          icon: const Icon(Icons.error),
        );
      });
    }

    return SafeArea(
      child: AdvancedDrawer(
          backdropColor: Colors.grey.shade900,
          controller: controller.advancedDrawerController.value,
          animationCurve: Curves.easeInOut,
          animationDuration: const Duration(milliseconds: 300),
          animateChildDecoration: true,
          rtlOpening: false,
          disabledGestures: false,
          childDecoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade900,
                blurRadius: 20.0,
                spreadRadius: 5.0,
                offset: const Offset(-20.0, 0.0),
              ),
            ],
            borderRadius: BorderRadius.circular(30),
          ),
          drawer: SafeArea(
            child: Container(
              padding: const EdgeInsets.only(top: 20),
              child: ListTileTheme(
                textColor: Colors.white,
                iconColor: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        width: 80.0,
                        height: 80.0,
                        margin: const EdgeInsets.only(
                          left: 20,
                          top: 24.0,
                        ),
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade800,
                          shape: BoxShape.circle,
                        ),
                        child:
                            Image.asset('assets/images/avatar/avatar-1.png')),
                    const SizedBox(
                      height: 10,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 30.0),
                      child: Text(
                        "Barhoumi Khalil",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w600),
                      ),
                    ),
                    const Spacer(),
                    Divider(
                      color: Colors.grey.shade800,
                    ),
                    ListTile(
                      onTap: () {},
                      leading: const Icon(Iconsax.home),
                      title: const Text('Dashboard'),
                    ),
                    ListTile(
                      onTap: () {},
                      leading: const Icon(Iconsax.chart_2),
                      title: const Text('Analytics'),
                    ),
                    ListTile(
                      onTap: () {},
                      leading: const Icon(Iconsax.profile_2user),
                      title: const Text('Contacts'),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    Divider(color: Colors.grey.shade800),
                    ListTile(
                      onTap: () {},
                      leading: const Icon(Iconsax.setting_2),
                      title: const Text('Settings'),
                    ),
                    ListTile(
                      onTap: () {},
                      leading: const Icon(Iconsax.support),
                      title: const Text('Support'),
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text(
                        'Version 1.0.0',
                        style: TextStyle(color: Colors.grey.shade500),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            // backgroundColor: Colors.grey.shade100,
            body: CustomScrollView(
                // controller: controller.scrollController,
                slivers: [
                  SliverAppBar(
                    expandedHeight: 80.0,
                    elevation: 0,
                    pinned: true,
                    stretch: true,
                    toolbarHeight: 80,
                    backgroundColor: Colors.blueGrey,
                    leading: IconButton(
                      color: Colors.black,
                      onPressed: _handleMenuButtonPressed,
                      icon: ValueListenableBuilder<AdvancedDrawerValue>(
                        valueListenable:
                            controller.advancedDrawerController.value,
                        builder: (_, value, __) {
                          return AnimatedSwitcher(
                            duration: const Duration(milliseconds: 250),
                            child: Icon(
                              value.visible
                                  ? Iconsax.close_square
                                  : Iconsax.menu,
                              key: ValueKey<bool>(value.visible),
                            ),
                          );
                        },
                      ),
                    ),
                    actions: [
                      // badges.Badge(
                      //   badgeContent: Consumer<CartController>(
                      //     builder: (context, value, child) {
                      //       return Text(
                      //         value.getCounter().toString(),
                      //         style: const TextStyle(
                      //             color: Colors.white, fontWeight: FontWeight.bold),
                      //       );
                      //     },
                      //   ),
                      //   position: badges.BadgePosition.topEnd(top: 4,end: 5),
                      //   child:
                      //   IconButton(
                      //     icon: const Icon(Iconsax.shopping_cart,
                      //         color: Colors.black87),
                      //     onPressed: () {},
                      //   ),
                      //   ),
                      const SizedBox(width: 10,),
                      GetBuilder<CartController>(
                        builder: (controller) => badges.Badge(
                          badgeContent: Text(controller.counter.toString(),
                            style: const TextStyle(
                              color: Colors.black87,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          position: badges.BadgePosition.topEnd(top: 4, end: 5),
                          child: IconButton(
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => CartScreen()));
                            },
                            icon: const Icon(Icons.shopping_cart,size: 40,color: Colors.black87),
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Iconsax.more, color: Colors.black87),
                        onPressed: () {},
                      ),
                    ],
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(40),
                        bottomRight: Radius.circular(40),
                      ),
                    ),
                    centerTitle: true,
                  ),
                  SliverFillRemaining(
                    child: Container(
                      padding:
                          const EdgeInsets.only(left: 6, right: 6, top: 5),
                      child: Column(
                        children: [
                          Expanded(
                            child: GridView.builder(
                                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2),
                                // padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
                                shrinkWrap: true,
                                itemCount: products.length,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () {
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (context) =>
                                              BookDetails(image: products[index].image,
                                                          index: index,
                                                          title:products[index].title,
                                                          description:products[index].description,
                                                          price:products[index].price)
                                          ));
                                    },
                                    child: Card(
                                                color: Colors.transparent,
                                                elevation: 0,
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(20),
                                                      image: DecorationImage(
                                                          image: AssetImage(products[index].image.toString()),
                                                          fit: BoxFit.cover)),
                                                  child: Transform.translate(
                                                    offset: const Offset(60, -60),
                                                    child: Container(
                                                      margin: const EdgeInsets.symmetric(
                                                          horizontal: 74, vertical: 74),
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius.circular(10),
                                                          color: Colors.white70),
                                                      child: IconButton(
                                                        onPressed: () {
                                                          Logger().d(index);
                                                          saveData(index);
                                                        },
                                                        icon: const Icon(Icons.shopping_cart_checkout,
                                                            size: 30,
                                                            color: Colors.black87),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              )
                                  );
                                }),
                          //     child: GridView.builder(
                          //   crossAxisCount: 2,
                          //   crossAxisSpacing: 10,
                          //   mainAxisSpacing: 10,
                          //   children: _listItem
                          //       .map((item) =>
                            //       Card(
                          //             color: Colors.transparent,
                          //             elevation: 0,
                          //             child: Container(
                          //               decoration: BoxDecoration(
                          //                   borderRadius:
                          //                       BorderRadius.circular(20),
                          //                   image: DecorationImage(
                          //                       image: AssetImage(item),
                          //                       fit: BoxFit.cover)),
                          //               child: Transform.translate(
                          //                 offset: const Offset(50, -50),
                          //                 child: Container(
                          //                   margin: const EdgeInsets.symmetric(
                          //                       horizontal: 65, vertical: 63),
                          //                   decoration: BoxDecoration(
                          //                       borderRadius:
                          //                           BorderRadius.circular(10),
                          //                       color: Colors.white),
                          //                   child: IconButton(
                          //                     onPressed: () {
                          //                       saveData(index);
                          //                     },
                          //                     icon: const Icon(Iconsax.shopping_cart4,
                          //                         size: 30,
                          //                         color: Colors.black87),
                          //                   ),
                          //                 ),
                          //               ),
                          //             ),
                          //           ))
                          //       .toList(),
                          // )
                              // ListView.builder(
                              //   padding: const EdgeInsets.only(top: 20),
                              //   physics: const NeverScrollableScrollPhysics(),
                              //   itemCount: _transactions.length,
                              //   itemBuilder: (context, index) {
                              //     return FadeInDown(
                              //       duration: const Duration(milliseconds: 500),
                              //       child: Container(
                              //         margin: const EdgeInsets.only(bottom: 10),
                              //         padding: const EdgeInsets.symmetric(
                              //             horizontal: 20, vertical: 10),
                              //         decoration: BoxDecoration(
                              //           color: Colors.white,
                              //           borderRadius: BorderRadius.circular(15),
                              //           boxShadow: [
                              //             BoxShadow(
                              //               color: Colors.grey.shade200,
                              //               blurRadius: 5,
                              //               spreadRadius: 1,
                              //               offset: const Offset(0, 6),
                              //             ),
                              //           ],
                              //         ),
                              //         child: Row(
                              //           mainAxisAlignment:
                              //           MainAxisAlignment.spaceBetween,
                              //           children: [
                              //             Row(
                              //               children: [
                              //                 // Image.network(_transactions[index][1], width: 5, height: 5,),
                              //                 const SizedBox(
                              //                   width: 15,
                              //                 ),
                              //                 Column(
                              //                   crossAxisAlignment:
                              //                   CrossAxisAlignment.start,
                              //                   children: [
                              //                     Text(
                              //                       _transactions[index][0],
                              //                       style: TextStyle(
                              //                           color: Colors.grey.shade900,
                              //                           fontWeight: FontWeight.w500,
                              //                           fontSize: 14),
                              //                     ),
                              //                     const SizedBox(
                              //                       height: 5,
                              //                     ),
                              //                     Text(
                              //                       _transactions[index][2],
                              //                       style: TextStyle(
                              //                           color: Colors.grey.shade500,
                              //                           fontSize: 12),
                              //                     ),
                              //                   ],
                              //                 ),
                              //               ],
                              //             ),
                              //             Text(
                              //               _transactions[index][3],
                              //               style: TextStyle(
                              //                   color: Colors.grey.shade800,
                              //                   fontSize: 16,
                              //                   fontWeight: FontWeight.w700),
                              //             ),
                              //           ],
                              //         ),
                              //       ),
                              //     );
                              //   },
                              // ),
                              )
                        ],
                      ),
                    ),
                  )
                ]),
          )),
    );
  }

  void _handleMenuButtonPressed() {
    controller.advancedDrawerController.value.showDrawer();
  }
}
