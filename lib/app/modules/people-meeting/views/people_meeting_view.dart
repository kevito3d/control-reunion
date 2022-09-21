import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/people_meeting_controller.dart';

class PeopleMeetingView extends GetView<PeopleMeetingController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PeopleMeetingView'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: 20,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text('Item $index'),
          subtitle: Text('Subitem '),
          
          );
        },
      ),
    );
  }
}
