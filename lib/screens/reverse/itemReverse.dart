import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ItemeReverse extends StatefulWidget {
  const ItemeReverse({super.key});

  @override
  State<ItemeReverse> createState() => _ItemeReverseState();
}

class _ItemeReverseState extends State<ItemeReverse> {
  // Future<String> getAddress(double latitude, double longitude) async {
  //   List<Placemark> placemarks =
  //       await placemarkFromCoordinates(latitude, longitude);
  //   Placemark place = placemarks[0];
  //   return '${place.street}, ${place.locality}, ${place.administrativeArea}, ${place.country}';
  // }

  @override
  Widget build(BuildContext context) {
    final List<dynamic> arguments =
        ModalRoute.of(context)?.settings.arguments as List<dynamic>;

    String adress = arguments[0];
    String typeInsect = arguments[1];
    String imageLink = arguments[2];
    String iduser = arguments[3];
    String id = arguments[4];
    Timestamp createdAt = arguments[5];
    String location = arguments[6];
    String price = arguments[7];
    int statusReverse = arguments[8];
    // String adress = arguments[0];
    // String typeInsect = arguments[1];
    // String imageLink = arguments[2];
    // String iduser = arguments[3];
    // String id = arguments[4];
    // Timestamp createdAt = arguments[5];
    // String location = arguments[6];
    // String space = arguments[7];
    // int statusReverse = arguments[8];
    return Scaffold(
      appBar: AppBar(
        title: const Text('تفاصيل  الطلب '),
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
                  height: 500,
                  fit: BoxFit.cover,
                  imageLink),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              '$price' '\$',
              style: const TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.red),
            ),
            Text(
              typeInsect,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              adress,
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 108, 108, 108)),
            ),
            const Spacer(),
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
                color: Colors.blue[300],

                // color: const Color.fromARGB(255, 121, 121, 121),
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
