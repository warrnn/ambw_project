import 'package:flutter/material.dart';
import 'package:telehealth/components/doctor_card.dart';
import 'package:telehealth/pages/admin/add_doctor_page.dart';

class DoctorListPage extends StatelessWidget {
  const DoctorListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        shadowColor: Colors.black26,
        centerTitle: true,
        title: const Text("List Dokter", style: TextStyle(color: Colors.black)),
      ),
      backgroundColor: const Color(0xFFF1F8FF),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AddDoctorPage(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1E88E5),
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: const Text(
                  "Tambah Dokter",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),

            const SizedBox(height: 20),

            Expanded(
              child: ListView(
                children: const [
                  DoctorCard(
                    name: "Dr. Sarah Williams",
                    specialist: "Spesialis Jantung",
                    hospital: "RS Sehat Sentosa",
                    imageUrl:
                        "https://randomuser.me/api/portraits/women/44.jpg",
                  ),
                  SizedBox(height: 12),
                  DoctorCard(
                    name: "Dr. John Doe",
                    specialist: "Spesialis Kulit",
                    hospital: "RS Medikarsa",
                    imageUrl: "https://randomuser.me/api/portraits/men/41.jpg",
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
