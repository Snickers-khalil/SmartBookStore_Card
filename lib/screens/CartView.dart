
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:badges/badges.dart' as badges;
import 'package:get_storage/get_storage.dart';
import 'package:iconsax/iconsax.dart';
import 'package:logger/logger.dart';
import '../controllers/CartController.dart';
import '../database/db_helper.dart';

class CartScreen extends GetView<CartController>{
// DBHelper dbHelper = DBHelper();
List<bool> tapped = [];
DBHelper dbHelper = Get.find<DBHelper>();

  @override
  Widget build(BuildContext context) {
    final CartController cartController = Get.find<CartController>();
    Get.find<CartController>().getData();
    // final cart = Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        centerTitle: true,
        title: const Text('My Shopping Cart'),
        actions: [
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
                onPressed: () {},
                icon: const Icon(Icons.shopping_cart),
              ),
            ),
          ),
          const SizedBox(
            width: 20.0,
          ),
          IconButton(
            icon: const Icon(Iconsax.box_remove, color: Colors.black87),
            onPressed: () {
              // controller.removeItem()
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: GetBuilder<CartController>(
              builder: (c) {
                if (controller.cart.isEmpty) {
                  return const Center(
                    child: Text(
                      'Your Cart is Empty',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
                    ),
                  );
                } else {
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: controller.cart.length,
                    itemBuilder: (context, index) {
                      return Card(
                        color: Colors.blueGrey.shade200,
                        elevation: 5.0,
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Image(
                                height: 80,
                                width: 80,
                                image: AssetImage(cartController.cart[index].image),
                              ),
                              SizedBox(
                                width: 130,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(
                                      height: 5.0,
                                    ),
                                    RichText(
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      text: TextSpan(
                                        text: 'Name: ',
                                        style: TextStyle(
                                          color: Colors.blueGrey.shade800,
                                          fontSize: 16.0,
                                        ),
                                        children: [
                                          TextSpan(
                                            text:
                                            '${cartController.cart[index].productName}\n',
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    RichText(
                                      maxLines: 1,
                                      text: TextSpan(
                                        text: 'Unit: ',
                                        style: TextStyle(
                                          color: Colors.blueGrey.shade800,
                                          fontSize: 16.0,
                                        ),
                                        children: [
                                          TextSpan(
                                            text:
                                            '${controller.cart[index].unitTag}\n',
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    RichText(
                                      maxLines: 1,
                                      text: TextSpan(
                                        text: 'Price: ' r"$",
                                        style: TextStyle(
                                          color: Colors.blueGrey.shade800,
                                          fontSize: 16.0,
                                        ),
                                        children: [
                                          TextSpan(
                                            text:
                                            '${controller.cart[index].productPrice}\n',
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              GetBuilder<CartController>(
                                builder: (c) {
                                  return PlusMinusButtons(
                                    addQuantity: () {
                                      Logger().d(index);
                                      controller.addQuantity(index);
                                      c.update();
                                    },
                                    deleteQuantity: () {
                                      Logger().d(index);
                                      controller.deleteQuantity(index);
                                      c.update();
                                    },
                                    text: controller.cart[index].quantity.value.toString(),
                                  );
                                },
                              ),
                              IconButton(
                                onPressed: () {
                                  Logger().d(cartController.cart[index]);
                                  controller.removeItem(index);
                                },
                                icon:  Icon(
                                  Icons.delete,
                                  color: Colors.red.shade800,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
          GetBuilder<CartController>(
            builder: (controller) {
              double totalPrice = 0;
              for (var element in controller.cart) {
                totalPrice += (element.productPrice * element.quantity.value);
              }
              return Column(
                children: [
                  ReusableWidget(
                    title: 'Sub-Total',
                    value: r'$' + totalPrice.toStringAsFixed(2),
                  ),
                ],
              );
            },
          ),

        ],
      ),
      bottomNavigationBar: InkWell(
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Payment Successful'),
              duration: Duration(seconds: 2),
            ),
          );
        },
        child: Container(
          color: Colors.yellow.shade600,
          alignment: Alignment.center,
          height: 50.0,
          child: const Text(
            'Proceed to Pay',
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

class PlusMinusButtons extends StatelessWidget {
  final VoidCallback deleteQuantity;
  final VoidCallback addQuantity;
  final String text;
  const PlusMinusButtons(
      {Key key,
        this.addQuantity,
        this.deleteQuantity,
        this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(onPressed: deleteQuantity, icon: const Icon(Icons.remove)),
        Text(text),
        IconButton(onPressed: addQuantity, icon: const Icon(Icons.add)),
      ],
    );
  }
}

class ReusableWidget extends StatelessWidget {
  final String title, value;
  const ReusableWidget({Key key,  this.title,  this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.subtitle1,
          ),
          Text(
            value.toString(),
            style: Theme.of(context).textTheme.subtitle2,
          ),
        ],
      ),
    );
  }
}
