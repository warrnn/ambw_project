import 'package:flutter/material.dart';

class HomeVisitScheduleCard extends StatefulWidget {
  final String doctorName;
  final String doctorSpecialization;
  final String hospitalName;
  final String visitDate;
  final bool visitStatus;
  final String chiefComplaint;

  const HomeVisitScheduleCard({
    super.key,
    required this.doctorName,
    required this.doctorSpecialization,
    required this.hospitalName,
    required this.visitDate,
    required this.visitStatus,
    required this.chiefComplaint,
  });

  @override
  State<HomeVisitScheduleCard> createState() => _HomeVisitScheduleCardState();
}

class _HomeVisitScheduleCardState extends State<HomeVisitScheduleCard> {
  Color _statusBackgroundColor = Colors.amber;

  @override
  Widget build(BuildContext context) {
    _statusBackgroundColor = widget.visitStatus ? Colors.green : Colors.amber;

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
                  widget.visitStatus ? 'Dikonfimasi' : 'Pending',
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
              style: TextStyle(fontSize: 14, color: Colors.blue),
            ),
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Icon(Icons.calendar_month, size: 16),
              SizedBox(width: 8),
              Text(
                widget.visitDate.toString(),
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          SizedBox(height: 8),
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
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  child: Row(
                    children: [
                      Flexible(
                        child: Text(
                          widget.chiefComplaint,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
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
    );
  }
}
