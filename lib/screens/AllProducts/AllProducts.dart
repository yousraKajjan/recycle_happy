import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Allproducts extends StatefulWidget {
  const Allproducts({super.key});
  @override
  State<Allproducts> createState() => _AllproductsState();
}

class _AllproductsState extends State<Allproducts> {
  bool check = false;

  Future<QuerySnapshot<Map<String, dynamic>>?>? initData() async {
    return FirebaseFirestore.instance
        .collection("orders")
        .orderBy("createdAt", descending: true)
        .get();
  }

  @override
  void initState() {
    initData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('كل المنتجات'),
      //   // leading: const Icon(Icons.people),
      // ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder(
          future: initData(),
          builder: (context, snap) {
            if (snap.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snap.hasError) return const Text("Something has error");
            if (snap.data == null) {
              return const Text("لا يوجد منتجات ");
            }
            return Padding(
              padding: const EdgeInsets.only(top: 7.0),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 70,
                    crossAxisSpacing: 30),
                // separatorBuilder: (context, index) {
                //   return const SizedBox(
                //     height: 100,
                //   );
                // },
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: snap.data?.docs.length ?? 0,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, '/item-prodcut', arguments: [
                        snap.data!.docs[index]['Adress'],
                        snap.data!.docs[index]['name product'],
                        snap.data!.docs[index]['imageLink'],
                        snap.data!.docs[index]['idUser'],
                        snap.data!.docs[index]['id'],
                        snap.data!.docs[index]['createdAt'],
                        snap.data!.docs[index]['location'],
                        snap.data!.docs[index]['price'],
                        snap.data!.docs[index]['statusReverse'],
                      ]);
                    },
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Card(
                          elevation: 5, // زيادة الظل للكارت
                          margin: const EdgeInsets.all(
                              0), // تعديل المسافة بين الكارت والعناصر الأخرى
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.white,
                            ),
                            width: double.infinity,
                            height: 400,
                            // زيادة ارتفاع الكارت
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 5),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // const SizedBox(
                                  //   height: 3,
                                  // ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        "${snap.data!.docs[index].data()["name product"]}",
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 20,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        r'$'
                                        "${snap.data!.docs[index].data()["price"]}",
                                        style: const TextStyle(
                                            fontSize: 16, color: Colors.red),
                                      ),
                                    ],
                                  ),
                                  // const SizedBox(
                                  //   height: ,
                                  // ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          right: 0,
                          left: 0,
                          top: -50,
                          child: Image.network(
                            "${snap.data!.docs[index].data()["imageLink"]}",
                            height: 150,
                            width: double.infinity,
                            // fit: BoxFit.cover,
                          ),
                        )
                      ],
                    ),
                  );
                  // return Padding(
                  //   padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
                  //   child: Card(
                  //     color: backgroundColor,
                  //     margin: const EdgeInsets.symmetric(vertical: 4),
                  //     child: Padding(
                  //       padding: const EdgeInsets.all(15.0),
                  //       child: Row(
                  //         // mainAxisAlignment: MainAxisAlignment.,
                  //         children: [
                  //           CircleAvatar(
                  //             radius: 40,
                  //             child: Image.asset('assets/images/images.png'),
                  //           ),
                  //           const SizedBox(
                  //             width: 12,
                  //           ),
                  //           Column(
                  //             crossAxisAlignment: CrossAxisAlignment.start,
                  //             mainAxisAlignment: MainAxisAlignment.start,
                  //             children: [
                  //               Text(
                  //                 "${snap.data!.docs[index].data()["name"]}",
                  //                 style:
                  //                     const TextStyle(fontWeight: FontWeight.w900),
                  //                 // style: Theme.of(context).textTheme.titleMedium,
                  //               ),
                  //               TextButton(
                  //                 child: Text(
                  //                   "${snap.data!.docs[index].data()["email"]}",
                  //                   style: const TextStyle(
                  //                       color: Color.fromARGB(255, 134, 134, 134),
                  //                       fontSize: 20),
                  //                 ),
                  //                 // style: Theme.of(context).textTheme.titleMedium,
                  //                 onPressed: () async {
                  //                   final Uri emailUri = Uri(
                  //                     scheme: 'mailto',
                  //                     path:
                  //                         ':${snap.data!.docs[index].data()["email"]}', // أضف البريد الإلكتروني هنا
                  //                   );
                  //                   if (await canLaunch(emailUri.toString())) {
                  //                     await launch(emailUri.toString());
                  //                   } else {
                  //                     throw 'لا تمتلك بطيق ال email';
                  //                   }
                  //                 },
                  //               ),
                  //               TextButton(
                  //                 child: Text(
                  //                   "${snap.data!.docs[index].data()["numberphone"]}",
                  //                   style: const TextStyle(
                  //                       color: Color.fromARGB(255, 134, 134, 134),
                  //                       fontSize: 20),
                  //                 ),
                  //                 // style: Theme.of(context).textTheme.titleMedium,
                  //                 onPressed: () async {
                  //                   final Uri phoneUri = Uri(
                  //                     scheme: 'tel',
                  //                     path:
                  //                         "${snap.data!.docs[index].data()["numberphone"]}", // أضف رقم الهاتف هنا
                  //                   );
                  //                   launch(phoneUri.toString());
                  //                 },
                  //               ),
                  //             ],
                  //           ),
                  //         ],
                  //       ),
                  //     ),
                  //   ),
                  // );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
