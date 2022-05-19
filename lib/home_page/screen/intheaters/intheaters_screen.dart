import 'package:flutter/material.dart';
import 'package:moviedb/detail_page/screen/detailmovie_screen.dart';

import 'package:moviedb/home_page/model/intheaters_model.dart';

class InTheaterScreen extends StatelessWidget {
  const InTheaterScreen({
    Key? key,
    required this.futureMovie,
  }) : super(key: key);

  final Future<InTheaters> futureMovie;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder<InTheaters>(
        future: futureMovie,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 2 / 3,
                    mainAxisSpacing: 7.0,
                    crossAxisSpacing: 7.0),
                itemCount: snapshot.data?.results?.length,
                itemBuilder: (context, index) {
                  Results results = snapshot.data?.results?[index] as Results;
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DetailMovieScreen(
                                    id: snapshot.data?.results?[index].id,
                                    results: results,
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
