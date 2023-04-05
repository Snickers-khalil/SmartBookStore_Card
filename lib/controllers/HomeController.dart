
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {

  final advancedDrawerController = AdvancedDrawerController().obs;
  ScrollController scrollController = ScrollController();
  RxBool isScrolled = false.obs;

  void _listenToScrollChange() {
    if (scrollController.offset >= 100.0) {
        isScrolled.value = true;
    } else {
        isScrolled.value = false;
    }
  }


  @override
  void refresh() {
    super.refresh();
  }

  @override
  void onClose() {
    super.onClose();
  }

  @override
  bool get initialized {
    super.initialized;
  }

  @override
  void onInit() {
    scrollController.addListener(_listenToScrollChange);
    super.onInit();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void onReady() {
    super.onReady();
  }
}