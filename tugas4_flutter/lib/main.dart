import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart'; // 1. Impor package url_launcher
import 'input_mahasiswa_page.dart';
import 'models/mahasiswa.dart';
import 'profile_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Demo',
      home: MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  Mahasiswa? _mahasiswaData;

  // 2. Fungsi baru untuk membuka aplikasi telepon
  Future<void> _launchCaller(String phoneNumber) async {
    final Uri url = Uri.parse('tel:$phoneNumber');
    if (!await launchUrl(url)) {
      // Tampilkan pesan error jika gagal membuka aplikasi telepon
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Could not launch dialer for $phoneNumber'),
        ),
      );
    }
  }

  Future<void> _navigateToInputPage(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const InputMahasiswaPage()),
    );

    if (result != null && result is Mahasiswa) {
      setState(() {
        _mahasiswaData = result;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Main Page'),
        backgroundColor: Colors.blueGrey,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ProfilePage()),
                  );
                },
                child: const Text('Go to Profile Page'),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  _navigateToInputPage(context);
                },
                child: const Text('Input Data Mahasiswa'),
              ),
              const SizedBox(height: 30),
              if (_mahasiswaData != null)
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Data Mahasiswa Diterima:',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18)),
                      const SizedBox(height: 10),
                      Text('Nama: ${_mahasiswaData!.nama}'),
                      Text('Umur: ${_mahasiswaData!.umur}'),
                      Text('Alamat: ${_mahasiswaData!.alamat}'),
                      Text('Kontak: ${_mahasiswaData!.kontak}'),
                      const SizedBox(height: 16),
                      // 3. Tombol "Call" yang hanya muncul jika ada data
                      Center(
                        child: ElevatedButton.icon(
                          onPressed: () {
                            // Panggil fungsi _launchCaller dengan data kontak
                            _launchCaller(_mahasiswaData!.kontak);
                          },
                          icon: const Icon(Icons.call),
                          label: const Text('Call'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green, // Warna hijau untuk call
                          ),
                        ),
                      ),
                    ],
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}