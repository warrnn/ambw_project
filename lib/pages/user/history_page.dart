import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:telehealth/components/visit_history_card.dart';
import 'package:telehealth/service/visit_ticket_service.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  Future<void> _refresh() async {
    setState(() {});
  }

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
      body: RefreshIndicator(
        color: Colors.blue,
        backgroundColor: Colors.white,
        onRefresh: _refresh,

        child: Container(
          color: Colors.white,
          height: double.infinity,
          child: SafeArea(
            child: FutureBuilder(
              future: VisitTicketService().getAllUserVisitTickets(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Center(child: Text("Error: ${snapshot.error}"));
                }

                final visitTickets = snapshot.data ?? [];

                if (visitTickets.isEmpty) {
                  return SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: const Center(
                      heightFactor: 8,
                      child: Text("Belum ada riwayat kunjungan"),
                    ),
                  );
                }

                return SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.symmetric(
                    vertical: 24,
                    horizontal: 4,
                  ),
                  child: Column(
                    children: visitTickets.map((ticket) {
                      return Column(
                        children: [
                          VisitHistoryCard(
                            ticketId: ticket.id!,
                            doctorName: ticket.doctor.name,
                            doctorSpecialization: ticket.doctor.specialization,
                            hospitalName: ticket.doctor.hospital,
                            visitDate: DateFormat(
                              'dd MMMM yyyy',
                              'id_ID',
                            ).format(ticket.visitDate),
                            visitStatus: ticket.status,
                            chiefComplaint: ticket.chiefComplaint,
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
        ),
      ),
    );
  }
}
