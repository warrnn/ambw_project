import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:telehealth/pages/user/visit_ticket_page.dart';

class VisitFormPage extends StatefulWidget {
  const VisitFormPage({super.key});

  @override
  State<VisitFormPage> createState() => _VisitFormPageState();
}

class _VisitFormPageState extends State<VisitFormPage> {
  final TextEditingController _chiefComplaintController =
      TextEditingController();
  DateTime? selectedDate = DateTime.now();

  void submitVisitForm(BuildContext context) {
    final chiefComplaint = _chiefComplaintController.text.trim();
    final visitDate = selectedDate;

    log('Chief Complaint: $chiefComplaint');
    log('Visit Date: $visitDate');

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const VisitTicketPage()),
    );
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
                        'Dr. Tirta',
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
                          Text('Spesialis Sakit Hati'),
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
                          Text('National Hospital'),
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
