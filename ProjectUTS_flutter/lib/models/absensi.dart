class Absensi {
  final String id;
  final String nama;
  final DateTime tanggal;
  final String status;
  final String? keterangan; // Keterangan bisa jadi data kosong

  Absensi({
    required this.id,
    required this.nama,
    required this.tanggal,
    required this.status,
    this.keterangan,
  });
}