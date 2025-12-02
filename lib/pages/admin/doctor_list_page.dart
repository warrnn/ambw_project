import 'package:flutter/material.dart';
import 'package:telehealth/components/doctor_card.dart';
import 'package:telehealth/model/doctor.dart';
import 'package:telehealth/pages/admin/add_doctor_page.dart';
import 'package:telehealth/service/doctor_service.dart';

class DoctorListPage extends StatefulWidget {
  const DoctorListPage({super.key});

  @override
  State<DoctorListPage> createState() => _DoctorListPageState();
}

class _DoctorListPageState extends State<DoctorListPage> {
  late Future<List<Doctor>> futureDoctors;

  @override
  void initState() {
    super.initState();
    futureDoctors = DoctorService().getAllDoctors();
  }

  void reloadDoctors() {
    setState(() {
      futureDoctors = DoctorService().getAllDoctors();
    });
  }

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
                onPressed: () async {
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const AddDoctorPage()),
                  );
                  if (result == true) {
                    reloadDoctors();
                  }
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
              child: FutureBuilder(
                future: futureDoctors,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.hasError) {
                    return Center(child: Text("Error: ${snapshot.error}"));
                  }

                  final doctors = snapshot.data ?? [];

                  if (doctors.isEmpty) {
                    return const Center(
                      child: Text("Belum ada dokter yang ditambahkan."),
                    );
                  }

                  return SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: doctors.map((doctor) {
                        return Column(
                          children: [
                            DoctorCard(
                              id: doctor.id.toString(),
                              name: doctor.name,
                              specialist: doctor.specialization,
                              hospital: doctor.hospital,
                              imageUrl: doctor.photoUrl ?? "",
                              onDeleted: reloadDoctors,
                            ),
                            const SizedBox(height: 16),
                          ],
                        );
                      }).toList(),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
