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

  Future<List<VisitTicket>>
  getAllCurrentUserConfirmedUpcomingAppointments() async {
    try {
      final response = await supabase
          .from('visit_tickets')
          .select('*, doctor:doctor_id(*)')
          .gte('visit_date', DateTime.now().toString())
          .eq('status', true)
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

  Future<List<VisitTicket>> getAllConfirmedVisitTickets() async {
    try {
      final response = await supabase
          .from('visit_tickets')
          .select('*, doctor:doctor_id(*)')
          .eq('status', true)
          .order('visit_date', ascending: true);
      // print(response);
      return response.map((json) => VisitTicket.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Failed to fetch visit tickets: $e');
    }
  }

  Future<void> confirmVisitTicket(String id) async {
    try {
      await supabase
          .from('visit_tickets')
          .update({'status': true})
          .eq('id', id);
    } catch (e) {
      throw Exception('Failed to update visit ticket status: $e');
    }
  }

  /// Get all visit tickets for the current user (all history - pending & completed)
  Future<List<VisitTicket>> getUserVisitHistory() async {
    try {
      final response = await supabase
          .from('visit_tickets')
          .select('*, doctor:doctor_id(*)')
          .eq('user_id', supabase.auth.currentUser!.id)
          .order('visit_date', ascending: false);

      return response.map((json) => VisitTicket.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Failed to fetch visit history: $e');
    }
  }

  /// Get only completed visit tickets for the current user
  Future<List<VisitTicket>> getUserCompletedVisitHistory() async {
    try {
      final response = await supabase
          .from('visit_tickets')
          .select('*, doctor:doctor_id(*)')
          .eq('status', true)
          .eq('user_id', supabase.auth.currentUser!.id)
          .order('visit_date', ascending: false);

      return response.map((json) => VisitTicket.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Failed to fetch completed visit history: $e');
    }
  }

  /// Get all completed visit tickets (for admin/doctor)
  Future<List<VisitTicket>> getAllVisitHistory() async {
    try {
      final response = await supabase
          .from('visit_tickets')
          .select('*, doctor:doctor_id(*)')
          .eq('status', true)
          .order('visit_date', ascending: false);

      return response.map((json) => VisitTicket.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Failed to fetch all visit history: $e');
    }
  }

  /// Get visit history for a specific user (for admin)
  Future<List<VisitTicket>> getUserVisitHistoryById(String userId) async {
    try {
      final response = await supabase
          .from('visit_tickets')
          .select('*, doctor:doctor_id(*)')
          .eq('status', true)
          .eq('user_id', userId)
          .order('visit_date', ascending: false);

      return response.map((json) => VisitTicket.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Failed to fetch visit history for user: $e');
    }
  }

  /// Get visit history for a specific doctor (for admin)
  Future<List<VisitTicket>> getDoctorVisitHistory(String doctorId) async {
    try {
      final response = await supabase
          .from('visit_tickets')
          .select('*, doctor:doctor_id(*)')
          .eq('status', true)
          .eq('doctor_id', doctorId)
          .order('visit_date', ascending: false);

      return response.map((json) => VisitTicket.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Failed to fetch doctor visit history: $e');
    }
  }

  /// Mark a visit ticket as completed (completed status)
  Future<void> completeVisitTicket(String ticketId) async {
    try {
      await supabase
          .from('visit_tickets')
          .update({'status': true})
          .eq('id', ticketId);
    } catch (e) {
      throw Exception('Failed to complete visit ticket: $e');
    }
  }

  /// Get visit history with filtering by date range
  Future<List<VisitTicket>> getUserVisitHistoryByDateRange(
    String startDate,
    String endDate,
  ) async {
    try {
      final response = await supabase
          .from('visit_tickets')
          .select('*, doctor:doctor_id(*)')
          .eq('status', true)
          .eq('user_id', supabase.auth.currentUser!.id)
          .gte('visit_date', startDate)
          .lte('visit_date', endDate)
          .order('visit_date', ascending: false);

      return response.map((json) => VisitTicket.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Failed to fetch visit history by date range: $e');
    }
  }

  /// Get statistics for visit history (total, pending, confirmed)
  Future<Map<String, int>> getVisitStatistics() async {
    try {
      final response = await supabase
          .from('visit_tickets')
          .select('status')
          .order('visit_date', ascending: false);

      int total = response.length;
      int pending = response.where((t) => t['status'] == false).length;
      int confirmed = response.where((t) => t['status'] == true).length;

      return {'total': total, 'pending': pending, 'confirmed': confirmed};
    } catch (e) {
      throw Exception('Failed to fetch visit statistics: $e');
    }
  }

  /// Get all visit tickets with all statuses (for admin dashboard)
  Future<List<VisitTicket>> getAllVisitTickets() async {
    try {
      final response = await supabase
          .from('visit_tickets')
          .select('*, doctor:doctor_id(*)')
          .order('visit_date', ascending: false);

      return response.map((json) => VisitTicket.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Failed to fetch all visit tickets: $e');
    }
  }
}
