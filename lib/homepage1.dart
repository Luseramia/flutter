import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Page1 extends StatefulWidget {
  const Page1({Key? key}) : super(key: key);

  @override
  State<Page1> createState() => _Page1State();
}

class _Page1State extends State<Page1> {
  @override
  Future all_image() async {
    var url = "http://192.168.139.160/flutter_login/image.php";
    final respones = await http.post(Uri.parse(url));
    return json.decode(respones.body);
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: FutureBuilder(
        future: all_image(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasError) print(snapshot.error);
          return snapshot.hasData
              ? Container(
                  child: Stack(
                    children: [
                      Container(
                        child: ListView.builder(
                            itemCount: snapshot.data.length,
                            itemBuilder: (context, index) {
                              List list = snapshot.data;
                              return Container(
                                decoration: BoxDecoration(),
                                child: Column(
                                  children: [
                                    Container(
                                      child: Image.network(
                                        "http://192.168.139.160/flutter_login/uploads/${list[index]['image']}",
                                      ),
                                    ),
                                    Container(
                                      width: double.infinity,
                                      height: 100,
                                      decoration:
                                          BoxDecoration(color: Colors.white),
                                      child: Column(children: [
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              10, 10, 10, 1),
                                          child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                list[index]['name'],
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.black),
                                              )),
                                        )
                                      ]),
                                    )
                                  ],
                                ),
                              );
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
