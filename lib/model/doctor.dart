class Doctor {
  final String? id;
  final String name;
  final String specialization;
  final String hospital;
  final String? photoUrl;

  Doctor({
    this.id,
    required this.name,
    required this.specialization,
    required this.hospital,
    this.photoUrl,
  });

  factory Doctor.fromJson(Map<String, dynamic> json) {
    return Doctor(
      id: json['id'],
      name: json['name'],
      specialization: json['specialization'],
      hospital: json['hospital'],
      photoUrl: json['photo_url'],
    );
  }
}
