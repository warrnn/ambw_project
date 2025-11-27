import 'package:flutter/material.dart';
import 'package:telehealth/components/doctor_list_card.dart';
import 'package:telehealth/components/home_visit_schedule_card.dart';
import 'package:telehealth/components/visit_history_card.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
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
          "Riwayat Kunjungan",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(color: Colors.white),
        child: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.all(24.0),
            child: Column(
              children: [
                VisitHistoryCard(
                  doctorName: "Dr. Tirta",
                  doctorSpecialization: "Spesialis Penyakit Dalam",
                  hospitalName: "National Hospital",
                  visitDate: "01 Januari 2025",
                  visitTime: "08:00",
                  visitStatus: "Dikonfirmasi",
                  chiefComplaint: "Sakit perut",
                ),
                SizedBox(height: 16),
                VisitHistoryCard(
                  doctorName: "Dr. Tirta",
                  doctorSpecialization: "Spesialis Penyakit Dalam",
                  hospitalName: "National Hospital",
                  visitDate: "01 Januari 2025",
                  visitTime: "08:00",
                  visitStatus: "Pending",
                  chiefComplaint: "Sakit perut",
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
