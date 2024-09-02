import 'package:flutter/material.dart';

// const Color pColor = Color.fromARGB(255, 10, 200, 242);
const Color pColor = Color(0xFF03A9F4);
// const Color sColor = Color.fromARGB(255, 33, 212, 243);
const Color backgroundColor = Colors.white;
const Color cardbackground = Color.fromARGB(255, 240, 237, 237);
// const Color rejectColor = Colors.blue;
// const Color pendingColor = Color.fromARGB(255, 163, 209, 247);
// const Color acceptColor = Color(0xFF00CED1);
const Color acceptColor = Color(0xFF00CED1);
const Color pendingColor = Color.fromARGB(218, 3, 168, 244);
const Color rejectColor = Color(0xFF448aff);

// const Color rejectColor = Colors.red;
// const Color pendingColor = Colors.orange;
// const Color acceptColor = Colors.green;
const Color doneColor = Colors.pink;
const Color backgroundColorIamge = Color.fromARGB(60, 126, 125, 125);
const Color backgroundColorIamgeText = Colors.green;

// Color getStatusColor(int statusReport) {
//   if (statusReport == 0) {
//     return Colors.orange;
//   } else if (statusReport == 1) {
//     return Colors.green;
//   } else {
//     return Colors.red;
//   }
// }

Color getStatusReverseColor(int statusReverse) {
  if (statusReverse == 0) {
    return pendingColor;
  } else if (statusReverse == 1) {
    return acceptColor;
  } else {
    if (statusReverse == 2) {
      return rejectColor;
    }
    return Colors.pink;
  }
}

// AppBar buildAppBar({final String? title}) {
//   return AppBar(
//     leading: Center(
//       child: SvgPicture.asset(
//         'assets/images/arrow.svg',
//         height: 15,
//       ),
//     ),
//     elevation: 0,
//     backgroundColor: Colors.transparent,
//     centerTitle: true,
//     title: Text(
//       title ?? '',
//       textAlign: TextAlign.center,
//       style: Styles.style25,
//     ),
//   );
// }
