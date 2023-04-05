import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import '../Utils/Animation/FadeAnimation.dart';
import '../controllers/CartController.dart';
import '../database/db_helper.dart';
import '../model/cart_model.dart';
import '../model/item_model.dart';

class BookDetails extends StatefulWidget {
  final String image;
  final int index;
  final String title;
  final String description;
  final int price;


  const BookDetails({Key key,
    @required this.image,
    @required this.index,
    @required this.title,
    @required this.description,
    @required this.price}) : super(key: key);

  @override
  _ShoesState createState() => _ShoesState();
}

class _ShoesState extends State<BookDetails> {
  DBHelper dbHelper = Get.find<DBHelper>();

  List<Item> products = [
    Item(
        id:1,
        title: 'Don''t Fear',
        author: 'Kg',
        description: '',
        price: 20,
        image: 'assets/images/book-cover4.jpg'),
    Item(
        id:2,
        title: 'Stop Breathing',
        author: 'Kg',
        description: '',
        price: 30,
        image: 'assets/images/book-cover1.jpg'),
    Item(
        id:3,
        title: 'Banana Life',
        author: 'Kg',
        description: '',
        price: 10,
        image: 'assets/images/book-cover7.jpg'),
    Item(
        id:4,
        title: 'Live of pie',
        author: 'Kg',
        description: '',
        price: 8,
        image: 'assets/images/book-cover1.jpg'),
    Item(
        id:7,
        title: 'Water Melon',
        author: 'Kg',
        description: '',
        price: 25,
        image: 'assets/images/book-cover5.jpg'),
    Item(
        id:5,
        title: 'BookMoney',
        author: 'Kg',
        description: '',
        price: 40,
        image: 'assets/images/book-cover3.jpg'),
    Item(
        id:6,
        title: 'Titanic',
        author: 'Kg',
        description: '',
        price: 15,
        image: 'assets/images/book-cover2.jpg'),
    Item(
        id:9,
        title: 'absolute true',
        author: 'Kg',
        description: '',
        price: 8,
        image: 'assets/images/book-cover4.jpg'),
    Item(
        id:10,
        title: 'Strawberry',
        author: 'Kg',
        description: '',
        price: 12,
        image: 'assets/images/book-cover7.jpg'),
    Item(
        id:8,
        title: 'Never Mind',
        author: 'Kg',
        description: '',
        price: 55,
        image: 'assets/images/book-cover6.jpg'),
  ];


  @override
  Widget build(BuildContext context) {
    final CartController cartController = Get.find<CartController>();
    // final cart = Provider.of<CartProvider>(context);
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
      }).onError((error, stackTrace) {
        Logger().d(error.toString());
        print(error.toString());
      });
    }

    return Scaffold(
      body: SingleChildScrollView(
          child: Hero(
        tag: 'red',
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(widget.image), fit: BoxFit.cover),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey[400],
                    blurRadius: 10,
                    offset: const Offset(0, 10))
              ]),
          child: Stack(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                      ),
                    ),
                    Container(
                      width: 35,
                      height: 35,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle, color: Colors.white),
                      child: const Center(
                        child: Icon(
                          Icons.favorite_border,
                          size: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                width: MediaQuery.of(context).size.width,
                height: 500,
                child: FadeAnimation(
                    1,
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.bottomRight,
                              colors: [
                            Colors.black.withOpacity(.9),
                            Colors.black.withOpacity(.0),
                          ])),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          FadeAnimation(
                              1.3,
                              Container(
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 9, vertical: 5),
                                decoration: BoxDecoration(
                                    borderRadius:
                                    BorderRadius.circular(10),
                                    color: Colors.black38),
                                child: Text(widget.title,
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 50,
                                      fontWeight: FontWeight.bold),
                                )
                              ),

                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          FadeAnimation(
                              1.4,
                            Container(
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 9, vertical: 5),
                                decoration: BoxDecoration(
                                    borderRadius:
                                    BorderRadius.circular(10),
                                    color: Colors.black38),
                                child: Text(widget.description,
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500),
                                )
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          FadeAnimation(
                              1.4,
                            Container(
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 9, vertical: 5),
                                decoration: BoxDecoration(
                                    borderRadius:
                                    BorderRadius.circular(10),
                                    color: Colors.black38),
                                child: Text(widget.description,
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500),
                                )
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: <Widget>[
                              FadeAnimation(
                                  1.45,
                                  Container(
                                    width: 50,
                                    height: 50,
                                    margin: const EdgeInsets.only(right: 20),
                                    decoration: BoxDecoration(
                                        color: Colors.black38,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child:  Center(
                                        child: Text('${widget.price} Dt' ,
                                      style: const TextStyle(
                                          fontSize: 20,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    )),
                                  )),

                            ],
                          ),
                          const SizedBox(
                            height: 60,
                          ),
                          FadeAnimation(
                              1.5,
                              GestureDetector(
                                onTap: () {
                                  saveData(widget.index);
                                },
                                child: Container(
                                  height: 50,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(15)),
                                  child: const Center(
                                      child: Text(
                                    'Add to Cart',
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                  )),
                                ),
                              )
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                        ],
                      ),
                    )),
              )
            ],
          ),
        ),
      )),
    );
  }
}
