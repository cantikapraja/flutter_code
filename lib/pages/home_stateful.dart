// import 'package:cantika_flutter/models/http_stateful.dart';
// import 'package:flutter/material.dart';

// class HomeStateful extends StatefulWidget {
//   @override
//   _HomeStatefulState createState() => _HomeStatefulState();
// }

// class _HomeStatefulState extends State<HomeStateful> {
//   HttpStateful dataResponse = HttpStateful();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("GET - STATEFUL")),
//       body: Container(
//         width: double.infinity,
//         margin: const EdgeInsets.all(20),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             ClipRRect(
//               borderRadius: BorderRadius.circular(50),
//               child: Container(
//                 height: 100,
//                 width: 100,
//                 child: Image.network(
//                   (dataResponse.avatar == null)
//                       ? "https://www.uclg-planning.org/sites/default/files/styles/featured_home_left/public/no-user-image-square.jpg?itok=PANMBJF-"
//                       : dataResponse.avatar,
//                   fit: BoxFit.cover,
//                 ),
//               ),
//             ),
//             SizedBox(height: 20),
//             FittedBox(
//               child: Text(
//                 (dataResponse.id == null)
//                     ? "ID : Belum ada data"
//                     : "ID : ${dataResponse.id}",
//                 style: TextStyle(fontSize: 20),
//               ),
//             ),
//             SizedBox(height: 20),
//             FittedBox(child: Text("Name : ", style: TextStyle(fontSize: 20))),
//             FittedBox(
//               child: Text(
//                 (dataResponse.fullname == null)
//                     ? "ID : Belum ada data"
//                     : "ID : ${dataResponse.fullname}",
//                 style: TextStyle(fontSize: 20),
//               ),
//             ),
//             SizedBox(height: 20),
//             FittedBox(child: Text("Email : ", style: TextStyle(fontSize: 20))),
//             FittedBox(
//               child: Text(
//                 (dataResponse.email == null)
//                     ? "ID : Belum ada data"
//                     : "ID : ${dataResponse.email}",
//                 style: TextStyle(fontSize: 20),
//               ),
//             ),
//             SizedBox(height: 100),
//             OutlinedButton(
//               onPressed: () {
//                 HttpStateful.connectAPI(
//                   (1 + Random().nextInt(10)).toString(),
//                 ).then((value) {
//                   setState(() {
//                     dataResponse = value;
//                   });
//                 });
//               },
//               child: Text("GET DATA", style: TextStyle(fontSize: 25)),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'dart:math';
import 'package:cantika_flutter/models/http_stateful.dart';
import 'package:flutter/material.dart';

class HomeStateful extends StatefulWidget {
  @override
  _HomeStatefulState createState() => _HomeStatefulState();
}

class _HomeStatefulState extends State<HomeStateful> {
  late HttpStateful dataResponse;

  @override
  void initState() {
    super.initState();
    dataResponse = HttpStateful(id: "", fullname: "", email: "", avatar: "");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("GET - STATEFUL")),
      body: Container(
        width: double.infinity,
        margin: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Container(
                height: 100,
                width: 100,
                child: Image.network(
                  (dataResponse.avatar.isEmpty)
                      ? "https://www.uclg-planning.org/sites/default/files/styles/featured_home_left/public/no-user-image-square.jpg?itok=PANMBJF-"
                      : dataResponse.avatar,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 20),
            FittedBox(
              child: Text(
                (dataResponse.id.isEmpty)
                    ? "ID : Belum ada data"
                    : "ID : ${dataResponse.id}",
                style: TextStyle(fontSize: 20),
              ),
            ),
            SizedBox(height: 20),
            FittedBox(child: Text("Name : ", style: TextStyle(fontSize: 20))),
            FittedBox(
              child: Text(
                (dataResponse.fullname.isEmpty)
                    ? "Belum ada data"
                    : dataResponse.fullname,
                style: TextStyle(fontSize: 20),
              ),
            ),
            SizedBox(height: 20),
            FittedBox(child: Text("Email : ", style: TextStyle(fontSize: 20))),
            FittedBox(
              child: Text(
                (dataResponse.email.isEmpty)
                    ? "Belum ada data"
                    : dataResponse.email,
                style: TextStyle(fontSize: 20),
              ),
            ),
            SizedBox(height: 100),
            OutlinedButton(
              onPressed: () async {
                try {
                  final value = await HttpStateful.connectAPI(
                    (1 + Random().nextInt(10)).toString(),
                  );
                  setState(() {
                    dataResponse = value;
                  });
                } catch (e) {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text("Error: $e")));
                }
              },
              child: Text("GET DATA", style: TextStyle(fontSize: 25)),
            ),
          ],
        ),
      ),
    );
  }
}
