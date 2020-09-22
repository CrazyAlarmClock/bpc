import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'donut_screen.dart';
import 'home_page.dart';
import 'login_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(),
      home: LoginPage(),
    );
  }
}
class WorkTabBarScreen extends StatelessWidget {
  final List<Tab> myTabs = <Tab>[
    Tab(text: '1'),
    Tab(text: '2'),
    Tab(text: '3'),

  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.pink,
            elevation: 0,
            bottom: PreferredSize(
                child: Container(
                    height: 40.0,
                    child: TabBar(
                        labelColor: Colors.pink,
                        unselectedLabelColor: Colors.white,
                        indicatorSize: TabBarIndicatorSize.label,
                        indicator: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10)),
                            color: Colors.white),
                        tabs: [
                          Tab(
                            child: Align(
                              alignment: Alignment.center,
                              child: Text("Транзакции"),
                            ),
                          ),
                          Tab(
                            child: Align(
                              alignment: Alignment.center,
                              child: Text("Диаграмма"),
                            ),
                          ),

                        ]
                    ) ) ),
          ),
          body: TabBarView(children: [
            HomePage(),
            PieOutsideLabelChart()
                 ]),
        )
    );
  }
}