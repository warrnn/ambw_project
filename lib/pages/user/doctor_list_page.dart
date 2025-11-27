import 'package:flutter/material.dart';
import 'package:telehealth/components/doctor_list_card.dart';

class DoctorListPage extends StatefulWidget {
  const DoctorListPage({super.key});

  @override
  State<DoctorListPage> createState() => _DoctorListPageState();
}

class _DoctorListPageState extends State<DoctorListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        shadowColor: Colors.black26,
        centerTitle: true,
        title: const Text(
          "Daftar Dokter",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(color: Colors.white),
        child: SafeArea(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            padding: EdgeInsets.all(24.0),
            child: Column(
              children: [
                for (int i = 0; i < 10; i++)
                  Column(
                    children: [
                      DoctorListCard(
                        "https://static.vecteezy.com/system/resources/thumbnails/026/375/249/small/ai-generative-portrait-of-confident-male-doctor-in-white-coat-and-stethoscope-standing-with-arms-crossed-and-looking-at-camera-photo.jpg",
                        "Dr. Tirta ${i + 1}",
                        "Spesialis Sakit Hati",
                        "National Hospital",
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
