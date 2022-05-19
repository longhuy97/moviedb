import 'package:flutter/material.dart';

class TabBarScreen extends StatelessWidget {
  const TabBarScreen({
    Key? key,
    required TabController tabController,
  }) : _tabController = tabController, super(key: key);

  final TabController _tabController;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40.0,
      margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Color.fromARGB(255, 73, 73, 73)),
      child: TabBar(
        controller: _tabController,
        indicator: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: Colors.red),
        labelColor: Colors.amberAccent,
        tabs:const  <Widget>[
          Tab(
            child: Text(
              'Top Lists',
              style: TextStyle(
                  color: Color.fromARGB(255, 255, 255, 255),
                  fontSize: 13.0,
                  fontWeight: FontWeight.w600),
            ),
          ),
          Tab(
            child: Text(
              'Genres',
              style: TextStyle(
                  color: Color.fromARGB(255, 255, 255, 255),
                  fontSize: 13.0,
                  fontWeight: FontWeight.w600),
            ),
          ),
          Tab(
            child: Text(
              'In Theater',
              style: TextStyle(
                  color: Color.fromARGB(255, 255, 255, 255),
                  fontSize: 13.0,
                  fontWeight: FontWeight.w600),
            ),
          ),
          Tab(
            child: Text(
              'Upcoming',
              style: TextStyle(
                  color: Color.fromARGB(255, 255, 255, 255),
                  fontSize: 13.0,
                  fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}
