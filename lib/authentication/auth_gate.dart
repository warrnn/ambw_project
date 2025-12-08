import 'package:flutter/material.dart';
import 'package:telehealth/authentication/auth_service.dart';
import 'package:telehealth/pages/admin/dashboard_page.dart';
import 'package:telehealth/pages/auth/login_page.dart';
import 'package:telehealth/pages/user/home_page.dart';
import 'package:telehealth/service/admin_service.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = AuthService();
    final adminService = AdminService();

    return StreamBuilder(
      stream: authService.client().auth.onAuthStateChange,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        final session = snapshot.hasData
            ? (snapshot.data as dynamic).session
            : authService.client().auth.currentSession;

        if (session == null) {
          return LoginPage();
        }

        return FutureBuilder<bool>(
          future: adminService.checkUserIsAdmin(session.user.id),
          builder: (context, adminSnapshot) {
            if (!adminSnapshot.hasData) {
              return const Scaffold(
                body: Center(child: CircularProgressIndicator()),
              );
            }

            final isAdmin = adminSnapshot.data!;

            if (isAdmin) {
              return DashboardPage();
            }

            return HomePage();
          },
        );
      },
    );
  }
}
