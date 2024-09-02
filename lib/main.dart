import 'package:bot_toast/bot_toast.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:recycle_happy_custom/auth/login.dart';
import 'package:recycle_happy_custom/auth/sign_up.dart';
import 'package:recycle_happy_custom/auth/splash.dart';
import 'package:recycle_happy_custom/constant/constants.dart';
import 'package:recycle_happy_custom/screens/AllProducts/itemproduct.dart';
import 'package:recycle_happy_custom/screens/home/home.dart';
import 'package:recycle_happy_custom/screens/instructions/ItemInsraction.dart';
import 'package:recycle_happy_custom/screens/mapReport/mapReport.dart';
import 'package:recycle_happy_custom/screens/reverse/ReverseUser/ReverseUser.dart';
import 'package:recycle_happy_custom/screens/reverse/add/newReserve.dart';
import 'package:recycle_happy_custom/screens/reverse/edit/editReverseScreen.dart';
import 'package:recycle_happy_custom/screens/reverse/itemReverse.dart';
import 'package:recycle_happy_custom/screens/reverse/mapReveerse/mapReverse.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging.instance.getToken().then(
    (value) {
      print('FcM Valur:$value');
    },
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    FirebaseMessaging.onMessage.listen(
      (RemoteMessage message) {
        // print('Got a message whilst in the foreground!');
        // print('Message data: ${message.data}');
        if (message.notification != null) {
          print(
              'Message also contained a notification: ${message.notification}');
          BotToast.showSimpleNotification(
            title: message.notification!.title ?? '',
            subTitle: message.notification!.body ?? '',
            // duration: const Duration(seconds: 5),
          );
        }
      },
    );
    super.initState();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //Warning: Don't arbitrarily adjust the position of calling the BotToastInit function
    final botToastBuilder = BotToastInit(); //1. call BotToastInit
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      builder: (context, child) {
        child = botToastBuilder(context, child);
        return child;
      },
      navigatorObservers: [BotToastNavigatorObserver()],
      localizationsDelegates: const [
        GlobalCupertinoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale("ar", "AE"), // OR Locale('ar', 'AE') OR Other RTL locales
      ],
      locale: const Locale("ar", "AE"),
      title: 'recycle_happy_custom',
      theme: ThemeData(
        fontFamily: 'Rubik',
        // cardTheme: CardTheme(
        //   shadowColor: Colors.grey,
        //   shape: RoundedRectangleBorder(
        //     borderRadius: BorderRadius.circular(15.0),
        //   ),
        drawerTheme: const DrawerThemeData(
          elevation: 10,
        ),
        listTileTheme: const ListTileThemeData(
            // style: ListTileStyle.list,
            textColor: Colors.black,
            titleTextStyle: TextStyle(fontSize: 20),
            iconColor: pColor),
        cardTheme: CardTheme(
            shadowColor: Colors.grey,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            elevation: 7),
        scaffoldBackgroundColor: backgroundColor,
        primaryColor: backgroundColor,
        //textbutton
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: pColor,
            textStyle: const TextStyle(
              fontSize: 20, // حجم النص
            ),
          ),
        ),
        //text
        textTheme: const TextTheme(
          bodyMedium: TextStyle(
            color: Colors.black,
            fontSize: 23,
          ),
          // bodyLarge: TextStyle(color: pColor),
          // bodySmall: TextStyle(color: pColor),
        ),
        //appbar theme
        appBarTheme: const AppBarTheme(
          iconTheme: IconThemeData(color: pColor),
          backgroundColor: Colors.transparent,
          elevation: 0,
          // color: pColor,
          titleTextStyle: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontFamily: 'Rubik',
          ),
          centerTitle: true,
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarBrightness: Brightness.light,
            statusBarIconBrightness: Brightness.dark,
            statusBarColor: Colors.white24,
          ),
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          selectedItemColor: Colors.green,
          unselectedItemColor: Colors.black,
          elevation: 4,
          selectedIconTheme: IconThemeData(
            color: Colors.orange,
          ),
        ),
        //icon theme
        iconTheme: const IconThemeData(color: pColor),
        //inuprtdecoration theme
        inputDecorationTheme: const InputDecorationTheme(
          enabledBorder: OutlineInputBorder(
            // تعريف حاشية الحقل المفعل
            borderSide: BorderSide(color: pColor),
            // تعيين لون الحاشية
            gapPadding: 2,
          ),
          focusedBorder:
              OutlineInputBorder(borderSide: BorderSide(color: pColor)),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/home': (context) => const MyHomePage(),
        '/login': (context) => const LoginScreen(),
        '/signup': (context) => const SignUpScreen(),
        '/ReverseUser': (context) => const ReverseUser(),
        // '/ReportUser': (context) => const ReportUser(),
        '/MapReport': (context) => const MapReport(),
        '/MapReverse': (context) => const MapReverse(),
        '/NewReverseScreen': (context) => const NewReverseScreen(),
        '/item-instraction': (context) => const ItemInstraction(),
        '/item-reverse': (context) => const ItemeReverse(),
        '/item-prodcut': (context) => const ItemProduct(),
        '/edit-reverse': (context) => const EditReverseScreen(),
      },
    );
  }
}
