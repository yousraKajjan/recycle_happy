import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart'; // إضافة الحزمة الجديدة هنا
import 'package:latlong2/latlong.dart';
import 'package:recycle_happy_custom/widgets/message.dart';
import 'package:recycle_happy_custom/widgets/my_button_widget.dart';

class MapReverse extends StatefulWidget {
  const MapReverse({super.key});

  @override
  State<MapReverse> createState() => _MapReverseState();
}

class _MapReverseState extends State<MapReverse> {
  final MapController _mapController = MapController();
  List<Marker> markerss = [];
  LatLng? _selectedPoint; // متغير لحفظ النقطة المختارة
  void _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // تحقق مما إذا كانت خدمات الموقع مفعلة
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('خدمات الموقع معطلة');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('أذونات الموقع مرفوضة');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // أذونات الموقع مرفوضة بشكل دائم
      return Future.error(
          'أذونات الموقع مرفوضة بشكل دائم, نحن لا نستطيع طلب الأذونات.');
    }

    // عندما تمت الموافقة على الأذونات: احصل على الموقع الحالي
    Position position = await Geolocator.getCurrentPosition();
    final userLocation = LatLng(position.latitude, position.longitude);
    _mapController.move(userLocation, 15.0); // يمكنك تعديل مستوى التكبير
    final marker = Marker(
      width: 120.0,
      height: 120.0,
      point: userLocation,
      child: const Column(
        children: [
          Text('مكانك حاليا'),
          Icon(
            Icons.location_on,
            // size: 30.0,
            color: Color.fromARGB(255, 73, 54, 244),
          ),
        ],
      ),
    );
    setState(() {
      markerss.add(marker);
    });
  }

  void _addMarker(LatLng point) {
    setState(() {
      markerss.clear();
      markerss.add(
        Marker(
          width: 100.0,
          height: 100.0,
          point: point,
          child: const Icon(Icons.location_pin, color: Colors.red),
        ),
      );
      _selectedPoint = point; // حفظ النقطة المختارة في المتغير
    });

    // هنا يمكنك إضافة التعليمات البرمجية لحفظ النقطة في Firebase
  }

  @override
  void initState() {
    super.initState();
    _determinePosition();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('حدد مكان وجود المنتج بالضبط '),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: FlutterMap(
              mapController: _mapController,
              options: MapOptions(
                initialCenter: const LatLng(35.0,
                    38.0), // تحدد إحداثيات مركز الخريطة لسوريا على سبيل المثال
                initialZoom: 6.0,
                onTap: (tapPosition, point) {
                  _addMarker(point);
                  print(point);
                },
              ),
              children: [
                TileLayer(
                  urlTemplate:
                      'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                  subdomains: const ['a', 'b', 'c'],
                ),
                MarkerLayer(markers: markerss),
              ],
            ),
          ),
          ButtonWidget(
              child: 'التالي',
              onPressed: () {
                if (_selectedPoint != null) {
                  // تأكد من أن هناك نقطة مختارة
                  Navigator.pop(context, _selectedPoint);
                  print(_selectedPoint);
                  // Navigator.pushNamedAndRemoveUntil(
                  //   context,
                  //   '/NewReverseScreen',
                  //   // الصفحة التي ترغب في الانتقال إليها
                  //   ModalRoute.withName(
                  //     '/NewReverseScreen',
                  //   ), // '/HomePage' هو اسم المسار للصفحة التي تريد البقاء في المكدس
                  // );
                  // Navigator.pushNamed(context, '/NewReverseScreen',
                  //     arguments: _selectedPoint
                  //     // MaterialPageRoute(
                  //     //   builder: (context) =>
                  //     //       const NewReverseScreen(), // يجب أن تستبدل هذا بالصفحة الهدف الفعلية
                  //     //   settings: RouteSettings(arguments: _selectedPoint),
                  //     // ),
                  //     );
                } else {
                  // يمكنك إضافة تعليق للمستخدم ليختار نقطة إذا لم يكن قد اختار واحدة بعد
                  print("يرجى اختيار نقطة على الخريطة أولاً.");
                  message(context, 'يرجى اختيار نقطة على الخريطة أولاً');
                }
              }),
        ],
      ),
    );
  }
}
