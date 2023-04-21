import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'lazy_loading_controller.dart';

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
      body: Obx(() {
        return Container(
          child: ListView.builder(
            itemCount: controller.users.length +
                1, // Add one more item for progress indicator
            padding: EdgeInsets.symmetric(vertical: 8.0),
            itemBuilder: (BuildContext context, int index) {
              if (index == controller.users.length) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Obx(() {
                    return Container(
                      width: Get.width,
                      alignment: Alignment.center,
                      child: Opacity(
                        opacity: controller.isLoading.value ? 1.0 : 00,
                        child: CircularProgressIndicator(
                          backgroundColor: Colors.red,
                          strokeWidth: 8,
                        ),
                      ),
                    );
                  }),
                );
              } else {
                return ListTile(
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
            controller: controller.sc.value,
          ),
        );
      }),
      resizeToAvoidBottomInset: false,
    );
  }
}
