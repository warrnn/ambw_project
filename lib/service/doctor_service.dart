import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:telehealth/model/doctor.dart';

class DoctorService {
  final supabase = Supabase.instance.client;

  Future<List<Doctor>> getAllDoctors() async {
    try {
      final response = await supabase.from('doctors').select();
      return response.map((json) => Doctor.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Failed to fetch doctors: $e');
    }
  }

  Future<Doctor> searchDoctor(String id) async {
    try {
      final response = await supabase.from('doctors').select().eq('id', id);
      return response.map((json) => Doctor.fromJson(json)).first;
    } catch (e) {
      throw Exception('Failed to fetch doctor: $e');
    }
  }
}
