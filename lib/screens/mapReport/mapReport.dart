import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart'; // إضافة الحزمة الجديدة هنا
import 'package:latlong2/latlong.dart';

class MapReport extends StatefulWidget {
  const MapReport({super.key});

  @override
  State<MapReport> createState() => _MapReportState();
}

class _MapReportState extends State<MapReport> {
  final MapController _mapController = MapController();
  List<Marker> markerss = [];
  LatLng? _selectedPoint;
// في مكان مناسب في الكود، قم بتعريف إحداثيات الوسط لمدينة حلب
  final LatLng centerAleppo =
      const LatLng(36.2021, 37.1342); // إحداثيات وسط مدينة حلب

  // الخمس مواقع المبدئية
  final List<LatLng> initialPoints = [
    const LatLng(36.2021, 37.1342), // حلب القديمة
    const LatLng(36.2161, 37.1597), // حلب الجديدة
    const LatLng(36.2245, 37.1629), // حلب الأعظم
    const LatLng(36.1943, 37.1426), // حي الزهراء في حلب
    const LatLng(36.1997, 37.1426), // حي الأزهر في حلب
  ];

  void _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

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
      return Future.error(
          'أذونات الموقع مرفوضة بشكل دائم, نحن لا نستطيع طلب الأذونات.');
    }
    // const MapOptions(
    //   initialZoom: 10.0,
    //   // ...
    // );
    MapOptions(
      initialCenter: centerAleppo,

      // initialCenter: const LatLng(36.2021, 37.1342), // موقع مدينة حلب
      initialZoom: 50.0, // التكبير الابتدائي
      onTap: (tapPosition, point) {
        // _addMarker(point);
        print(point);
      },
    );
    Position position = await Geolocator.getCurrentPosition();
    final userLocation = LatLng(position.latitude, position.longitude);
    _mapController.move(userLocation, 15.0);

    final marker = Marker(
      width: 120.0,
      height: 120.0,
      point: userLocation,
      child: const Column(
        children: [
          Text('مكانك حاليا'),
          Icon(
            Icons.location_on,
            size: 30.0,
            color: Color.fromARGB(255, 73, 54, 244),
          ),
        ],
      ),
    );

    // setState(() {
    //   markerss.add(marker);
    // });
  }

  @override
  void initState() {
    super.initState();
    _determinePosition();

    // إضافة الماركرات الحمراء على الخريطة عند بدء التطبيق
    for (var point in initialPoints) {
      markerss.add(
        Marker(
          width: 100.0,
          height: 100.0,
          point: point,
          child: const Icon(Icons.location_pin, color: Colors.red),
        ),
      );
    }
  }

  void _addMarker(LatLng point) {
    setState(() {
      markerss.add(
        Marker(
          width: 100.0,
          height: 100.0,
          point: point,
          child: const Icon(
            Icons.location_pin,
            color: Colors.red,
            size: 40,
          ),
        ),
      );
      _selectedPoint = point;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: FlutterMap(
              mapController: _mapController,
              options: MapOptions(
                initialCenter: centerAleppo,
                initialZoom: 13.0,
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
        ],
      ),
    );
  }
}
