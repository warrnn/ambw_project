import 'package:telehealth/model/doctor.dart';

class VisitTicket {
  final String? id;
  final Doctor doctor;
  final String chiefComplaint;
  final DateTime visitDate;
  final bool status;
  final String userId;

  VisitTicket({
    required this.id,
    required this.doctor,
    required this.chiefComplaint,
    required this.visitDate,
    required this.status,
    required this.userId,
  });

  factory VisitTicket.fromJson(Map<String, dynamic> json) {
    return VisitTicket(
      id: json['id'],
      doctor: Doctor.fromJson(json['doctor']),
      chiefComplaint: json['chief_complaint'],
      visitDate: DateTime.parse(json['visit_date']),
      status: json['status'],
      userId: json['user_id'],
    );
  }
}
