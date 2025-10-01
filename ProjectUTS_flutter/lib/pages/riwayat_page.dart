// lib/pages/riwayat_page.dart

import 'package:flutter/material.dart';
import '../models/absensi.dart';
import 'package:intl/intl.dart'; 
import 'package:google_fonts/google_fonts.dart';

class RiwayatPage extends StatelessWidget {
  final List<Absensi> daftarAbsensi;

  const RiwayatPage({super.key, required this.daftarAbsensi});

  Widget _buildStatusIcon(String status) {
    IconData iconData;
    Color color;
    switch (status) {
      case 'Hadir':
        iconData = Icons.check_circle_outline;
        color = Colors.green.shade600;
        break;
      case 'Izin':
        iconData = Icons.info_outline;
        color = Colors.amber.shade700;
        break;
      case 'Sakit':
        iconData = Icons.sick_outlined;
        color = Colors.red.shade600;
        break;
      default:
        iconData = Icons.help_outline;
        color = Colors.grey.shade600;
    }
    return Icon(iconData, color: color, size: 36);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Riwayat Absensi',
          style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
        ),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: daftarAbsensi.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.history_toggle_off, size: 80, color: Colors.grey.shade300),
                  const SizedBox(height: 16),
                  Text(
                    'Belum ada riwayat absensi.',
                    style: TextStyle(fontSize: 18, color: Colors.grey.shade500),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              itemCount: daftarAbsensi.length,
              itemBuilder: (context, index) {
                final absensi = daftarAbsensi[index];
                return Card(
                  // DESAIN CARD BARU
                  elevation: 2,
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide(color: Colors.grey.shade200),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: ListTile(
                      leading: _buildStatusIcon(absensi.status),
                      title: Text(
                        absensi.nama,
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      subtitle: Text(
                        '${DateFormat('EEEE, d MMM yyyy, HH:mm', 'id_ID').format(absensi.tanggal)}\n${absensi.keterangan != null && absensi.keterangan!.isNotEmpty ? "Ket: ${absensi.keterangan}" : "Tidak ada keterangan"}',
                      ),
                      trailing: Text(
                        absensi.status,
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      isThreeLine: true,
                    ),
                  ),
                );
              },
            ),
    );
  }
}