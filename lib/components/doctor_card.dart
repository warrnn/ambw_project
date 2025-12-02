import 'package:flutter/material.dart';
import 'package:telehealth/service/doctor_service.dart';

class DoctorCard extends StatelessWidget {
  final String id;
  final String name;
  final String specialist;
  final String hospital;
  final String imageUrl;
  final VoidCallback onDeleted;

  const DoctorCard({
    super.key,
    required this.id,
    required this.name,
    required this.specialist,
    required this.hospital,
    required this.imageUrl,
    required this.onDeleted,
  });

  void handleDelete(BuildContext context, String id, String imageUrl) async {
    try {
      await DoctorService().deleteDoctor(id, imageUrl);
      Navigator.pop(context);
      onDeleted();
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Error: $e")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            blurRadius: 12,
            offset: const Offset(0, 4),
            color: Colors.black.withAlpha(30),
          ),
        ],
      ),
      child: Row(
        children: [
          InkWell(
            borderRadius: BorderRadius.circular(16),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                imageUrl,
                width: 72,
                height: 72,
                fit: BoxFit.cover,
              ),
            ),
          ),

          const SizedBox(width: 14),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  specialist,
                  style: const TextStyle(fontSize: 13, color: Colors.blue),
                ),
                Text(
                  hospital,
                  style: const TextStyle(fontSize: 12, color: Colors.black45),
                ),
              ],
            ),
          ),

          IconButton(
            onPressed: () {
              _confirmDelete(context, name);
            },
            icon: const Icon(Icons.delete, color: Colors.red, size: 26),
          ),
        ],
      ),
    );
  }

  void _confirmDelete(BuildContext context, String name) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text("Hapus Dokter?"),
        content: Text("Apakah Anda yakin ingin menghapus $name dari daftar?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Batal", style: TextStyle(color: Colors.black)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onPressed: () => handleDelete(context, id, imageUrl),
            child: const Text("Hapus", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
