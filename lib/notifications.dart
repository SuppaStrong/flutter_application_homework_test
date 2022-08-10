import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tiengviet/tiengviet.dart';

void main() {
  searchData = [];

  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyApp(),
  ));
}

String parseTimeStamp(int value) {
  var date = DateTime.fromMillisecondsSinceEpoch(value * 1000);
  var d12 = DateFormat('MM/dd/yyyy, hh:mm').format(date);
  return d12;
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title:
                const Text("Thông báo ", style: TextStyle(color: Colors.black)),
            actions: [
              IconButton(
                  onPressed: () {
                    showSearch(context: context, delegate: MySearch());
                  },
                  icon: const Icon(
                    Icons.search,
                    color: Colors.black,
                  ))
            ],
            backgroundColor: const Color.fromARGB(255, 255, 255, 255),
          ),
          body: Center(
            // Use future builder and DefaultAssetBundle to load the local JSON file
            child: listNotifications(context),
          )),
    );
  }

  FutureBuilder<String> listNotifications(BuildContext context) {
    return FutureBuilder(
              future: DefaultAssetBundle.of(context)
                  .loadString('assets/json/noti.json'),
              builder: (context, snapshot) {
                // Decode the JSON
                var data = json.decode(snapshot.data.toString());

                return GestureDetector(
                  child: ListView.builder(
                    // Build the ListView
                    itemBuilder: (BuildContext context, int index) {
                      searchData.add(data[index]["message"]["text"]);
                      return SizedBox(
                        height: 80,
                        child: ListTile(
                          leading: Container(
                            margin: const EdgeInsets.all(1),
                            child: Stack(
                              children: <Widget>[
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: Image.network(
                                      data[index]["imageThumb"]),
                                ),
                                Positioned(
                                  right: 0,
                                  bottom: 0,
                                  child: SizedBox(
                                    height: 24,
                                    width: 24,
                                    child: Image.network(data[index]["icon"]),
                                  ),
                                )
                              ],
                            ),
                          ),
                          title: RichText(
                            text: TextSpan(children: <TextSpan>[
                              TextSpan(
                                  text: data[index]["subjectName"],
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black)),
                              TextSpan(
                                text: data[index]["message"]["text"]
                                    .toString()
                                    .replaceAll(
                                        data[index]["subjectName"].toString(),
                                        ""),
                                style: const TextStyle(color: Colors.black),
                              )
                            ]),
                          ),
                          subtitle:
                              Text(parseTimeStamp(data[index]["receivedAt"])),
                          trailing: IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.more_horiz),
                          ),
                        ),
                      );
                    },
                    itemCount: data == null ? 0 : data.length,
                  ),
                );
              });
  }
}

late final List<String> searchData;


class MySearch extends SearchDelegate {
  // first overwrite to
  // clear the search text
  @override
  List<Widget>? buildActions(BuildContext context) {
    return <Widget>[
      if (query.isNotEmpty)
        IconButton(
          onPressed: () {
            query = '';
          },
          icon: const Icon(Icons.clear),
        ),
    ];
  }

  // second overwrite to pop out of search menu
  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(Icons.close),
    );
  }

  // third overwrite to show query result
  @override
  Widget buildResults(BuildContext context) {
    List<String> matchQuery = [];
    for (var jsonData in searchData) {
      if (TiengViet.parse(jsonData)
          .toLowerCase()
          .contains(query.toLowerCase())) {
        matchQuery.add(jsonData);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return ListTile(
          title: Text(result),
        );
      },
    );
  }

  // last overwrite to show the
  // querying process at the runtime
  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> matchQuery = [];
    for (var jsonData in searchData) {
      if (TiengViet.parse(jsonData)
          .toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(jsonData);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return ListTile(
          title: Text(result),
        );
      },
    );
  }
}
