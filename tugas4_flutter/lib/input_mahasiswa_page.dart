import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Diperlukan untuk input formatter
import 'models/mahasiswa.dart'; // Pastikan path model ini benar

class InputMahasiswaPage extends StatefulWidget {
  const InputMahasiswaPage({super.key});

  @override
  State<InputMahasiswaPage> createState() => _InputMahasiswaPageState();
}

class _InputMahasiswaPageState extends State<InputMahasiswaPage> {
  // GlobalKey untuk mengelola state dari Form
  final _formKey = GlobalKey<FormState>();

  final _namaController = TextEditingController();
  final _umurController = TextEditingController();
  final _alamatController = TextEditingController();
  final _kontakController = TextEditingController();
  final _emailController = TextEditingController(); // Controller untuk email
  String? _jenisKelamin; // Variabel untuk menyimpan nilai dropdown

  @override
  void dispose() {
    _namaController.dispose();
    _umurController.dispose();
    _alamatController.dispose();
    _kontakController.dispose();
    _emailController.dispose(); // Jangan lupa dispose controller baru
    super.dispose();
  }

  void _simpanData() {
    // Jalankan validasi pada semua TextFormField dalam form
    if (_formKey.currentState!.validate()) {
      // Jika semua validasi berhasil, buat objek Mahasiswa
      // (Catatan: Anda perlu menambahkan field baru ke model Mahasiswa Anda)
      final mahasiswaBaru = Mahasiswa(
        nama: _namaController.text,
        umur: _umurController.text,
        alamat: _alamatController.text,
        kontak: _kontakController.text,
        // email: _emailController.text,       // Uncomment jika sudah ada di model
        // jenisKelamin: _jenisKelamin!,      // Uncomment jika sudah ada di model
      );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.green,
          content: Text('Data berhasil disimpan!'),
        ),
      );

      // Kirim data kembali ke halaman sebelumnya
      Navigator.pop(context, mahasiswaBaru);
    } else {
      // Jika validasi gagal, tampilkan pesan error
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.red,
          content: Text('Terdapat kesalahan pada input. Mohon periksa kembali!'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Input Data Mahasiswa'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        // Bungkus Column dengan Form dan berikan key
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // --- NAMA ---
              TextFormField(
                controller: _namaController,
                decoration: const InputDecoration(
                  labelText: 'Nama',
                  prefixIcon: Icon(Icons.person_outline),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nama tidak boleh kosong';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // --- UMUR ---
              TextFormField(
                controller: _umurController,
                decoration: const InputDecoration(
                  labelText: 'Umur',
                  prefixIcon: Icon(Icons.cake_outlined),
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Umur tidak boleh kosong';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // --- ALAMAT ---
              TextFormField(
                controller: _alamatController,
                decoration: const InputDecoration(
                  labelText: 'Alamat',
                  prefixIcon: Icon(Icons.home_outlined),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Alamat tidak boleh kosong';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // --- NOMOR HP (KONTAK) ---
              TextFormField(
                controller: _kontakController,
                decoration: const InputDecoration(
                  labelText: 'Nomor HP',
                  prefixIcon: Icon(Icons.phone_outlined),
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.phone,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nomor HP tidak boleh kosong';
                  }
                  if (value.length < 10) {
                    return 'Nomor HP minimal harus 10 digit';
                  }
                  return null; // Return null jika valid
                },
              ),
              const SizedBox(height: 16),

              // --- JENIS KELAMIN ---
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: 'Jenis Kelamin',
                  prefixIcon: Icon(Icons.wc_outlined),
                  border: OutlineInputBorder(),
                ),
                value: _jenisKelamin,
                items: ['Laki-laki', 'Perempuan']
                    .map((label) => DropdownMenuItem(
                          value: label,
                          child: Text(label),
                        ))
                    .toList(),
                onChanged: (newValue) {
                  setState(() {
                    _jenisKelamin = newValue;
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return 'Jenis kelamin harus dipilih';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // --- EMAIL ---
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  prefixIcon: Icon(Icons.email_outlined),
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Email tidak boleh kosong';
                  }
                  // Validasi format email umum
                  if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                    return 'Format email tidak valid';
                  }
                  // Validasi khusus domain @unsika.ac.id
                  if (!value.endsWith('@unsika.ac.id')) {
                    return 'Email harus menggunakan domain @unsika.ac.id';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),

              // --- TOMBOL SIMPAN ---
              ElevatedButton.icon(
                onPressed: _simpanData,
                icon: const Icon(Icons.save),
                label: const Text('Simpan'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  textStyle: const TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}