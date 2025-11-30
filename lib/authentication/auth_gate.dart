import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:telehealth/authentication/auth_service.dart';
import 'package:telehealth/pages/admin/dashboard_page.dart';
import 'package:telehealth/pages/auth/login_page.dart';
import 'package:telehealth/pages/user/home_page.dart';

class AuthGate extends StatelessWidget {
  final authService = AuthService();

  AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: authService.client().auth.onAuthStateChange,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(body: Center(child: CircularProgressIndicator()));
        }

        final session = authService.client().auth.currentSession;
        final adminEmail = dotenv.env['ADMIN_EMAIL']!
            .split(',')
            .map((e) => e.trim())
            .toList();

        if (session != null) {
          if (adminEmail.contains(session.user.email)) {
            return DashboardPage();
          } else {
            return HomePage();
          }
        } else {
          return LoginPage();
        }
      },
    );
  }
}
