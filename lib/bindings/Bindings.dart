
import 'package:get/get.dart';

import '../controllers/HomeController.dart';
import '../database/db_helper.dart';
import '../controllers/CartController.dart';


class InitialBinding extends Bindings {
  @override
  void dependencies() {
    /// TODO: implement dependencies
    // Get.lazyPut<LocalStorage>(() => LocalStorage());
    // Get.put<LoginController>(LoginController(),permanent: true);
    // Get.put<CartController>( CartController());
    // Get.put<ConnectionManagerController>(ConnectionManagerController());   // Get.lazyPut<SignUpController>(() => SignUpController());
    Get.lazyPut<DBHelper>(()=>DBHelper());
    Get.lazyPut<CartController>(() => CartController());

    Get.lazyPut<HomeController>(() => HomeController());
    // Get.lazyPut<QrCodeController>(() => QrCodeController());
    // Get.lazyPut<HomeView>(() => HomeView());
    // Get.lazyPut<SignInView>(() => SignInView());
    // Get.lazyPut<BottomNav>(() => BottomNav());
  }
}