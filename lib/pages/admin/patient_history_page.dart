import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:developer' as developer;
import 'package:telehealth/components/visit_history_card_admin.dart';
import 'package:telehealth/service/visit_ticket_service.dart';

class PatientHistoryPage extends StatefulWidget {
  const PatientHistoryPage({super.key});

  @override
  State<PatientHistoryPage> createState() => _PatientHistoryPageState();
}

class _PatientHistoryPageState extends State<PatientHistoryPage> {
  final VisitTicketService _service = VisitTicketService();

  List<dynamic> _allTickets = [];
  List<dynamic> _filteredTickets = [];
  bool _loading = true;
  String _selectedFilter = 'Semua Kunjungan';

  @override
  void initState() {
    super.initState();
    developer.log('HistoryAdminPage opened');
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() {
      _loading = true;
    });

    try {
      final tickets = await _service.getAllVisitTickets();
      setState(() {
        _allTickets = tickets;
        _applyFilter();
        _loading = false;
      });
    } catch (e) {
      setState(() {
        _allTickets = [];
        _filteredTickets = [];
        _loading = false;
      });
    }
  }

  void _applyFilter() {
    if (_selectedFilter == 'Semua Kunjungan') {
      _filteredTickets = List.from(_allTickets);
    } else if (_selectedFilter == 'Pending') {
      _filteredTickets = _allTickets.where((t) => t.status == false).toList();
    } else if (_selectedFilter == 'Confirmed') {
      _filteredTickets = _allTickets.where((t) => t.status == true).toList();
    }
  }

  Widget _buildSummaryCard(
    String title,
    int count,
    Color bgColor,
    Color countColor,
  ) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        margin: const EdgeInsets.symmetric(horizontal: 6),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: TextStyle(color: Colors.black54, fontSize: 13)),
            const SizedBox(height: 12),
            Text(
              '$count',
              style: TextStyle(
                color: countColor,
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final total = _allTickets.length;
    final pending = _allTickets.where((t) => t.status == false).length;
    final confirmed = _allTickets.where((t) => t.status == true).length;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        centerTitle: true,
        shadowColor: Colors.black26,
        title: const Text(
          'Riwayat Kunjungan',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Container(
        color: Colors.white,
        height: double.infinity,
        child: SafeArea(
          child: RefreshIndicator(
            onRefresh: _loadData,
            color: Colors.blue,
            backgroundColor: Colors.white,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      _buildSummaryCard(
                        'Total Riwayat',
                        total,
                        Colors.blue.shade50,
                        Colors.blue,
                      ),
                      _buildSummaryCard(
                        'Pending Status',
                        pending,
                        Colors.yellow.shade50,
                        Colors.orange.shade700,
                      ),
                      _buildSummaryCard(
                        'Status Confirmed',
                        confirmed,
                        Colors.green.shade50,
                        Colors.green.shade700,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.filter_list,
                            size: 18,
                            color: Colors.black54,
                          ),
                          const SizedBox(width: 8),
                          const Text(
                            'Filter Status',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: Colors.grey.shade300,
                            width: 1,
                          ),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: _selectedFilter,
                            isExpanded: true,
                            icon: Icon(
                              Icons.arrow_drop_down,
                              color: Colors.grey.shade600,
                            ),
                            items: const [
                              DropdownMenuItem(
                                value: 'Semua Kunjungan',
                                child: Text('Semua Kunjungan'),
                              ),
                              DropdownMenuItem(
                                value: 'Pending',
                                child: Text('Pending'),
                              ),
                              DropdownMenuItem(
                                value: 'Confirmed',
                                child: Text('Confirmed'),
                              ),
                            ],
                            onChanged: (v) {
                              if (v == null) return;
                              setState(() {
                                _selectedFilter = v;
                                _applyFilter();
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  _loading
                      ? const Center(
                          child: Padding(
                            padding: EdgeInsets.only(top: 32),
                            child: CircularProgressIndicator(),
                          ),
                        )
                      : _filteredTickets.isEmpty
                      ? Center(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 40),
                            child: Column(
                              children: const [
                                Icon(
                                  Icons.history,
                                  size: 64,
                                  color: Colors.grey,
                                ),
                                SizedBox(height: 12),
                                Text(
                                  'Belum ada riwayat kunjungan',
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ],
                            ),
                          ),
                        )
                      : Column(
                          children: _filteredTickets.map<Widget>((ticket) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: VisitHistoryCardAdmin(
                                id: ticket.id!,
                                doctorName: ticket.doctor.name,
                                doctorSpecialization:
                                    ticket.doctor.specialization,
                                hospitalName: ticket.doctor.hospital,
                                visitDate: DateFormat(
                                  'dd MMMM yyyy',
                                  'id_ID',
                                ).format(ticket.visitDate),
                                visitStatus: ticket.status,
                                chiefComplaint: ticket.chiefComplaint,
                              ),
                            );
                          }).toList(),
                        ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
