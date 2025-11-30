import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:telehealth/authentication/auth_service.dart';
import 'package:telehealth/pages/user/visit_ticket_page.dart';
import 'package:telehealth/service/visit_ticket_service.dart';

class VisitFormPage extends StatefulWidget {
  final String doctorId;
  final String doctorName;
  final String doctorSpecialization;
  final String hospitalName;

  const VisitFormPage({
    super.key,
    required this.doctorId,
    required this.doctorName,
    required this.doctorSpecialization,
    required this.hospitalName,
  });

  @override
  State<VisitFormPage> createState() => _VisitFormPageState();
}

class _VisitFormPageState extends State<VisitFormPage> {
  final TextEditingController _chiefComplaintController =
      TextEditingController();
  DateTime? selectedDate = DateTime.now();
  final authService = AuthService();

  Future<void> submitVisitForm(BuildContext context) async {
    final chiefComplaint = _chiefComplaintController.text.trim();
    final visitDate = selectedDate;

    try {
      final ticketId = await VisitTicketService().createVisitTicket(
        widget.doctorId,
        chiefComplaint,
        visitDate.toString(),
        false,
      );

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => VisitTicketPage(ticketId: ticketId),
        ),
      );
    } catch (e) {
      log('Error creating visit ticket: $e');
    }
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
          "Form Kunjungan",
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
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.lightBlueAccent.withAlpha(50),
                    border: Border.all(color: Colors.lightBlueAccent),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Dokter yang dipilih:'),
                      SizedBox(height: 20),
                      Text(
                        widget.doctorName,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 20),
                      Row(
                        children: [
                          Icon(
                            Icons.medical_information_outlined,
                            size: 20,
                            color: Colors.grey[600],
                          ),
                          SizedBox(width: 8),
                          Text(widget.doctorSpecialization),
                        ],
                      ),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(
                            Icons.local_hospital_outlined,
                            size: 20,
                            color: Colors.grey[600],
                          ),
                          SizedBox(width: 8),
                          Text(widget.hospitalName),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Keluhan',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
                SizedBox(height: 8),
                TextField(
                  controller: _chiefComplaintController,
                  cursorColor: Colors.blue,
                  maxLines: 5,
                  decoration: InputDecoration(
                    hintText: 'Jelaskkan keluhan Anda...',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide(color: Colors.blue, width: 2),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Tanggal Kunjungan',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
                SizedBox(height: 12),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Theme(
                      data: Theme.of(context).copyWith(
                        colorScheme: const ColorScheme.light(
                          surface: Colors.blue,
                        ),
                      ),
                      child: SfDateRangePicker(
                        selectionMode: DateRangePickerSelectionMode.single,
                        initialSelectedDate: DateTime.now(),
                        showNavigationArrow: true,
                        showActionButtons: false,
                        selectionColor: Colors.blueAccent,
                        startRangeSelectionColor: Colors.blueAccent,
                        endRangeSelectionColor: Colors.blueAccent,
                        monthViewSettings:
                            const DateRangePickerMonthViewSettings(
                              dayFormat: 'EEE',
                            ),
                        onSelectionChanged: (args) {
                          if (args.value is DateTime) {
                            setState(() {
                              selectedDate = args.value;
                            });
                          }
                          log("Selected date: $selectedDate");
                        },
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 24),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    minimumSize: const Size(double.infinity, 60),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () => submitVisitForm(context),
                  child: const Text(
                    'Buat Kunjungan',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
