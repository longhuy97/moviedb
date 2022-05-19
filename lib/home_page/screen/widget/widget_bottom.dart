import 'package:flutter/material.dart';

class Bottom extends StatelessWidget {
  const Bottom({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        height: 90.0,
        color: Color.fromARGB(255, 44, 44, 43).withOpacity(0.9),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Icon(
                  Icons.star_border,
                  color: Colors.white,
                ),
                SizedBox(height: 3.0),
                Text(
                  'Discover',
                  style: TextStyle(color: Colors.white),
                )
              ],
            ),
            Column(
              children: [
                Icon(
                  Icons.list_alt_outlined,
                  color: Colors.white,
                ),
                SizedBox(height: 3.0),
                Text(
                  'My List',
                  style: TextStyle(color: Colors.white),
                )
              ],
            ),
            Column(
              children: [
                Icon(
                  Icons.search,
                  color: Colors.white,
                ),
                SizedBox(height: 3.0),
                Text(
                  'Search',
                  style: TextStyle(color: Colors.white),
                )
              ],
            ),
            Column(
              children: [
                Icon(
                  Icons.newspaper,
                  color: Colors.white,
                ),
                SizedBox(height: 3.0),
                Text(
                  'News',
                  style: TextStyle(color: Colors.white),
                )
              ],
            ),
            Column(
              children: [
                Icon(
                  Icons.settings,
                  color: Colors.white,
                ),
                SizedBox(height: 3.0),
                Text(
                  'Settings',
                  style: TextStyle(color: Colors.white),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
