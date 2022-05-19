import 'package:flutter/material.dart';
import 'package:moviedb/detail_person/model/person_model.dart';
import 'package:moviedb/detail_person/model/personfilm_model.dart';
import 'package:moviedb/detail_person/network/person_network.dart';

class PersonScreen extends StatefulWidget {
  const PersonScreen({Key? key, required this.id}) : super(key: key);
  final int? id;
  @override
  State<PersonScreen> createState() => _PersonScreenState(id: id);
}

class _PersonScreenState extends State<PersonScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;
  late Future<PersonModel> futurePerson;
  late Future<PersonFilmModel> futureFilmPerson;
  late int? id;
  _PersonScreenState({this.id});
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    futurePerson = fetchPerson(id!);
    futureFilmPerson = fetchFilmPerson(id!);
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<PersonModel>(
        future: futurePerson,
        builder: ((context, snapshot) {
          if (snapshot.hasData) {
            String? checkprofilepath = snapshot.data?.profilePath;
            return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.black.withOpacity(0.7),
                leading: Icon(Icons.navigate_before),
                title: Text('${snapshot.data?.name}'),
              ),
              body: Stack(children: [
                //Container bottom background
                Container(
                    child: checkprofilepath != null
                        ? Image.network(
                            'https://image.tmdb.org/t/p/w400${snapshot.data?.profilePath}')
                        : Container(
                            color: Colors.black45,
                          )),
                //Container top background
                Container(
                  child: Column(
                    children: [
                      //Container avatar
                      Container(
                        color: Colors.black.withOpacity(0.8),
                        height: MediaQuery.of(context).size.height * 0.33,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Align(
                              alignment: Alignment.center,
                              child: checkprofilepath != null
                                  ? CircleAvatar(
                                      minRadius: 70.0,
                                      maxRadius: 70.0,
                                      backgroundImage: NetworkImage(
                                          'https://image.tmdb.org/t/p/w400${snapshot.data?.profilePath}'),
                                    )
                                  : CircleAvatar(
                                      minRadius: 70.0,
                                      maxRadius: 70.0,
                                      backgroundColor: Colors.grey,
                                    ),
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: Container(
                                  margin: const EdgeInsets.only(top: 20),
                                  child: Column(
                                    children: [
                                      const Text(
                                        '54 Years Old',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18.0),
                                      ),
                                      const SizedBox(
                                        height: 5.0,
                                      ),
                                      Text('${snapshot.data?.placeOfBirth}',
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 18.0)),
                                      const SizedBox(
                                        height: 5.0,
                                      ),
                                      const Text('12 Movie',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18.0))
                                    ],
                                  )),
                            ),
                          ],
                        ),
                      ),
                      //Container info
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 10.0),
                          color: Colors.black,
                          width: MediaQuery.of(context).size.width,
                          child: Column(
                            children: [
                              //Container TacBar
                              Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    color:
                                        const Color.fromARGB(255, 40, 39, 39)),
                                width: MediaQuery.of(context).size.width * 0.5,
                                child: TabBar(
                                    indicator: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        color: const Color.fromARGB(
                                            255, 91, 93, 91)),
                                    controller: _tabController,
                                    tabs: <Widget>[
                                      Container(
                                        height: 30,
                                        alignment: Alignment.center,
                                        child: const Text(
                                          'Biography',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 13),
                                        ),
                                      ),
                                      Container(
                                        height: 30,
                                        alignment: Alignment.center,
                                        child: const Text(
                                          'Movies',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 13),
                                        ),
                                      )
                                    ]),
                              ),
                              //Container TabBarView
                              Expanded(
                                  child: TabBarView(
                                controller: _tabController,
                                children: [
                                  //Container first tabBar
                                  SingleChildScrollView(
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 18.0, vertical: 10.0),
                                      margin: EdgeInsets.only(top: 10.0),
                                      color: Color.fromARGB(255, 44, 44, 44),
                                      child: Text(
                                        '${snapshot.data?.biography}',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                  //Container second tabBar
                                  FutureBuilder<PersonFilmModel>(
                                    future: futureFilmPerson,
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        return SingleChildScrollView(
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 18.0),
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            child: Column(
                                              children: [
                                                ...List.generate(
                                                    snapshot.data!.cast!.length,
                                                    (index) {
                                                  if (snapshot
                                                          .data
                                                          ?.cast?[index]
                                                          .posterPath.toString() !=
                                                      'null') {
                                                    return Container(
                                                      margin:
                                                          EdgeInsets.symmetric(
                                                              vertical: 10.0),
                                                      child: Row(
                                                        children: [
                                                          CircleAvatar(
                                                            backgroundImage:
                                                                NetworkImage(
                                                                    'https://image.tmdb.org/t/p/w92${snapshot.data?.cast?[index].posterPath}'),
                                                          ),
                                                          const SizedBox(
                                                            width: 30,
                                                          ),
                                                          Container(
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                0.7,
                                                            child: Text(
                                                              '${snapshot.data?.cast?[index].originalTitle} ',
                                                              style: const TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize:
                                                                      20.0),
                                                              maxLines: 1,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    );
                                                  } else {
                                                    return SizedBox();
                                                  }
                                                })
                                              ],
                                            ),
                                          ),
                                        );
                                      } else if (snapshot.hasError) {
                                        return Text('${snapshot.error}');
                                      }
                                      return const CircularProgressIndicator();
                                    },
                                  ),
                                ],
                              ))
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ]),
            );
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }
          return const CircularProgressIndicator();
        }));
  }
}
