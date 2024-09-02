import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:recycle_happy_custom/constant/constants.dart';
import 'package:recycle_happy_custom/screens/AllProducts/AllProducts.dart';
import 'package:recycle_happy_custom/screens/instructions/instructions.dart';
import 'package:recycle_happy_custom/screens/mapReport/mapReport.dart';
import 'package:recycle_happy_custom/screens/reverse/add/newReserve.dart';
import 'package:url_launcher/url_launcher.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  List<Widget> screens = [
    const MapReport(),
    // const MapScreen(),
    // const NewReportScreen(),
    const NewReverseScreen(),
    const Allproducts(),
    const InstructionScreen(),
  ];
  int currentIndex = 0;
  Future<DocumentSnapshot<Map<String, dynamic>>?>? initName() async {
    if (FirebaseAuth.instance.currentUser != null) {
      print(FirebaseAuth.instance.currentUser!.uid);
      return await FirebaseFirestore.instance
          .collection("users")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: currentIndex == 0
            ? const Text('المواقع الادارية ')
            : currentIndex == 1
                ? const Text('طلب جديد')
                : currentIndex == 2
                    ? const Text('كل المنتجات')
                    : const Text('نصائح توعوية'),
        leading: IconButton(
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer();
          },
          icon: const Icon(Icons.menu),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          // padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                  // color: backgroundColor,
                  ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.transparent, // لجعل الخلفية شفافة
                    child: ClipOval(
                      child: Image.asset(
                        'assets/images/images (1).png',
                        // color: Colors.transparent,
                        fit: BoxFit.cover, // لتغطية الدائرة بالصورة
                      ),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FutureBuilder(
                        future: initName(),
                        builder: (context, snap) {
                          if (snap.connectionState == ConnectionState.waiting) {
                            return const CircularProgressIndicator();
                          }
                          if (snap.hasError) {
                            return const Text("Something has error");
                          }
                          if (snap.data == null) {
                            return const Text("Empty data");
                          }
                          print(snap.data?.data());
                          return Text(
                            "${snap.data?.data()?["name"]}",
                            style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: pColor),
                          );
                        },
                      ),
                      FutureBuilder(
                        future: initName(),
                        builder: (context, snap) {
                          if (snap.connectionState == ConnectionState.waiting) {
                            return const CircularProgressIndicator();
                          }
                          if (snap.hasError) {
                            return const Text("Something has error");
                          }
                          if (snap.data == null) {
                            return const Text("Empty data");
                          }
                          print(snap.data?.data());
                          return Text(
                            "${snap.data?.data()?["email"]}",
                            style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: pColor),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('الرئيسية'),
              onTap: () {
                Navigator.pushNamed(context, '/home');
              },
            ),
            ListTile(
              leading: const Icon(Icons.timelapse_sharp),
              title: const Text('طلباتي'),
              onTap: () {
                Navigator.pushNamed(context, '/ReverseUser');
              },
            ),
            // ListTile(
            //   leading: const Icon(Icons.menu_outlined),
            //   title: const Text('بلاغاتي'),
            //   onTap: () {
            //     Navigator.pushNamed(context, '/ReportUser');
            //   },
            // ),
            ListTile(
              leading: const Icon(Icons.phone),
              title: const Text('طلب عبر اتصال'),
              onTap: () {
                final Uri phoneUri = Uri(
                  scheme: 'tel',
                  path: '+963 932374698', // أضف رقم الهاتف هنا
                );
                launch(phoneUri.toString());
              },
            ),
            ListTile(
              leading: const Icon(Icons.email),
              title: const Text('طلب عبر البريد الاكتروني '),
              onTap: () async {
                final Uri emailUri = Uri(
                  scheme: 'mailto',
                  path: 'y7752640@gmail.com', // أضف البريد الإلكتروني هنا
                );
                if (await canLaunch(emailUri.toString())) {
                  await launch(emailUri.toString());
                } else {
                  throw 'Could not launch email';
                }
              },
            ),
            ListTile(
              leading: const Icon(Icons.facebook),
              title: const Text('طلب عبر  الفيس بوك '),
              onTap: () {
                final Uri facebookUri = Uri(
                  scheme: 'https', // أو 'fb' لفتح التطبيق مباشرة إذا توفر
                  host: 'www.facebook.com',
                  path:
                      'https://www.facebook.com/zuhoor.kjj', // استبدل بإسم الصفحة أو الملف الشخصي
                );

                launch(facebookUri.toString());
              },
            ),
            ListTile(
              leading: const Icon(Icons.language),
              title: const Text('اللغة '),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.perm_device_information),
              title: const Text('عن التطبيق  '),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.logout_outlined),
              title: const Text('تسجيل الخروج '),
              onTap: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.of(context).pushReplacementNamed("/");
              },
            ),
          ],
        ),
      ),
      body: screens[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: pColor,
        selectedIconTheme: const IconThemeData(color: pColor),
        currentIndex: currentIndex,

        // height: 50, color: Colors.white,
        // backgroundColor: Colors.blueAccent,
        // animationCurve: Curves.easeInOut,
        // buttonBackgroundColor: Colors.transparent,
        backgroundColor: Colors.white,
        // letIndexChange: (value) {
        //   return true;
        // },
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(
                Icons.map_outlined,
                size: 30,
                // color: Color.fromARGB(248, 111, 234, 146),
              ),
              label: 'المواقع الادارية'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.add_alert_outlined,
                size: 30,
                // color: Color.fromARGB(248, 111, 234, 146),
              ),
              label: 'طلب جديد'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.production_quantity_limits_outlined,
                size: 30,
                // color: Color.fromARGB(248, 111, 234, 146),
              ),
              label: 'كل المنتجات '),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.menu,
                size: 30,
                // color: Color.fromARGB(248, 111, 234, 146),
              ),
              label: 'تعليمات'),
        ],

        onTap: (index) {
          setState(
            () {
              currentIndex = index;
            },
          );
        },
      ),
      // body: _pages[_page],
    );
    // bottomNavigationBar: BottomNavigationBar(
    //   onTap: (value) {
    //     setState(() {});
    //     currentIndex = value;
    //   },
    //   currentIndex: currentIndex,
    //   items: const [
    //     BottomNavigationBarItem(
    //         icon: Icon(
    //           Icons.add,
    //         ),
    //         label: 'بلاغ جديد'),
    //     BottomNavigationBarItem(
    //         icon: Icon(
    //           Icons.playlist_add_circle_sharp,
    //         ),
    //         label: 'حجز جديد'),
    //     BottomNavigationBarItem(
    //         icon: Icon(
    //           Icons.menu,
    //         ),
    //         label: 'إرشادات '),
    //   ],
    // ),
    // );
  }
}
