import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  Future<Position>? position;
  String myPosition = '';

  @override
  void initState() {
    super.initState();
    position = getPosition();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Current Location')),
      body: Center(
        child: FutureBuilder<Position>(
          future: position,
          builder: (BuildContext context, AsyncSnapshot<Position> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.connectionState == ConnectionState.done) {
              // Menambahkan pengecekan error
              if (snapshot.hasError) {
                return const Text('Something terrible happened!');
              }
              // Jika posisi berhasil didapatkan, tampilkan hasilnya
              return Text(
                'Latitude: ${snapshot.data!.latitude} - Longitude: ${snapshot.data!.longitude}',
                style: const TextStyle(fontSize: 16),
              );
            } else {
              return const Text('Error fetching location');
            }
          },
        ),
      ),
    );
  }



    // final myWidget = myPosition == ''
    //     ? const CircularProgressIndicator()
    //     : Text(myPosition);
    //
    // return Scaffold(
    //   appBar: AppBar(title: const Text('Current Location')),
    //   body: Center(child:myWidget),
    // );
  Future<Position> getPosition() async {
    await Geolocator.isLocationServiceEnabled();
    await Future.delayed(const Duration(seconds: 3));
    Position position = await Geolocator.getCurrentPosition();
    return position;
  }





}
