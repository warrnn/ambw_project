import 'package:flutter/material.dart';

class VisitTicketPage extends StatefulWidget {
  const VisitTicketPage({super.key});

  @override
  State<VisitTicketPage> createState() => _VisitTicketPageState();
}

class _VisitTicketPageState extends State<VisitTicketPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.blue, Colors.lightBlue],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            padding: EdgeInsets.symmetric(vertical: 44, horizontal: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(24.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  child: Icon(
                    Icons.check_circle_outline_rounded,
                    size: 96,
                    color: Colors.green,
                  ),
                ),
                SizedBox(height: 24),
                Text(
                  'Ticket Berhasil Dibuat!',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  'Silahkan tunjukan QR Code ini kepada admin untuk melakukan kunjungan.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                SizedBox(height: 32),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 24,
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(12.0),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.blue.withAlpha(30),
                              ),
                              child: Icon(
                                Icons.medical_information,
                                color: Colors.blue,
                                size: 32,
                              ),
                            ),
                            SizedBox(width: 16),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Dokter',
                                  style: TextStyle(color: Colors.grey[600]),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  'Dr. John Doe',
                                  style: TextStyle(fontSize: 16),
                                ),
                                SizedBox(height: 4),
                                Text('Spesialis Sakit Hati'),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 24,
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(12.0),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.blue.withAlpha(30),
                              ),
                              child: Icon(
                                Icons.edit_document,
                                color: Colors.blue,
                                size: 32,
                              ),
                            ),
                            SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Keluhan',
                                    style: TextStyle(color: Colors.grey[600]),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    'Sakit hati habis diputusin mantan pacar 12 tahun',
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 24,
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(12.0),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.blue.withAlpha(30),
                              ),
                              child: Icon(
                                Icons.calendar_month,
                                color: Colors.blue,
                                size: 32,
                              ),
                            ),
                            SizedBox(width: 16),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Tanggal Kunjungan',
                                  style: TextStyle(color: Colors.grey[600]),
                                ),
                                Text(
                                  '01 Januari 2025',
                                  style: TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 8),
                      Container(
                        padding: EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 24,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Status'),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.amber,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                'Pending',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
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
