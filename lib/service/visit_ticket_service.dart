import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:telehealth/model/visit_ticket.dart';

class VisitTicketService {
  final supabase = Supabase.instance.client;

  Future<List<VisitTicket>> getAllPendingUserVisitTickets() async {
    try {
      final response = await supabase
          .from('visit_tickets')
          .select('*, doctor:doctor_id(*)')
          .eq('status', false)
          .eq('user_id', supabase.auth.currentUser!.id)
          .order('visit_date', ascending: true);
      // print(response);
      return response.map((json) => VisitTicket.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Failed to fetch visit tickets: $e');
    }
  }

  Future<List<VisitTicket>> getAllUserVisitTickets() async {
    try {
      final response = await supabase
          .from('visit_tickets')
          .select('*, doctor:doctor_id(*)')
          .eq('user_id', supabase.auth.currentUser!.id)
          .order('visit_date', ascending: true);
      // print(response);
      return response.map((json) => VisitTicket.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Failed to fetch visit tickets: $e');
    }
  }
}
