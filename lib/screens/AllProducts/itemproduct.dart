import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ItemProduct extends StatelessWidget {
  const ItemProduct({super.key});

  @override
  Widget build(BuildContext context) {
    Future<List<String>> displayUserNames() async {
      List<String> userNames = [];

      QuerySnapshot<Map<String, dynamic>> reportsSnapshot =
          await FirebaseFirestore.instance.collection("orders").get();

      for (var report in reportsSnapshot.docs) {
        var userId = report.data()["idUser"];

        DocumentSnapshot<Map<String, dynamic>> userSnapshot =
            await FirebaseFirestore.instance
                .collection("users")
                .doc(userId)
                .get();

        if (userSnapshot.exists) {
          var userName = userSnapshot.data()!["email"];
          userNames.add(userName);
        }
      }

      return userNames;
    }

    Future<List<String>> displayUserPhoneReverse() async {
      List<String> userNames = [];

      QuerySnapshot<Map<String, dynamic>> reverseSnapshot =
          await FirebaseFirestore.instance.collection("orders").get();

      for (var reverse in reverseSnapshot.docs) {
        var userId = reverse.data()["idUser"];

        DocumentSnapshot<Map<String, dynamic>> userSnapshot =
            await FirebaseFirestore.instance
                .collection("users")
                .doc(userId)
                .get();

        if (userSnapshot.exists) {
          var userName = userSnapshot.data()!["numberphone"];
          userNames.add(userName);
        }
      }
      return userNames;
    }

    final List<dynamic> arguments =
        ModalRoute.of(context)?.settings.arguments as List<dynamic>;
    String adress = arguments[0];
    String productName = arguments[1];
    String imageLink = arguments[2];
    String iduser = arguments[3];
    String id = arguments[4];
    Timestamp createdAt = arguments[5];
    String location = arguments[6];
    String price = arguments[7];
    int statusReverse = arguments[8];
    return Scaffold(
      appBar: AppBar(
        title: const Text('تفاصيل '),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              clipBehavior: Clip.antiAlias,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(55),
                    bottomRight: Radius.circular(15),
                    topRight: Radius.circular(15),
                    topLeft: Radius.circular(15)),
              ),
              // width: double.infinity,
              // height: 400,
              child: Image.network(
                  // color: Colors.amber,
                  width: double.infinity,
                  height: 400,
                  fit: BoxFit.cover,
                  imageLink),
            ),
            const SizedBox(
              height: 10,
            ),
            FutureBuilder<List<String>>(
              future: displayUserNames(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (snapshot.hasData) {
                  return InkWell(
                    onTap: () async {
                      final Uri emailUri = Uri(
                        scheme: 'mailto',
                        path: snapshot.data!.first, // أضف البريد الإلكتروني هنا
                      );
                      if (await canLaunch(emailUri.toString())) {
                        await launch(emailUri.toString());
                      } else {
                        throw 'لا تمتلك بطيق ال email';
                      }
                    },
                    child:
                        //  Row(
                        //   children: [
                        //     Icon(
                        //       Icons.person,
                        //       color: getStatusReverseColor(statusReverse),
                        //     ),
                        //     const SizedBox(
                        //       width: 10,
                        //     ),
                        // ],
                        // ),
                        Text(snapshot.data!.first),
                  );
                } else {
                  return const Text('لا يوجد بيانات للعرض');
                }
              },
            ),
            const SizedBox(
              height: 10,
            ),
            FutureBuilder<List<String>>(
              future: displayUserPhoneReverse(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (snapshot.hasData) {
                  return InkWell(
                    onTap: () {
                      final Uri phoneUri = Uri(
                        scheme: 'tel',
                        path: snapshot.data!.first, // أضف رقم الهاتف هنا
                      );
                      launch(phoneUri.toString());
                    },
                    child: Text(snapshot.data!.first),
                  );
                  // return Row(
                  //   children: [
                  //     Icon(
                  //       Icons.call,
                  //       color: getStatusReverseColor(statusReverse),
                  //     ),
                  //     const SizedBox(
                  //       width: 10,
                  //     ),

                  //   ],
                  // );
                } else {
                  return const Text('لا يوجد بيانات للعرض');
                }
              },
            ),
            Text(
              '$price' '\$',
              style: const TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.red),
            ),
            Text(
              productName,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              adress,
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 108, 108, 108)),
            ),
            Container(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30)),
              ),
              child: MaterialButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                color: const Color.fromARGB(255, 121, 121, 121),
                minWidth: 150,
                height: 50,
                elevation: 10,
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.arrow_back,
                      size: 30,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      'رجوع',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
