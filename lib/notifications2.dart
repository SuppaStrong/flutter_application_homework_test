import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_home_work_final/notificationFind.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';

void main() {
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
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const NotificationSearch()));
                  },
                  icon: const Icon(
                    Icons.search,
                    color: Colors.black,
                  ))
            ],
            backgroundColor: const Color.fromARGB(255, 255, 255, 255),
          ),
          body: Center(
            // Use future buigit lder and DefaultAssetBundle to load the local JSON file
            child: listNotifications(context),
          )),
    );
  }

  FutureBuilder<String> listNotifications(BuildContext context) {
    return FutureBuilder(
        future:
            DefaultAssetBundle.of(context).loadString('assets/json/noti.json'),
        builder: (context, snapshot) {
          // Decode the JSON
          var data = json.decode(snapshot.data.toString());

          return GestureDetector(
            child: ListView.builder(
              // Build the ListView
              itemBuilder: (BuildContext context, int index) {
                return SizedBox(
                  height: 80,
                  child: ListTile(
                    leading: Container(
                      margin: const EdgeInsets.all(1),
                      child: Stack(
                        children: <Widget>[
                          ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Image.network(data[index]["imageThumb"]),
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
                                  data[index]["subjectName"].toString(), ""),
                          style: const TextStyle(color: Colors.black),
                        )
                      ]),
                    ),
                    subtitle: Text(parseTimeStamp(data[index]["receivedAt"])),
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
