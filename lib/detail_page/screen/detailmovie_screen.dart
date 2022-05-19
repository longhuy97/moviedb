import 'package:flutter/material.dart';
import 'package:moviedb/detail_page/model/detail_model.dart';
import 'package:moviedb/detail_page/network/detail_network.dart';
import 'package:moviedb/detail_person/screen/person_screen.dart';
import 'package:moviedb/home_page/model/intheaters_model.dart';

// ignore: must_be_immutable
class DetailMovieScreen extends StatefulWidget {
  DetailMovieScreen({Key? key, required this.id, required this.results})
      : super(key: key);

  final int? id;
  Results? results;

  @override
  // ignore: no_logic_in_create_state
  State<DetailMovieScreen> createState() => _DetailMovieScreenState(id: id);
}

class _DetailMovieScreenState extends State<DetailMovieScreen> {
  late Future<DetailModel> futurePoster;
  late int? id;
  _DetailMovieScreenState({this.id});
  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    futurePoster = fetchPoster(id!);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: FutureBuilder<DetailModel>(
            future: futurePoster,
            builder: ((context, snapshot) {
              if (snapshot.hasData) {
                int? itemcount = snapshot.data?.productionCompanies?.length;
                int? itemcountgenres = snapshot.data?.genres?.length;
                int? itemcountcrew = snapshot.data?.credits?.crew?.length;
                int? itemcountcast = snapshot.data?.credits?.cast?.length;
                // int? itemcountcrew = snapshot.data?.credits?.crew?.length;
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      //Container poster
                      PosterDetailMovie(snapshot: snapshot),
                      //Container My Rating
                      MyRating(),
                      //Container List highlight
                      ListIamgeFilm(itemcount: itemcount, snapshot: snapshot),
                      //Container overview
                      OverView(snapshot: snapshot),
                      //Container Custom List
                      CustomList(),
                      //Container Release Date
                      ReleaseDate(snapshot: snapshot),
                      //Container Runtime
                      RunTime(snapshot: snapshot),
                      //Container Rating
                      Rating(),
                      //Container Genre
                      Genre(
                        itemcountgenres: itemcountgenres!,
                        snapshot: snapshot,
                      ),
                      //Container Direction
                      Column(
                        children: [
                          Container(
                            height: 60.0,
                            margin: EdgeInsets.symmetric(horizontal: 18.0),
                            padding: EdgeInsets.only(bottom: 5.0),
                            alignment: Alignment.bottomLeft,
                            child: const Text(
                              'Diretor',
                              style: TextStyle(
                                color: Color.fromARGB(255, 209, 208, 208),
                                fontSize: 18.0,
                              ),
                            ),
                          ),
                          ...List.generate(itemcountcrew ?? 0, (index) {
                            if (snapshot.data?.credits?.crew?[index].job ==
                                'Director') {
                              final checknull = snapshot
                                  .data?.credits?.crew?[index].profilePath
                                  .toString();
                              if (checknull != 'null') {
                                return InkWell(
                                  onTap: (() {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => PersonScreen(
                                                id: snapshot.data?.credits
                                                    ?.crew?[index].id)));
                                  }),
                                  child: Container(
                                    height: 60.0,
                                    color:
                                        const Color.fromARGB(255, 41, 40, 40),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8.0, horizontal: 18.0),
                                    child: Row(
                                      children: [
                                        CircleAvatar(
                                          backgroundImage: NetworkImage(
                                              'https://image.tmdb.org/t/p/w400${snapshot.data?.credits?.crew?[index].profilePath}'),
                                        ),
                                        const SizedBox(
                                          width: 30,
                                        ),
                                        Text(
                                          '${snapshot.data?.credits?.crew?[index].originalName} ',
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 20.0),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              } else {
                                return InkWell(
                                  onTap: (() {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => PersonScreen(
                                                id: snapshot.data?.credits
                                                    ?.crew?[index].id)));
                                  }),
                                  child: Container(
                                    height: 60.0,
                                    color:
                                        const Color.fromARGB(255, 41, 40, 40),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8.0, horizontal: 18.0),
                                    child: Row(
                                      children: [
                                        const CircleAvatar(
                                          backgroundColor: Color.fromARGB(
                                              255, 137, 199, 101),
                                        ),
                                        const SizedBox(
                                          width: 30,
                                        ),
                                        Text(
                                          '${snapshot.data?.credits?.crew?[index].originalName} ',
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 20.0),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }
                            } else {
                              return const SizedBox();
                            }
                          }),
                        ],
                      ),
                      //Container Cast
                      Column(
                        children: [
                          Container(
                            height: 60.0,
                            margin:
                                const EdgeInsets.symmetric(horizontal: 18.0),
                            padding: EdgeInsets.only(bottom: 5.0),
                            alignment: Alignment.bottomLeft,
                            child: const Text(
                              'Cast',
                              style: TextStyle(
                                color: Color.fromARGB(255, 209, 208, 208),
                                fontSize: 18.0,
                              ),
                            ),
                          ),
                          ...List.generate(
                              itemcountcast! < 5 ? itemcountcast : 5, (index) {
                            final checknullcast = snapshot
                                .data?.credits?.cast?[index].profilePath
                                .toString();
                            if (checknullcast != 'null') {
                              return InkWell(
                                onTap: (() {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => PersonScreen(
                                              id: snapshot.data?.credits
                                                  ?.cast?[index].id)));
                                }),
                                child: Container(
                                  height: 60.0,
                                  color: const Color.fromARGB(255, 41, 40, 40),
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 8.0, horizontal: 18.0),
                                  child: Row(
                                    children: [
                                      CircleAvatar(
                                        backgroundImage: NetworkImage(
                                            'https://image.tmdb.org/t/p/w400${snapshot.data?.credits?.cast?[index].profilePath}'),
                                      ),
                                      const SizedBox(
                                        width: 30,
                                      ),
                                      Text(
                                        '${snapshot.data?.credits?.cast?[index].originalName} ',
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 20.0),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            } else {
                              return InkWell(
                                onTap: (() {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => PersonScreen(
                                              id: snapshot.data?.credits
                                                  ?.cast?[index].id)));
                                }),
                                child: Container(
                                  height: 60.0,
                                  color: const Color.fromARGB(255, 41, 40, 40),
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 8.0, horizontal: 18.0),
                                  child: Row(
                                    children: [
                                      const CircleAvatar(
                                        backgroundColor:
                                            Color.fromARGB(255, 137, 199, 101),
                                      ),
                                      const SizedBox(
                                        width: 30,
                                      ),
                                      Text(
                                        '${snapshot.data?.credits?.cast?[index].originalName} ',
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 20.0),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }
                          }),
                        ],
                      ),
                      const SizedBox(
                        height: 40.0,
                      ),
                      //Container iTunes
                      Container(
                        decoration: const BoxDecoration(
                            color: Color.fromARGB(255, 39, 38, 38),
                            //  color:const  Color.fromARGB(255, 55, 55, 55),
                            border: Border(
                                top: BorderSide(
                                    width: 1.0,
                                    color: Color.fromARGB(255, 93, 92, 92)),
                                bottom: BorderSide(
                                    width: 1.0,
                                    color: Color.fromARGB(255, 93, 92, 92)))),
                        height: 60.0,
                        padding: const EdgeInsets.symmetric(horizontal: 18.0),
                        child: Row(
                          children: const [
                            Icon(
                              Icons.apple,
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: 5.0,
                            ),
                            Text(
                              'Available Downloads on iTunes',
                              style: TextStyle(color: Colors.white),
                            ),
                            Expanded(child: SizedBox()),
                            Icon(Icons.navigate_next, color: Colors.white),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20.0,
                      )
                    ],
                  ),
                );
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }
              return const CircularProgressIndicator();
            })),
      ),
    );
  }
}

