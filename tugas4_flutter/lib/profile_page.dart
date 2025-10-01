import 'package:flutter/material.dart';

// Ini adalah widget untuk halaman profil.
// Kita menggunakan StatelessWidget karena kontennya statis (tidak berubah).
class ProfilePage extends StatelessWidget {
  // const constructor direkomendasikan untuk widget yang tidak berubah.
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Scaffold adalah kerangka dasar untuk sebuah halaman di Material Design.
    return Scaffold(
      // AppBar adalah bilah judul di bagian atas halaman.
      appBar: AppBar(
        title: const Text('Profile Page'),
        backgroundColor: Colors.teal, // Memberi warna agar serasi
      ),
      // Body adalah konten utama dari halaman.
      body: Padding(
        padding: const EdgeInsets.all(20.0), // Beri jarak dari tepi layar
        child: Column(
          // Column untuk menyusun widget secara vertikal.
          crossAxisAlignment: CrossAxisAlignment.start, // Ratakan teks ke kiri
          children: const [
            // Teks untuk menampilkan informasi profil.
            // Data di-hardcode sesuai permintaan.
            Text(
              'Nama Aplikasi: My Flutter App',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 12), // Memberi sedikit jarak vertikal
            Text(
              'Versi: 1.0.0',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 12), // Memberi sedikit jarak vertikal
            Text(
              'Developer: Alpha Athallah',
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}