import 'package:flutter/material.dart';
import 'package:flutter_application_home_work_final/constants.dart';
// ignore: depend_on_referenced_packages
import 'package:tiengviet/tiengviet.dart';

import 'notifications2.dart';

class NotificationSearch extends StatefulWidget {
  const NotificationSearch({Key? key}) : super(key: key);

  @override
  State<NotificationSearch> createState() => _NotificationSearchState();
}

class _NotificationSearchState extends State<NotificationSearch> {
  List<Map<String, dynamic>> foundData = [];
  @override
  void initState() {
    foundData = allData;
    super.initState();
  }

  void startSearch(String enterKeyword) {
    List<Map<String, dynamic>> results = [];

    if (enterKeyword.isEmpty) {
      results = allData;
    } else {
      results = allData
          .where((user) => TiengViet.parse(user["message"]["text"])
              .toLowerCase()
              .contains(enterKeyword.toLowerCase()))
          .toList();
    }

    setState(() {
      foundData = results;
    });
  }

  var textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            TextField(
              
              controller: textController,
              onChanged: (value) => startSearch(value),
              decoration: InputDecoration(
                border : OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                icon: IconButton(icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.pop(context);
                  },),
                hintText: "Search",
                prefixIcon: const Icon(Icons.search , color: Colors.black,),
                suffixIcon: textController.text.isNotEmpty
                    ? IconButton(
                        onPressed: () {
                          textController.clear();
                          setState(() {
                            startSearch("");
                          });
                        },
                        icon: const Icon(Icons.clear_rounded, color: Colors.black,))
                    : null,
              ),
            ),
            Expanded(
                child: foundData.isNotEmpty
                    ? GestureDetector(
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
                                        child: Image.network(
                                            foundData[index]["imageThumb"]),
                                      ),
                                      Positioned(
                                        right: 0,
                                        bottom: 0,
                                        child: SizedBox(
                                          height: 24,
                                          width: 24,
                                          child: Image.network(
                                              foundData[index]["icon"]),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                title: RichText(
                                  text: TextSpan(children: <TextSpan>[
                                    TextSpan(
                                        text: foundData[index]["subjectName"],
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black)),
                                    TextSpan(
                                      text: foundData[index]["message"]["text"]
                                          .toString()
                                          .replaceAll(
                                              foundData[index]["subjectName"]
                                                  .toString(),
                                              ""),
                                      style: const TextStyle(color: Colors.black),
                                    )
                                  ]),
                                ),
                                subtitle: Text(parseTimeStamp(
                                    foundData[index]["receivedAt"])),
                                trailing: IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.more_horiz),
                                ),
                              ),
                            );
                          },
                          itemCount: foundData.length,
                        ),
                      )
                    : const Center(child: Text("No Notification found !!!"))),
          ],
        ),
      ),
    );
  }
}
