import 'package:flutter/material.dart';

class Cart {
  final int id;
  final String productId;
  final String productName;
  final int initialPrice;
  final int productPrice;
  final ValueNotifier<int> quantity;
  final String unitTag;
  final String image;

  Cart(
      { this.id,
       this.productId,
       this.productName,
       this.initialPrice,
       this.productPrice,
       this.quantity,
       this.unitTag,
       this.image});

  Cart.fromMap(Map<dynamic, dynamic> data)
      : id = data['id'],
        productId = data['productId'],
        productName = data['productName'],
        initialPrice = data['initialPrice'],
        productPrice = data['productPrice'],
        quantity = ValueNotifier(data['quantity']),
        unitTag = data['unitTag'],
        image = data['image'];

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'productId': productId,
      'productName': productName,
      'initialPrice': initialPrice,
      'productPrice': productPrice,
      'quantity': quantity?.value,
      'unitTag': unitTag,
      'image': image,
    };
  }

  Map<String, dynamic> quantityMap() {
    return {
      'productId': productId,
      'quantity': quantity.value,
    };
  }
}
