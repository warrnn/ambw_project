import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:telehealth/authentication/auth_service.dart';
import 'package:telehealth/components/home_visit_schedule_card.dart';
import 'package:telehealth/components/menu_card.dart';
import 'package:telehealth/pages/user/doctor_list_page.dart';
import 'package:telehealth/pages/user/history_page.dart';
import 'package:telehealth/pages/user/profile_page.dart';
import 'package:telehealth/service/visit_ticket_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final authService = AuthService();

  void goToDoctorListPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const DoctorListPage()),
    );
  }

  void goToHistoryPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const HistoryPage()),
    );
  }

  void goToProfilePage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ProfilePage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(bottom: 40),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.blue, Colors.lightBlue],
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(32),
                bottomRight: Radius.circular(32),
              ),
            ),
            child: SafeArea(
              bottom: false,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 20,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Selamat Datang,',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              authService
                                      .client()
                                      .auth
                                      .currentUser
                                      ?.userMetadata?['full_name'] ??
                                  'User',
                              style: const TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white24,
                          ),
                          child: const Icon(
                            Icons.person,
                            color: Colors.white,
                            size: 24,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MenuCard(
                        Icons.medical_services_outlined,
                        'Daftar\nDokter',
                        onTap: () => goToDoctorListPage(context),
                      ),
                      MenuCard(
                        Icons.history,
                        'Riwayat\nKunjungan',
                        onTap: () => goToHistoryPage(context),
                      ),
                      MenuCard(
                        Icons.person_outlined,
                        'Profil\nSaya',
                        onTap: () => goToProfilePage(context),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Janji Temu Mendatang',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                  Expanded(
                    child: FutureBuilder(
                      future: VisitTicketService()
                          .getAllPendingUserVisitTickets(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }

                        if (snapshot.hasError) {
                          return Center(
                            child: Text("Error: ${snapshot.error}"),
                          );
                        }

                        final pendingVisitTickets = snapshot.data ?? [];

                        return SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          child: Column(
                            children: pendingVisitTickets.map((ticket) {
                              return HomeVisitScheduleCard(
                                doctorName: ticket.doctor.name,
                                doctorSpecialization: ticket.doctor.specialization,
                                hospitalName: ticket.doctor.hospital,
                                visitDate: DateFormat('d MMMM yyyy', 'id_ID').format(ticket.visitDate),
                                visitStatus: ticket.status,
                                chiefComplaint: ticket.chiefComplaint,
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
          ),
        ],
      ),
    );
  }
}
