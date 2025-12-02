import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:telehealth/model/doctor.dart';
import 'package:telehealth/service/doctor_service.dart';

class AddDoctorPage extends StatefulWidget {
  const AddDoctorPage({super.key});

  @override
  State<AddDoctorPage> createState() => _AddDoctorPageState();
}

class _AddDoctorPageState extends State<AddDoctorPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController specialistController = TextEditingController();
  final TextEditingController hospitalController = TextEditingController();

  XFile? uploadedImage;

  final picker = ImagePicker();

  Future<void> pickImage() async {
    final file = await picker.pickImage(source: ImageSource.gallery);
    if (file != null) {
      setState(() {
        uploadedImage = file;
      });
    }
  }

  void handleSubmit(Doctor doctor) async {
    if (uploadedImage == null ||
        nameController.text.isEmpty ||
        specialistController.text.isEmpty ||
        hospitalController.text.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Semua field wajib diisi")));
      return;
    }

    try {
      final doctorId = await DoctorService().createDoctor(doctor);

      if (uploadedImage != null) {
        final imageUrl = await DoctorService().uploadDoctorPhoto(
          uploadedImage!,
          doctorId,
        );
        await DoctorService().updateDoctorPhoto(doctorId, imageUrl!);
      }

      Navigator.pop(context, true);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Dokter berhasil ditambahkan!")),
      );
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Error: $e")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        shadowColor: Colors.black26,
        centerTitle: true,
        title: const Text(
          "Tambah Dokter",
          style: TextStyle(color: Colors.black),
        ),
      ),

      backgroundColor: const Color(0xFFF1F8FF),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            InkWell(
              onTap: pickImage,
              child: Column(
                children: [
                  Container(
                    width: 140,
                    height: 140,
                    decoration: BoxDecoration(
                      color: Colors.blue.withAlpha(30),
                      borderRadius: BorderRadius.circular(16),
                      image: uploadedImage != null
                          ? DecorationImage(
                              image: FileImage(File(uploadedImage!.path)),
                              fit: BoxFit.cover,
                            )
                          : null,
                    ),
                    child: uploadedImage == null
                        ? const Icon(
                            Icons.camera_alt,
                            size: 72,
                            color: Colors.blue,
                          )
                        : null,
                  ),

                  const SizedBox(height: 8),
                  const Text(
                    "Upload Foto Dokter",
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            _buildInput("Nama Lengkap", nameController),
            const SizedBox(height: 16),
            _buildInput("Spesialisasi", specialistController),
            const SizedBox(height: 16),
            _buildInput("Rumah Sakit", hospitalController),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => {
                  handleSubmit(
                    Doctor(
                      name: nameController.text,
                      specialization: specialistController.text,
                      hospital: hospitalController.text,
                    ),
                  ),
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1E88E5),
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: const Text(
                  "Simpan Dokter",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInput(String label, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 6),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            hintText: label,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: const BorderSide(color: Colors.black12),
            ),
          ),
        ),
      ],
    );
  }
}
