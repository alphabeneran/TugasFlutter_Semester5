// lib/pages/absen_page.dart

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/absensi.dart';

class AbsenPage extends StatefulWidget {
  final Function(Absensi) onAbsenSuccess;

  const AbsenPage({super.key, required this.onAbsenSuccess});

  @override
  State<AbsenPage> createState() => _AbsenPageState();
}

class _AbsenPageState extends State<AbsenPage> {
  final _formKey = GlobalKey<FormState>();
  final _namaController = TextEditingController();
  final _keteranganController = TextEditingController();
  String? _statusValue;

  void _submitAbsen() {
    if (_formKey.currentState!.validate()) {
      final absensiBaru = Absensi(
        id: DateTime.now().toIso8601String(), // ID unik berdasarkan waktu
        nama: _namaController.text,
        tanggal: DateTime.now(),
        status: _statusValue!,
        keterangan: _keteranganController.text,
      );

      // Panggil callback untuk mengirim data ke main.dart
      widget.onAbsenSuccess(absensiBaru);

      // Tampilkan SnackBar dan kembali
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.green,
          content: Text('Absensi berhasil direkam!'),
        ),
      );
    }
  }

  @override
  void dispose() {
    _namaController.dispose();
    _keteranganController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Lakukan Absensi',
          style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
        ),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _namaController,
                decoration: const InputDecoration(
                  labelText: 'Nama Lengkap',
                  prefixIcon: Icon(Icons.person),
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
              DropdownButtonFormField<String>(
                value: _statusValue,
                decoration: const InputDecoration(
                  labelText: 'Status Kehadiran',
                  prefixIcon: Icon(Icons.rule),
                  border: OutlineInputBorder(),
                ),
                items: ['Hadir', 'Izin', 'Sakit']
                    .map((status) => DropdownMenuItem(
                          value: status,
                          child: Text(status),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _statusValue = value;
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return 'Status harus dipilih';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _keteranganController,
                decoration: const InputDecoration(
                  labelText: 'Keterangan (Opsional)',
                  prefixIcon: Icon(Icons.notes),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: _submitAbsen,
                icon: const Icon(Icons.save),
                label: const Text('Simpan Absensi'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}