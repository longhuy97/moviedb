// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:moviedb/detail_page/screen/detailmovie_screen.dart';
import 'package:moviedb/home_page/model/intheaters_model.dart';
import 'package:moviedb/home_page/model/upcoming_model.dart';

class UpComingScreen extends StatelessWidget {
  const UpComingScreen({Key? key, required this.futureUpComing})
      : super(key: key);
  final Future<UpComing> futureUpComing;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder<UpComing>(
        future: futureUpComing,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 2 / 3,
                    mainAxisSpacing: 7.0,
                    crossAxisSpacing: 7.0),
                itemCount: snapshot.data?.results?.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DetailMovieScreen(
                                    id: snapshot.data?.results?[index].id, results: null,
                                  )));
                    },
                    child: Image.network(
                        'https://image.tmdb.org/t/p/w300/${snapshot.data?.results?[index].posterPath}'),
                  );
                });
          } else if (snapshot.hasError) {
            return (Text('${snapshot.error}'));
          }
          return const CircularProgressIndicator();
        },
      ),
    );
  }
}
