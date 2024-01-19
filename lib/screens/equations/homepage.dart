import 'package:call_application_demo/screens/calculator/calculator_view.dart';
import 'package:call_application_demo/services/SessionManager.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<List<String>?> LoadEquation() async {
    List<String>? fetch = await SessionManager.loadSavedEquations();
    return fetch;
  }

  Future<List<String>?> LoadResult() async {
    List<String>? fetch = await SessionManager.loadSavedResults();
    return fetch;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: ,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent.withOpacity(0.6),
          leading: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CalculatorView()),
              );
            },
            child: const Icon(Icons.arrow_back, color: Colors.orange),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: ElevatedButton(
                onPressed: () {
                  SessionManager.clearSharedPreferences();
                  setState(() {});
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Calculator Storage Alert'),
                        content: const Text('Data Cleared...'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('OK'),
                          ),
                        ],
                      );
                    },
                  );
                },
                child: const Text('Clear'),
              ),
            ),
            const SizedBox(width: 20),
          ],
        ),
        extendBodyBehindAppBar: true,
        body: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/taklumaklu.png"),
                    fit: BoxFit.fill,
                  ),
                ),
                child: SafeArea(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                      Container(
                        padding: const EdgeInsets.only(
                            left: 10, right: 10, top: 20, bottom: 20),
                        child: Table(
                          border:
                              TableBorder.all(width: 2.0, color: Colors.red),
                          children: [
                            const TableRow(
                              children: [
                                TableCell(
                                  child: Center(
                                      child: Text(
                                    'Equations',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  )),
                                ),
                                TableCell(
                                  child: Center(
                                      child: Text(
                                    'Results',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  )),
                                ),
                              ],
                            ),
                            TableRow(
                              children: [
                                TableCell(
                                  child: Center(
                                    child: FutureBuilder<List<String>?>(
                                      future: LoadEquation(),
                                      builder: (context, snapshot) {
                                        if (snapshot.connectionState ==
                                            ConnectionState.waiting) {
                                          return const CircularProgressIndicator();
                                        } else if (snapshot.hasError) {
                                          return Text(
                                            'Error: ${snapshot.error}',
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          );
                                        } else if (snapshot.hasData) {
                                          return ListView(
                                            shrinkWrap: true,
                                            children: snapshot.data!
                                                .map((equation) => Text(
                                                      equation,
                                                      style: const TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ))
                                                .toList(),
                                          );
                                        } else {
                                          return const Text('No data available',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold));
                                        }
                                      },
                                    ),
                                  ),
                                ),
                                TableCell(
                                  child: Center(
                                    child: FutureBuilder<List<String>?>(
                                      future: LoadResult(),
                                      builder: (context, snapshot) {
                                        if (snapshot.connectionState ==
                                            ConnectionState.waiting) {
                                          return const CircularProgressIndicator();
                                        } else if (snapshot.hasError) {
                                          return Text(
                                            'Error: ${snapshot.error}',
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          );
                                        } else if (snapshot.hasData) {
                                          return ListView(
                                            shrinkWrap: true,
                                            children: snapshot.data!
                                                .map((result) => Text(
                                                      result,
                                                      style: const TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ))
                                                .toList(),
                                          );
                                        } else {
                                          return const Text(
                                            'No data available',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          );
                                        }
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ]))));
  }
}
