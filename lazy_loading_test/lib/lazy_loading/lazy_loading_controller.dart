import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LazyLoadingController extends GetxController {
  static int page = 0;
  Rx<ScrollController> sc = ScrollController().obs;
  RxBool isLoading = false.obs;
  RxList users = RxList.empty();
  final dio = Dio();

  @override
  void onInit() {
    this.getMoreData(page);
    sc.value.addListener(() {
      if (sc.value.position.pixels == sc.value.position.maxScrollExtent) {
        getMoreData(page);
      }
    });
    super.onInit();
  }

  @override
  void dispose() {
    // sc.dispose();
    super.dispose();
  }

  void getMoreData(int index) async {
    if (!isLoading.value) {
      // setState(() {
      isLoading.value = true;

      // });

      var url = "https://randomuser.me/api/?page=" +
          index.toString() +
          "&results=20&seed=abc";
      print(url);
      final response = await dio.get(url);
      RxList tList = RxList.empty();
      for (int i = 0; i < response.data['results'].length; i++) {
        tList.add(response.data['results'][i]);
      }

      // setState(() {
      isLoading.value = false;
      users.addAll(tList);
      page++;
      // });
    }
  }
}