class Genre extends StatelessWidget {
  final snapshot;
  const Genre({
    Key? key,
    required this.snapshot,
    required this.itemcountgenres,
  }) : super(key: key);

  final int itemcountgenres;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.0,
      //color: const Color.fromARGB(255, 41, 40, 40),
      //margin: const EdgeInsets.only(top: 20.0),
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 18.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'Genre',
            style: TextStyle(
              color: Color.fromARGB(255, 209, 208, 208),
              fontSize: 18.0,
            ),
          ),
          const Expanded(child: SizedBox()),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ...List.generate(
                itemcountgenres < 3 ? itemcountgenres : 3,
                (index) {
                  if (snapshot.data!.genres![index].name != null) {
                    return Text(
                      '${snapshot.data!.genres?[index].name}, ',
                      style: const TextStyle(
                        color: Color.fromARGB(255, 255, 254, 254),
                        fontSize: 16.0,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    );
                  } else {
                    return const SizedBox();
                  }
                },
              )
            ],
          ),
        ],
      ),
    );
  }
}

class Rating extends StatelessWidget {
  const Rating({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.0,
      color: const Color.fromARGB(255, 41, 40, 40),
      //margin: const EdgeInsets.only(top: 20.0),
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 18.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'Rating',
            style: TextStyle(
              color: Color.fromARGB(255, 209, 208, 208),
              fontSize: 18.0,
            ),
          ),
          const Expanded(child: SizedBox()),
          Text('Not Available',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18.0,
              )),
          const SizedBox(
            width: 5.0,
          ),
        ],
      ),
    );
  }
}

class RunTime extends StatelessWidget {
  final snapshot;
  const RunTime({
    Key? key,
    required this.snapshot,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.0,
      //color: const Color.fromARGB(255, 41, 40, 40),
      //margin: const EdgeInsets.only(top: 20.0),
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 18.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'Runtime',
            style: TextStyle(
              color: Color.fromARGB(255, 209, 208, 208),
              fontSize: 18.0,
            ),
          ),
          const Expanded(child: SizedBox()),
          Text('${snapshot.data?.runtime} min',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18.0,
              )),
          const SizedBox(
            width: 5.0,
          ),
        ],
      ),
    );
  }
}

