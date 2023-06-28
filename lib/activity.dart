import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_login/qrscan.dart';
import 'package:http/http.dart' as http;

class Actshow extends StatefulWidget {
  const Actshow({Key? key}) : super(key: key);

  @override
  State<Actshow> createState() => _ActshowState();
}

class _ActshowState extends State<Actshow> {
  @override
  Future all_activity() async {
    var url = "http://192.168.1.56/flutter_login/activityE.php";
    final respones = await http.post(Uri.parse(url));
    return json.decode(respones.body);
  }

  Widget build(BuildContext context) {
    return Expanded(
      child: FutureBuilder(
        future: all_activity(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasError) print(snapshot.error);
          return snapshot.hasData
              ? Container(
                  color: Colors.white,
                  child: Stack(
                    children: [
                      Container(
                        child: ListView.builder(
                            itemCount: snapshot.data.length,
                            itemBuilder: (context, index) {
                              List list = snapshot.data;
                              return Center(
                                child: Padding(
                                  padding: EdgeInsets.only(top: 70),
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .outline,
                                      ),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(12)),
                                    ),
                                    // clipBehavior is necessary because, without it, the InkWell's animation
                                    // will extend beyond the rounded edges of the [Card] (see https://github.com/flutter/flutter/issues/109776)
                                    // This comes with a small performance cost, and you should not set [clipBehavior]
                                    // unless you need it.
                                    clipBehavior: Clip.hardEdge,

                                    child: InkWell(
                                      splashColor: Colors.blue.withAlpha(30),
                                      onTap: () {
                                        debugPrint('Card tapped.');
                                      },
                                      child: const SizedBox(
                                        width: 300,
                                        height: 100,
                                        child: Center(
                                            child: Text(
                                                'A card that can be tapped')),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                              // child: Column(children: [
                              //   Text(list[index]['name']),
                              //   OutlinedButton(
                              //       onPressed: () {
                              //         Navigator.of(context).push(
                              //             MaterialPageRoute(
                              //                 builder: (context) {
                              //           return QRsaner(
                              //             hour:
                              //                 list[index]['hour'].toString(),
                              //             actName: list[index]['name'],
                              //           );
                              //         }));
                              //       },
                              //       child: Icon(Icons.login))
                              // ]),
                            }),
                      )
                    ],
                  ),
                )
              : Center(
                  child: Container(),
                );
        },
      ),
    );
  }
}
