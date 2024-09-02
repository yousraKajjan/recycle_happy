import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:recycle_happy_custom/constant/constants.dart';
import 'package:recycle_happy_custom/screens/reverse/add/newReserve.dart';
import 'package:recycle_happy_custom/widgets/my_button_widget.dart';

class ReverseUser extends StatefulWidget {
  const ReverseUser({super.key});

  @override
  State<ReverseUser> createState() => _ReverseUserState();
}

class _ReverseUserState extends State<ReverseUser> {
  // Future<QuerySnapshot<Map<String, dynamic>>?>? initData() async {
  //   if (FirebaseAuth.instance.currentUser != null) {
  //     return FirebaseFirestore.instance.collection("Report").where().get();
  //     // return null;
  //   }
  //   return null;
  // }
  Future<void> deleteReverse(String ReverseId) async {
    FirebaseFirestore.instance
        .collection('orders')
        .doc(ReverseId)
        .delete()
        .then((_) => print("Revers has been deleted"))
        .catchError((error) => print("Failed to delete Report: $error"));
  }

  Future<QuerySnapshot<Map<String, dynamic>>?>? initData() async {
    var currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      return FirebaseFirestore.instance
          .collection("orders")
          .where("idUser", isEqualTo: currentUser.uid)
          .get();
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('طلباتي'),
      ),
      body: FutureBuilder(
        future: initData(),
        builder: (context, snap) {
          if (snap.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snap.data?.docs.isEmpty ?? false) {
            print('empty data');
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.report,
                    size: 60,
                    color: Colors.yellow,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(" لايوجد لديك طلبات  "),
                  const SizedBox(
                    height: 5,
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const NewReverseScreen(),
                        ),
                      );

                      // Navigator.pushReplacementNamed(
                      //     context, '/NewReverseScreen');
                      //عند استخدام pushReplacementNamed،
                      //سيتم الانتقال إلى الصفحة '/NewReverseScreen' وإزالة الصفحة الحالية من المكدس بحيث لا تظهر الصفحة الحالية عند
                      // الضغط
                      //على زر
                      // العودة.

                      // Navigator.of(context).pushReplacement(
                      //   MaterialPageRoute(
                      //     builder: (context) =>
                      //         const (), // استبدل بالشاشة التي تريد الانتقال إليها
                      //   ),
                      // );
                    },
                    child: const Text('اطلب الان'),
                  ),
                ],
              ),
            );
          }
          if (snap.hasError) return const Text("Something has error");
          if (snap.data == null) {
            print('empty data');
            const Text("Empty data");
          }

          return ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 7),
            itemCount: snap.data?.docs.length ?? 0,
            itemBuilder: (context, index) {
              return Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 5.0),
                    child: InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, '/item-reverse',
                            arguments: [
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
                      child: SizedBox(
                        height: 180,
                        child: Card(
                          clipBehavior: Clip.antiAlias,
                          color: backgroundColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(45),
                                bottomRight: Radius.circular(5),
                                topLeft: Radius.circular(5),
                                topRight: Radius.circular(45)),
                            side: BorderSide(
                              color: '${snap.data!.docs[index].data()["statusReverse"]}' ==
                                      '0'
                                  ? pendingColor
                                  : '${snap.data!.docs[index].data()["statusReverse"]}' ==
                                          '1'
                                      ? acceptColor
                                      : '${snap.data!.docs[index].data()["statusReverse"]}' ==
                                              '2'
                                          ? rejectColor
                                          : doneColor, // لون الحدود
                              // width: 2.0, // عرض الحدود
                            ),
                          ),
                          margin: const EdgeInsets.symmetric(vertical: 4),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(0.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(Icons.shopping_cart,
                                              color: '${snap.data!.docs[index].data()["statusReverse"]}' ==
                                                      '0'
                                                  ? pendingColor
                                                  : '${snap.data!.docs[index].data()["statusReverse"]}' ==
                                                          '1'
                                                      ? acceptColor
                                                      : '${snap.data!.docs[index].data()["statusReverse"]}' ==
                                                              '2'
                                                          ? rejectColor
                                                          : doneColor),
                                          Text(
                                            "${snap.data!.docs[index].data()["name product"]}",
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Icon(Icons.location_on,
                                              color: '${snap.data!.docs[index].data()["statusReverse"]}' ==
                                                      '0'
                                                  ? pendingColor
                                                  : '${snap.data!.docs[index].data()["statusReverse"]}' ==
                                                          '1'
                                                      ? acceptColor
                                                      : '${snap.data!.docs[index].data()["statusReverse"]}' ==
                                                              '2'
                                                          ? rejectColor
                                                          : doneColor),
                                          SizedBox(
                                            width: 200,
                                            child: Text(
                                              "${snap.data!.docs[index].data()["Adress"]}",
                                              maxLines: 1,
                                              softWrap: true,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
                                      ),
                                      '${snap.data!.docs[index].data()["statusReverse"]}' ==
                                              '0'
                                          ? const Row(
                                              children: [
                                                Icon(
                                                  Icons.info,
                                                  color: pendingColor,
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Text(
                                                  'الطلب قيد الانتظار',
                                                  style: TextStyle(
                                                      color: pendingColor,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            )
                                          : '${snap.data!.docs[index].data()["statusReverse"]}' ==
                                                  '1'
                                              ? const Row(
                                                  children: [
                                                    Icon(
                                                      color: acceptColor,
                                                      Icons
                                                          .check_circle_outline_rounded,
                                                    ),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    Text(
                                                      'تم قبول  الطلب',
                                                      style: TextStyle(
                                                          color: acceptColor,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ],
                                                )
                                              : '${snap.data!.docs[index].data()["statusReverse"]}' ==
                                                      '2'
                                                  ? const Row(
                                                      children: [
                                                        Icon(
                                                          color: rejectColor,
                                                          Icons.clear,
                                                        ),
                                                        SizedBox(
                                                          width: 5,
                                                        ),
                                                        Text(
                                                          'تم رفض  الطلب',
                                                          style: TextStyle(
                                                              color:
                                                                  rejectColor,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ],
                                                    )
                                                  : const Row(
                                                      children: [
                                                        Icon(
                                                          Icons.done_all,
                                                          color: doneColor,
                                                        ),
                                                        SizedBox(
                                                          width: 5,
                                                        ),
                                                        // Text(
                                                        //   'تم الرش',
                                                        //   style: TextStyle(
                                                        //       color: doneColor,
                                                        //       fontWeight:
                                                        //           FontWeight.bold),
                                                        // ),
                                                      ],
                                                    ),
                                      '${snap.data!.docs[index].data()["statusReverse"]}' ==
                                              '0'
                                          ? Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                const SizedBox(
                                                  width: 27,
                                                ),
                                                ButtonWidget(
                                                    side: const BorderSide(
                                                        color: Colors.orange),
                                                    colorIcon: Colors.orange,
                                                    colorText: Colors.orange,
                                                    // backgroundColors: Colors.grey,
                                                    icon: Icons.edit,
                                                    onPressed: () {
                                                      Navigator.pushNamed(
                                                        context,
                                                        '/edit-reverse',
                                                        arguments: [
                                                          '${snap.data!.docs[index].data()["id"]}',
                                                          '${snap.data!.docs[index].data()["name product"]}',
                                                          '${snap.data!.docs[index].data()["Adress"]}',
                                                          '${snap.data!.docs[index].data()["price"]}',
                                                          '${snap.data!.docs[index].data()["imageLink"]}'
                                                        ],
                                                      );
                                                      print(snap
                                                          .data!.docs[index]
                                                          .data()["id"]);
                                                    },
                                                    child: 'تعديل'),
                                                const SizedBox(
                                                  width: 15,
                                                ),
                                                ButtonWidget(
                                                    side: const BorderSide(
                                                        color: Colors.red),
                                                    colorIcon: Colors.red,
                                                    icon: Icons.delete,
                                                    colorText: Colors.red,
                                                    onPressed: () {
                                                      setState(() {
                                                        deleteReverse(snap.data!
                                                            .docs[index].id);
                                                      });
                                                      print(snap.data!
                                                          .docs[index].id);
                                                    },
                                                    child: 'حذف'),
                                              ],
                                            )
                                          : const Padding(
                                              padding: EdgeInsets.all(0),
                                            ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    // right: 0,
                    left: 6,
                    top: 12,
                    child: Container(
                      // width: 100,
                      padding: const EdgeInsets.all(5),
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        color: '${snap.data!.docs[index].data()["statusReverse"]}' ==
                                '0'
                            ? pendingColor
                            : '${snap.data!.docs[index].data()["statusReverse"]}' ==
                                    '1'
                                ? acceptColor
                                : rejectColor,
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(5),
                          topLeft: Radius.circular(5),
                          topRight: Radius.circular(20),
                        ),
                      ),

                      // minWidth: 50,
                      // height: 40,
                      child: '${snap.data!.docs[index].data()["statusReverse"]}' ==
                              '0'
                          ? const Padding(
                              padding: EdgeInsets.all(2.0),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.info,
                                    color: Colors.white,
                                  ),
                                  // SizedBox(
                                  //   width: 10,
                                  // ),
                                  Text(
                                    'منتظر',
                                    style: TextStyle(
                                      color: Colors.white,
                                      // fontWeight: FontWeight.bold
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : '${snap.data!.docs[index].data()["statusReverse"]}' ==
                                  '1'
                              ? const Padding(
                                  padding: EdgeInsets.all(2.0),
                                  child: Row(
                                    children: [
                                      Icon(
                                        color: Colors.white,
                                        Icons.check_circle_outline_rounded,
                                      ),
                                      // SizedBox(
                                      //   width: 10,
                                      // ),
                                      Text(
                                        'مقبول',
                                        style: TextStyle(
                                          color: Colors.white,
                                          // fontWeight: FontWeight.bold
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              : const Padding(
                                  padding: EdgeInsets.all(2.0),
                                  child: Row(
                                    children: [
                                      Icon(
                                        color: Colors.white,
                                        Icons.clear,
                                      ),
                                      // SizedBox(
                                      //   width: 10,
                                      // ),
                                      Text(
                                        'مرفوض',
                                        style: TextStyle(
                                          color: Colors.white,
                                          // fontWeight: FontWeight.bold
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                    ),
                  ),
                ],
              );
            },
          );
          // return ListView.builder(
          //   padding: const EdgeInsets.symmetric(horizontal: 16),
          //   itemCount: snap.data?.docs.length ?? 0,
          //   itemBuilder: (context, index) {
          //     return Card(
          //       margin: const EdgeInsets.symmetric(vertical: 4),
          //       child: Padding(
          //         padding: const EdgeInsets.all(8.0),
          //         child: Row(
          //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //           children: [
          //             Column(
          //               crossAxisAlignment: CrossAxisAlignment.start,
          //               mainAxisAlignment: MainAxisAlignment.center,
          //               children: [
          //                 Text(
          //                   "نوع الحشرة: ${snap.data!.docs[index].data()["Type Insect"]}",
          //                   // style: Theme.of(context).textTheme.titleMedium,
          //                 ),
          //                 Text(
          //                   "عنوان المكان الذي نتنشر فيه الحشرة \n: ${snap.data!.docs[index].data()["Adress"]}",
          //                   // style: Theme.of(context).textTheme.titleMedium,
          //                 ),
          //                 '${snap.data!.docs[index].data()["statusReverse"]}' ==
          //                         '0'
          //                     ? const Row(
          //                         children: [
          //                           Icon(Icons.timelapse_outlined),
          //                           Text('الحجز قيد الانتظار')
          //                         ],
          //                       )
          //                     : '${snap.data!.docs[index].data()["statusReverse"]}' ==
          //                             '1'
          //                         ? const Row(
          //                             children: [
          //                               Icon(
          //                                   Icons.check_circle_outline_rounded),
          //                               Text('تم قبول الحجز')
          //                             ],
          //                           )
          //                         : const Row(
          //                             children: [
          //                               Icon(Icons.clear),
          //                               Text('تم رفض الحجز'),
          //                             ],
          //                           ),
          //                 Row(
          //                   mainAxisAlignment: MainAxisAlignment.center,
          //                   children: [
          //                     ButtonWidget(
          //                       side: const BorderSide(
          //                           color: pendingColor,
          //                           style: BorderStyle.solid),
          //                       icon: Icons.edit,
          //                       colorIcon: pendingColor,
          //                       colorText: pendingColor,
          //                       child: "تعديل  ",
          //                       onPressed: () {
          //                         Navigator.pushNamed(
          //                           context,
          //                           '/EditInstarctionScreen',
          //                           arguments: [
          //                             '${snap.data!.docs[index].data()["id"]}',
          //                             '${snap.data!.docs[index].data()["Adress"]}',
          //                             '${snap.data!.docs[index].data()["Details Instraction"]}',
          //                             '${snap.data!.docs[index].data()["imageLink"]}'
          //                           ],
          //                         );
          //                         print(
          //                             '${snap.data!.docs[index].data()["id"]}');
          //                       },
          //                     ),
          //                     const SizedBox(
          //                       width: 15,
          //                     ),
          //                     ButtonWidget(
          //                       side: const BorderSide(
          //                           style: BorderStyle.solid,
          //                           color: rejectColor),
          //                       icon: Icons.delete,
          //                       colorIcon: rejectColor,
          //                       colorText: rejectColor,
          //                       child: "حذف ",
          //                       onPressed: () {
          //                         setState(() {});
          //                         deleteReverse(
          //                             '${snap.data!.docs[index].data()["id"]}');
          //                         print(
          //                             '${snap.data!.docs[index].data()["id"]}');
          //                       },
          //                     ),
          //                   ],
          //                 ),
          //               ],
          //             ),
          //           ],
          //         ),
          //       ),
          //     );
          //   },
          // );
        },
      ),
    );
  }
}
