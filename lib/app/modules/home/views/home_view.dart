import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('HomeView'),
          centerTitle: true,
        ),
        body: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  margin: EdgeInsets.only(top: 20),
                  width: Get.width * 0.9,
                  child: GridView.count(
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 20,
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    children: <Widget>[
                      Card(
                        child: InkWell(
                          onTap: () {
                            Get.toNamed('/calendar-admin');
                          },
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Icon(
                                  Icons.calendar_today,
                                  size: 70,
                                ),
                                Text(
                                  'Calendar',
                                  style: TextStyle(fontSize: 20),
                                )
                              ]),
                        ),
                      ),
                      Card(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            const ListTile(
                              leading: Icon(Icons.add),
                              title: Text('Nueva Reunion'),
                              subtitle: Text('Crear una nueva reunion'),
                            ),
                          ],
                        ),
                      ),
                      Card(
                        child: InkWell(
                          onTap: () {
                            //Get.toNamed('/meeting');
                          },
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              const ListTile(
                                leading: Icon(Icons.add),
                                title: Text('Nueva Reunion'),
                                subtitle: Text('Crear una nueva reunion'),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Card(
                        child: InkWell(
                          onTap: () {
                            //Get.toNamed('/meeting');
                          },
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              const ListTile(
                                leading: Icon(Icons.add),
                                title: Text('Nueva Reunion'),
                                subtitle: Text('Crear una nueva reunion'),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Text("Asistencias confirmadas"),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: _buildList()),
              ),
            ],
          ),
        ));
  }

  List<Widget> _buildList() {
    List<Widget> list = [];
    for (var i = 0; i < 10; i++) {
      list.add(Card(
        child: InkWell(
          onTap: () {
            Get.toNamed('/people-meeting');
          },
          child: Container(
            width: 100,
            height: 100,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  "titulo",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text(
                  9.toString(),
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
        ),
      ));
    }
    return list;
  }
}
