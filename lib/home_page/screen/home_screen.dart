
import 'package:flutter/material.dart';
import 'package:moviedb/home_page/model/intheaters_model.dart';
import 'package:moviedb/home_page/model/upcoming_model.dart';
import 'package:moviedb/home_page/network/intheaters_network.dart';
import 'package:moviedb/home_page/network/upcoming_network.dart';
import 'package:moviedb/home_page/screen/intheaters/intheaters_screen.dart';
import 'package:moviedb/home_page/screen/upcoming/upcoming_screen.dart';
import 'package:moviedb/home_page/screen/widget/widget_tabbar.dart';

import 'widget/widget_bottom.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenPageState();
}

class _HomeScreenPageState extends State<HomeScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;
  late Future<InTheaters> futureMovie;
  late Future<UpComing> futureUpComing;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    futureMovie = fetchMovie();
    futureUpComing = fetchUpComing();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor:const Color.fromARGB(255, 34, 34, 34),
        body: Stack(children: [
          Column(
            children: [
              TabBarScreen(tabController: _tabController),
              Expanded(
                child: Container(
                    margin: const EdgeInsets.only(top: 5.0),
                    color: Colors.grey[900],
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        Container(
                          child: Center(
                            child: Text('Top Lists',
                                style: TextStyle(
                                    fontSize: 26, color: Colors.white)),
                          ),
                        ),
                        Container(
                          child: Center(
                            child: Text('Genres',
                                style: TextStyle(
                                    fontSize: 26, color: Colors.white)),
                          ),
                        ),
                        InTheaterScreen(futureMovie: futureMovie),
                        UpComingScreen(futureUpComing: futureUpComing),
                      ],
                    )),
              ),
            ],
          ),
          //Container bottom
          const Bottom(),
        ]),
      ),
    );
  }
}
