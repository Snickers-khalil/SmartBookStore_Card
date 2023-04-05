
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../database/db_helper.dart';
import '../model/cart_model.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  DBHelper dbHelper = Get.find<DBHelper>();
  RxInt counter = 0.obs;
  RxInt quantity = 1.obs;
  RxDouble totalPrice = 0.0.obs;
  RxList<Cart> cart = <Cart>[].obs;

  @override
  void onInit() {
    super.onInit();
    getData();
  }


  @override
  void onReady() {
    super.onReady();
    getData();
    update();
  }

  Future<void> getData() async {
    Logger().d(await dbHelper.getCartList());
    cart.value = await dbHelper.getCartList();
    Logger().d(cart.value);
    update();
    // updatePrefsItems();
  }

  void updatePrefsItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('cart_items', counter.value);
    prefs.setInt('item_quantity', quantity.value);
    prefs.setDouble('total_price', totalPrice.value);
    update();
  }

  void getPrefsItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    counter.value = prefs.getInt('cart_items') ?? 0;
    quantity.value = prefs.getInt('item_quantity') ?? 1;
    totalPrice.value = prefs.getDouble('total_price') ?? 0;
    update();
  }

  void addCounter() {
    counter.value++;
    update();
    updatePrefsItems();
  }

  void removeCounter() {
    counter.value--;
    update();
    updatePrefsItems();
  }

  int getCounter() {
    update();
    getPrefsItems();
    return counter.value;
  }

  void addQuantity(int id) {
    final index = cart.indexWhere((element) => element.id == id);
    cart[index].quantity.value = cart[index].quantity.value + 1;
    updatePrefsItems();
    update();
  }

  void deleteQuantity(int id) {
    final index = cart.indexWhere((element) => element.id == id);
    final currentQuantity = cart[index].quantity.value;
    if (currentQuantity <= 1) {
      currentQuantity == 1;
    } else {
      cart[index].quantity.value = currentQuantity - 1;
    }
    update();
    updatePrefsItems();
  }

  void removeItem(int id) {
    update();
    var index = cart.indexWhere((element) => element.id == id);
    Logger().d(index);
    cart.removeAt(index);
    update();
    updatePrefsItems();
  }

  int getQuantity(int qua) {
    getPrefsItems();
    update();
    return quantity.value;
  }

  void addTotalPrice(double productPrice) {
    totalPrice.value = totalPrice.value + productPrice;
    update();
    updatePrefsItems();
  }

  void removeTotalPrice(double productPrice) {
    totalPrice.value = totalPrice.value - productPrice;
    update();
  }

  double getTotalPrice() {
    getPrefsItems();
    update();
    return totalPrice.value;
  }
}
