// lib/main.dart

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart'; // Impor Google Fonts
import 'models/absensi.dart';
import 'pages/absen_page.dart';
import 'pages/riwayat_page.dart';
import 'pages/splash_screen.dart'; // Impor Splash Screen
import 'package:intl/date_symbol_data_local.dart';

Future<void> main() async { 
  WidgetsFlutterBinding.ensureInitialized(); 
  await initializeDateFormatting('id_ID', null); 

  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aplikasi Absensi',
      // TEMA BARU UNTUK TAMPILAN LEBIH MENARIK
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        // Gunakan Google Fonts sebagai tema teks utama
        textTheme: GoogleFonts.poppinsTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      // Mulai aplikasi dari SplashScreen
      home: const SplashScreen(), 
      debugShowCheckedModeBanner: false,
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;
  
  final List<Absensi> _daftarAbsensi = [];

  void _handleAbsenSuccess(Absensi absensiBaru) {
    setState(() {
      _daftarAbsensi.insert(0, absensiBaru);
      _selectedIndex = 0; 
    });
  }
  
  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      RiwayatPage(daftarAbsensi: _daftarAbsensi),
      AbsenPage(onAbsenSuccess: _handleAbsenSuccess),
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex], 
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'Riwayat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.app_registration_rounded), // Ikon diperbarui
            label: 'Absen',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.indigo, // Warna item aktif
        unselectedItemColor: Colors.grey, // Warna item non-aktif
      ),
    );
  }
}