import 'package:flutter/material.dart';
import 'package:telehealth/pages/admin/dashboard_page.dart';

class AdminDashboardVisitScheduleCard extends StatefulWidget {
  final String doctorName;
  final String doctorSpecialization;
  final String hospitalName;
  final String visitDate;
  final bool visitStatus;
  final String userName;

  const AdminDashboardVisitScheduleCard({
    super.key,
    required this.doctorName,
    required this.doctorSpecialization,
    required this.hospitalName,
    required this.visitDate,
    required this.visitStatus,
    required this.userName,
  });

  @override
  State<AdminDashboardVisitScheduleCard> createState() =>
      _AdminDashboardVisitScheduleCardState();
}

class _AdminDashboardVisitScheduleCardState
    extends State<AdminDashboardVisitScheduleCard> {
  Color _statusBackgroundColor = Colors.amber;

  @override
  Widget build(BuildContext context) {
    _statusBackgroundColor = widget.visitStatus ? Colors.green : Colors.amber;

    void goToQRScanPage(BuildContext context) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const DashboardPage()),
      );
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.blue.withAlpha(30),
                ),
                child: const Icon(Icons.person, size: 28, color: Colors.blue),
              ),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  children: [
                    Text(
                      widget.doctorName,
                      style: TextStyle(fontSize: 16),
                      textAlign: TextAlign.start,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          widget.doctorSpecialization,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          widget.hospitalName,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          widget.visitDate,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: _statusBackgroundColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  widget.visitStatus ? 'Dikonfimasi' : 'Pending',
                  style: TextStyle(fontSize: 12, color: Colors.white),
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              minimumSize: const Size(double.infinity, 52),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: () => goToQRScanPage(context),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.qr_code, color: Colors.white),
                SizedBox(width: 8),
                Text(
                  'Sqan QR Code',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