class ReleaseDate extends StatelessWidget {
  final snapshot;
  const ReleaseDate({Key? key, required this.snapshot}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.0,
      color: const Color.fromARGB(255, 41, 40, 40),
      margin: const EdgeInsets.only(top: 20.0),
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 18.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'Realease Date',
            style: TextStyle(
              color: Color.fromARGB(255, 209, 208, 208),
              fontSize: 18.0,
            ),
          ),
          const Expanded(child: SizedBox()),
          Text('${snapshot.data?.releaseDate}',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18.0,
              )),
          const SizedBox(
            width: 5.0,
          ),
        ],
      ),
    );
  }
}

class CustomList extends StatelessWidget {
  const CustomList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.0,
      color: const Color.fromARGB(255, 41, 40, 40),
      margin: const EdgeInsets.symmetric(vertical: 20.0),
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 18.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const [
          Text(
            'Custom List',
            style: TextStyle(
              color: Color.fromARGB(255, 209, 208, 208),
              fontSize: 18.0,
            ),
          ),
          Expanded(child: SizedBox()),
          Text('None',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
              )),
          SizedBox(
            width: 5.0,
          ),
          Icon(
            Icons.navigate_next,
            color: Colors.white,
          )
        ],
      ),
    );
  }
}

class OverView extends StatelessWidget {
  final snapshot;
  const OverView({Key? key, required this.snapshot}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(255, 41, 40, 40),
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 18.0),
      child: Text(
        '${snapshot.data?.overview}',
        style: const TextStyle(
          color: Colors.white,
          fontSize: 18.0,
          wordSpacing: 5.0,
        ),
      ),
    );
  }
}

class ListIamgeFilm extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final snapshot;
  const ListIamgeFilm(
      {Key? key, required this.itemcount, required this.snapshot})
      : super(key: key);

  final int? itemcount;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ...List.generate(
              itemcount!,
              (index) {
                if (snapshot.data!.productionCompanies![index].logoPath !=
                    null) {
                  return Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Image.network(
                            'https://image.tmdb.org/t/p/w92${snapshot.data!.productionCompanies?[index].logoPath}'),
                      ),
                      Container(height: 90, width: 1, color: Colors.black)
                    ],
                  );
                } else {
                  return const SizedBox();
                }
              },
            )
          ],
        ),
      ),
    );
  }
}

class MyRating extends StatelessWidget {
  const MyRating({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 22.0, vertical: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('My Rating',
                style: TextStyle(
                    color: Color.fromARGB(255, 215, 215, 215),
                    fontSize: 16,
                    fontWeight: FontWeight.w500)),
            const Text('Rate This Movie',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w600)),
            Row(children: const [
              Icon(Icons.star, color: Color.fromARGB(255, 141, 127, 2)),
              Icon(Icons.star, color: Color.fromARGB(255, 141, 127, 2)),
              Icon(Icons.star, color: Color.fromARGB(255, 141, 127, 2)),
              Icon(Icons.star, color: Color.fromARGB(255, 141, 127, 2)),
              Icon(Icons.star, color: Color.fromARGB(255, 141, 127, 2))
            ])
          ],
        ));
  }
}

class PosterDetailMovie extends StatelessWidget {
  final snapshot;
  const PosterDetailMovie({Key? key, required this.snapshot}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.89,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: [
          //image poster
          Center(
            child: Image.network(
                'https://image.tmdb.org/t/p/original${snapshot.data?.posterPath}'),
          ),

          //Container titile
          Container(
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.bottomLeft,
              height: 70.0,
              padding:
                  const EdgeInsets.symmetric(horizontal: 18.0, vertical: 10.0),
              color: const Color.fromARGB(255, 24, 24, 24).withOpacity(0.9),
              child: Row(
                children: [
                  const Icon(
                    Icons.arrow_back_ios_new,
                    color: Colors.white,
                  ),
                  const SizedBox(width: 30),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.7,
                    child: Text(
                      '${snapshot.data?.originalTitle}',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: const TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.w500),
                    ),
                  )
                ],
              )),

          //Container originalTitile
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              color: Colors.black,
              height: MediaQuery.of(context).size.height * 0.2,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 15.0),
                    child: Row(
                      children: [
                        Text(
                          '${snapshot.data?.releaseDate}',
                          style: const TextStyle(
                              color: Colors.white, fontSize: 14),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.0),
                          child: Icon(
                            Icons.add_circle,
                            color: Colors.white,
                            size: 6.0,
                          ),
                        ),
                        Text(
                          '${snapshot.data?.runtime} min',
                          style: const TextStyle(
                              color: Colors.white, fontSize: 14),
                        )
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        child: Text(
                          '${snapshot.data?.originalTitle}',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                  ),
                  const Expanded(child: SizedBox()),
                  //Container button
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Icon(Icons.play_circle_outline_rounded,
                            color: Colors.white, size: 44),
                        Icon(Icons.add_outlined, color: Colors.white, size: 44),
                        Icon(Icons.system_update_alt_rounded,
                            color: Colors.white, size: 44)
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
