import 'package:flutter/material.dart';
import 'package:screening/utils/robot_card.dart';
import 'package:screening/utils/robot_model.dart';
import 'package:screening/utils/robot_repository.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  Future<List<Robot>> robotFuture;

  @override
  void initState() {
    robotFuture = RobotRepository.getRobots();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FutureBuilder<List<Robot>>(
          future: robotFuture,
          initialData: const [],
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return HomePage(
                key: UniqueKey(),
                robots: snapshot.data ?? [],
              );
            } else {
              return const LoadingHome();
            }
          }),
    );
  }
}

class LoadingHome extends StatelessWidget {
  const LoadingHome({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          height: MediaQuery
              .of(context)
              .size
              .height,
          width: MediaQuery
              .of(context)
              .size
              .width,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: <Color>[
                Color.fromRGBO(54, 125, 126, 1),
                Color.fromRGBO(12, 30, 80, 1),
              ],
            ),
          ),
          child: Column(
            children: [
              const SizedBox(
                height: 120,
                child: Center(
                  child: Text(
                    'ROBOFRIENDS',
                    style: TextStyle(
                      fontFamily: 'Sega Logo Font',
                      color: Color(0xff0ccac4),
                      fontSize: 50,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
              ),
              Center(
                child: Container(
                  width: 200,
                  height: 52,
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.green),
                    color: const Color.fromRGBO(211, 235, 253, 1),
                  ),
                  child: Center(
                    child: TextField(
                      style: TextStyle(
                        color: Colors.grey.shade50,
                      ),
                      decoration: const InputDecoration(
                        hintText: 'search robots',
                        hintStyle: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Color.fromRGBO(121, 122, 123, 1),
                        ),
                        contentPadding: EdgeInsets.only(left: 15),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
              ),
              Center(
                child: CircularProgressIndicator(),
              )
            ],
          ),
        ));
  }
}

class HomePage extends StatefulWidget {
  final List<Robot> robots;

  const HomePage({Key key, this.robots}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController _searchController;
  List<Robot> _filteredRobots = [];

  @override
  void initState() {
    _searchController = TextEditingController();
    _filteredRobots = widget.robots;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          height: MediaQuery
              .of(context)
              .size
              .height,
          width: MediaQuery
              .of(context)
              .size
              .width,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: <Color>[
                Color.fromRGBO(54, 125, 126, 1),
                Color.fromRGBO(12, 30, 80, 1),
              ],
            ),
          ),
          child: Column(
            children: [
              const SizedBox(
                height: 120,
                child: Center(
                  child: Text(
                    'ROBOFRIENDS',
                    style: TextStyle(
                      fontFamily: 'Sega Logo Font',
                      color: Color(0xff0ccac4),
                      fontSize: 50,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
              ),
              Center(
                child: Container(
                  width: 200,
                  height: 52,
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.green),
                    color: const Color.fromRGBO(211, 235, 253, 1),
                  ),
                  child: Center(
                    child: TextField(
                      style: TextStyle(
                        color: Colors.grey.shade50,
                      ),
                      decoration: const InputDecoration(
                        hintText: 'search robots',
                        hintStyle: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Color.fromRGBO(121, 122, 123, 1),
                        ),
                        contentPadding: EdgeInsets.only(left: 15),
                        border: InputBorder.none,
                      ),
                      controller: _searchController,
                      onChanged: (String value) {
                        final String lowerCaseValue = value.toLowerCase();
                        if (lowerCaseValue.isNotEmpty) {
                          _filteredRobots = widget.robots
                              .where((element) =>
                          element.name.toLowerCase().contains(value) || element.email.toLowerCase().contains(value))
                              .toList();
                        }
                        setState(() {});
                      },
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width,
                    decoration: BoxDecoration(
                      border: Border.all(width: 6),
                    ),
                    child: SingleChildScrollView(
                      child: Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        alignment: WrapAlignment.center,
                        children: _filteredRobots
                            .map((e) =>
                            RobotCard(
                              key: UniqueKey(),
                              robot: e,
                            ))
                            .toList(),
                      ),
                    )),
              ),
            ],
          ),
        ));
  }
}
