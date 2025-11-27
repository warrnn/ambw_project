import 'dart:math';

import 'package:flutter/material.dart';

class VisitHistoryCard extends StatefulWidget {
  final String doctorName;
  final String doctorSpecialization;
  final String hospitalName;
  final String visitDate;
  final String visitTime;
  final String visitStatus;
  final String chiefComplaint;

  const VisitHistoryCard({
    super.key,
    required this.doctorName,
    required this.doctorSpecialization,
    required this.hospitalName,
    required this.visitDate,
    required this.visitTime,
    required this.visitStatus,
    required this.chiefComplaint,
  });

  @override
  State<VisitHistoryCard> createState() => _VisitHistoryCardState();
}

class _VisitHistoryCardState extends State<VisitHistoryCard> {
  Color _statusBackgroundColor = Colors.amber;

  @override
  Widget build(BuildContext context) {
    _statusBackgroundColor = widget.visitStatus == 'Pending'
        ? Colors.amber
        : Colors.green;

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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(widget.doctorName, style: TextStyle(fontSize: 16)),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: _statusBackgroundColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  widget.visitStatus,
                  style: TextStyle(fontSize: 12, color: Colors.white),
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              widget.doctorSpecialization,
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
            ),
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Icon(Icons.calendar_month, size: 16),
              SizedBox(width: 8),
              Text(
                widget.visitDate,
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
              SizedBox(width: 16),
              Icon(Icons.access_time, size: 16),
              SizedBox(width: 8),
              Text(
                widget.visitTime,
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Icon(Icons.local_hospital_outlined, size: 16),
              SizedBox(width: 8),
              Text(
                widget.hospitalName,
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(4),
            ),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    child: Text(
                      'Keluhan:',
                      style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    child: Text(
                      widget.chiefComplaint,
                      style: TextStyle(fontSize: 14, color: Colors.black),
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (widget.visitStatus == 'Pending') ...[
            const SizedBox(height: 16),
            Container(color: const Color.fromARGB(120, 158, 158, 158), height: 1),
            const SizedBox(height: 8),
            InkWell(
              onTap: () {
                print('GAS KING WARREN');
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.qr_code_2, color: Colors.blue),
                  SizedBox(width: 8),
                  Text(
                    'QR Code tersedia untuk check-in',
                    style: TextStyle(color: Colors.blue,),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}
