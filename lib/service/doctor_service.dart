import 'package:image_picker/image_picker.dart';
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

  String getMimeType(String ext) {
    switch (ext.toLowerCase()) {
      case 'jpg':
      case 'jpeg':
        return 'image/jpeg';
      case 'png':
        return 'image/png';
      default:
        return 'application/octet-stream';
    }
  }

  Future<String?> uploadDoctorPhoto(XFile file, String doctorId) async {
    try {
      final bytes = await file.readAsBytes();
      final fileExt = file.name.split('.').last;
      final fileName = '$doctorId.$fileExt';
      final filePath = fileName;
      final mimeType = getMimeType(fileExt);

      await supabase.storage
          .from('doctor_photos')
          .uploadBinary(
            filePath,
            bytes,
            fileOptions: FileOptions(contentType: mimeType, upsert: true),
          );

      final publicUrl =
          "${supabase.storage.url}/object/public/doctor_photos/$filePath";

      return publicUrl;
    } catch (e) {
      throw Exception('Failed to upload doctor photo: $e');
    }
  }

  Future<String> createDoctor(Doctor doctor) async {
    try {
      final response = await supabase
          .from('doctors')
          .insert({
            'name': doctor.name,
            'specialization': doctor.specialization,
            'hospital': doctor.hospital,
          })
          .select()
          .single();
      return response['id'];
    } catch (e) {
      throw Exception('Failed to create doctor: $e');
    }
  }

  Future<void> updateDoctorPhoto(String doctorId, String imageUrl) async {
    try {
      await supabase
          .from('doctors')
          .update({'photo_url': imageUrl})
          .eq('id', doctorId);
    } catch (e) {
      throw Exception('Failed to update doctor photo: $e');
    }
  }

  Future<void> deleteDoctor(String doctorId, String imageUrl) async {
    try {
      final fileName = imageUrl.split('/').last;

      await supabase.from('doctors').delete().eq('id', doctorId);
      await supabase.storage.from('doctor_photos').remove([fileName]);
    } catch (e) {
      throw Exception('Failed to delete doctor: $e');
    }
  }
}
