import 'package:supabase_flutter/supabase_flutter.dart';

class AdminService {
  final supabase = Supabase.instance.client;

  Future<bool> checkUserIsAdmin(String id) async {
    try {
      final response = await supabase
          .from('admins')
          .select("*")
          .eq('auth_user_id', id);

      return response.isNotEmpty;
    } catch (e) {
      throw Exception('Failed to fetch admins: $e');
    }
  }
}
