import 'package:flutter/material.dart';

class HomeVisitScheduleCard extends StatefulWidget {
  final String doctorName;
  final String doctorSpecialization;
  final String visitDate;
  final String visitTime;
  final String visitStatus;
  final String chiefComplaint;

  const HomeVisitScheduleCard({
    super.key,
    required this.doctorName,
    required this.doctorSpecialization,
    required this.visitDate,
    required this.visitTime,
    required this.visitStatus,
    required this.chiefComplaint,
  });

  @override
  State<HomeVisitScheduleCard> createState() => _HomeVisitScheduleCardState();
}

class _HomeVisitScheduleCardState extends State<HomeVisitScheduleCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[50],
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
                padding: EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Colors.green,
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
              Text(widget.visitDate, style: TextStyle(fontSize: 14)),
              SizedBox(width: 16),
              Icon(Icons.access_time, size: 16),
              SizedBox(width: 8),
              Text(widget.visitTime, style: TextStyle(fontSize: 14)),
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
        ],
      ),
    );
  }
}
