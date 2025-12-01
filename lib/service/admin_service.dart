import 'package:supabase_flutter/supabase_flutter.dart';

class AdminService {
  final supabase = Supabase.instance.client;

  Future<List<String>> getAllAdmins() async {
    try {
      final response = await supabase.from('admins').select();
      return response.map((json) => json['auth_user_id'] as String).toList();
    } catch (e) {
      throw Exception('Failed to fetch admins: $e');
    }
  }
}
