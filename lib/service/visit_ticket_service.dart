import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:telehealth/model/visit_ticket.dart';

class VisitTicketService {
  final supabase = Supabase.instance.client;

  Future<List<VisitTicket>> getAllPendingCurrentUserVisitTickets() async {
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

  Future<String> createVisitTicket(
    String doctorId,
    String chiefComplaint,
    String visitDate,
    bool status,
  ) async {
    try {
      final response = await supabase
          .from('visit_tickets')
          .insert([
            {
              "doctor_id": doctorId,
              "chief_complaint": chiefComplaint,
              "visit_date": visitDate,
              "status": status,
              "user_id": supabase.auth.currentUser!.id,
            },
          ])
          .select('id')
          .maybeSingle();
      return response?['id'] as String;
    } catch (e) {
      throw Exception('Failed to create visit ticket: $e');
    }
  }

  Future<VisitTicket> searchVisitTicket(String id) async {
    try {
      final response = await supabase
          .from('visit_tickets')
          .select('*, doctor:doctor_id(*)')
          .eq('id', id)
          .maybeSingle();
      if (response == null) {
        throw Exception('Visit ticket not found');
      }
      return VisitTicket.fromJson(response);
    } catch (e) {
      throw Exception('Failed to fetch visit ticket: $e');
    }
  }

  Future<List<VisitTicket>> getAllPendingVisitTickets() async {
    try {
      final response = await supabase
          .from('visit_tickets')
          .select('*, doctor:doctor_id(*)')
          .eq('status', false)
          .order('visit_date', ascending: true);
      // print(response);
      return response.map((json) => VisitTicket.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Failed to fetch visit tickets: $e');
    }
  }
}
