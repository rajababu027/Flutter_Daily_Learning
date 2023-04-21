import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LazyLoadingController extends GetxController {
  static int page = 0;
  ScrollController sc = new ScrollController();
  RxBool isLoading = false.obs;
  RxList users = RxList.empty();
  final dio = new Dio();

  @override
  void onInit() {
    this._getMoreData(page);

    sc.addListener(() {
      if (sc.position.pixels == sc.position.maxScrollExtent) {
        _getMoreData(page);
      }
    });
    super.onInit();
  }

  @override
  void dispose() {
    sc.dispose();
    super.dispose();
  }

  void _getMoreData(int index) async {
    if (!isLoading.value) {
      // setState(() {
      isLoading.value = true;
      // });
      var url = "https://randomuser.me/api/?page=" +
          index.toString() +
          "&results=20&seed=abc";
      print(url);
      final response = await dio.get(url);
      List tList = [];
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
