import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazy_loading_test/lazy_loading_controller.dart';

class LazyLoading extends GetView<LazyLoadingController> {
  @override
  Widget build(BuildContext context) {
    Get.isRegistered<LazyLoadingController>()
        ? Get.find<LazyLoadingController>()
        : Get.put(LazyLoadingController());

    return Scaffold(
      appBar: AppBar(
        title: const Text("Lazy Load Large List"),
      ),
      body: Container(
        child: _buildList(),
      ),
      resizeToAvoidBottomInset: false,
    );
  }

  Widget _buildList() {
    return ListView.builder(
      itemCount: controller.users.length +
          1, // Add one more item for progress indicator
      padding: EdgeInsets.symmetric(vertical: 8.0),
      itemBuilder: (BuildContext context, int index) {
        if (index == controller.users.length) {
          return _buildProgressIndicator();
        } else {
          return new ListTile(
            leading: CircleAvatar(
              radius: 30.0,
              backgroundImage: NetworkImage(
                controller.users[index]['picture']['large'],
              ),
            ),
            title: Text((controller.users[index]['name']['first'])),
            subtitle: Text((controller.users[index]['email'])),
          );
        }
      },
      controller: controller.sc,
    );
  }

  Widget _buildProgressIndicator() {
    return new Padding(
      padding: const EdgeInsets.all(8.0),
      child: new Center(
        child: new Opacity(
          opacity: controller.isLoading.value ? 1.0 : 00,
          child: new CircularProgressIndicator(),
        ),
      ),
    );
  }
}