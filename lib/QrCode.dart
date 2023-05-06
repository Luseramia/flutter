import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'user.dart';

class MyQRCode extends StatefulWidget {
  const MyQRCode({Key? key}) : super(key: key);

  @override
  State<MyQRCode> createState() => _MyQRCodeState();
}

class _MyQRCodeState extends State<MyQRCode> {
  @override
  void initState() {
    get_email();
    super.initState();
  }

  late var _email = " ";
  @override
  Future get_email() async {
    String? email = await user.getEmail();
    print(email);
    return _email = email.toString();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.2),
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.15,
                child: Text(
                  "My QR",
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).size.height * 0.1,
                      color: Colors.blueGrey,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            // QrImage(
            //   data: controller,
            //   size: 200,
            //   backgroundColor: Colors.white12,
            // ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.height * 0.1),
              child: FutureBuilder(
                future: get_email(),
                builder:
                    (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  if (snapshot.hasError) print(snapshot.error);
                  return snapshot.hasData
                      ? Container(
                          child: QrImage(
                            data: _email,
                            size: MediaQuery.of(context).size.height * 0.3,
                            backgroundColor: Colors.white12,
                          ),
                        )
                      : Center(
                          child: Container(),
                        );
                },
              ),
            ),

            // buildTextField(context),
          ],
        ),
      );
  // Widget buildTextField(BuildContext context) => TextField(
  //       controller: controller,
  //       style: TextStyle(
  //           color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
  //       decoration: InputDecoration(
  //           hintText: 'Enter the data',
  //           hintStyle: TextStyle(color: Colors.grey),
  //           enabledBorder: OutlineInputBorder(
  //               borderRadius: BorderRadius.circular(8),
  //               borderSide:
  //                   BorderSide(color: Theme.of(context).primaryColorDark)),
  //           focusedBorder: OutlineInputBorder(
  //               borderRadius: BorderRadius.circular(8),
  //               borderSide:
  //                   BorderSide(color: Theme.of(context).primaryColorDark)),
  //           suffixIcon: IconButton(
  //             color: Theme.of(context).primaryColorLight,
  //             icon: Icon(
  //               Icons.done,
  //               size: 30,
  //             ),
  //             onPressed: () => setState(() {}),
  //           )),
  //     );
}
