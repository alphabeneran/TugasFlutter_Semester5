import 'package:flutter/material.dart';

// Model Data untuk Berita
class Berita {
  final String judul;
  final String deskripsi;
  final String imageUrl;

  const Berita({
    required this.judul,
    required this.deskripsi,
    required this.imageUrl,
  });
}

// Data Dummy untuk ditampilkan
final List<Berita> daftarBerita = const [
  Berita(
    judul: '19 Juta Lapangan Pekerjaan Telah Hadir di Indonesia!',
    deskripsi: 'Update terbaru ini membawa performa signifikan bagi perkembangan kesejahteraan masyarakat.',
    imageUrl: 'https://picsum.photos/seed/flutter/200/200',
  ),
  Berita(
    judul: 'Kecerdasan Buatan Mengubah Dunia Kerja',
    deskripsi: 'Bagaimana AI membentuk pekerjaan di masa depan.',
    imageUrl: 'https://picsum.photos/seed/ai/200/200',
  ),
  Berita(
    judul: 'Tips Produktif Bekerja dari Rumah',
    deskripsi: 'Maksimalkan harimu dengan strategi jitu ini.',
    imageUrl: 'https://picsum.photos/seed/work/200/200',
  ),
  Berita(
    judul: 'Panduan Memulai Investasi untuk Pemula',
    deskripsi: 'Langkah-langkah awal di dunia pasar modal.',
    imageUrl: 'https://picsum.photos/seed/invest/200/200',
  ),
  Berita(
    judul: 'Mobil Listrik Terbaru dengan Jarak Tempuh 800 KM',
    deskripsi: 'Inovasi baterai yang memecahkan rekor.',
    imageUrl: 'https://picsum.photos/seed/car/200/200',
  ),
  Berita(
    judul: 'Resep Makanan Sehat dan Cepat untuk Keluarga',
    deskripsi: 'Menu lezat yang bisa disiapkan dalam 30 menit.',
    imageUrl: 'https://picsum.photos/seed/food/200/200',
  ),
];

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aplikasi Berita',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HalamanBerita(), // Dihapus 'const' karena sudah jadi StatefulWidget
      debugShowCheckedModeBanner: false,
    );
  }
}

// 1. Ubah menjadi StatefulWidget
class HalamanBerita extends StatefulWidget {
  HalamanBerita({super.key});

  @override
  State<HalamanBerita> createState() => _HalamanBeritaState();
}

class _HalamanBeritaState extends State<HalamanBerita> {
  // 2. State untuk menyimpan berita yang di-bookmark
  final Set<Berita> _bookmarkedBerita = {};

  // 3. Fungsi untuk handle aksi bookmark
  void _toggleBookmark(Berita berita) {
    setState(() {
      if (_bookmarkedBerita.contains(berita)) {
        _bookmarkedBerita.remove(berita);
      } else {
        _bookmarkedBerita.add(berita);
      }
    });
  }

  // 4. Fungsi untuk navigasi ke halaman bookmark
  void _bukaHalamanBookmark() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => HalamanBookmark(
          bookmarkedBerita: _bookmarkedBerita.toList(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Berita Hari Ini'),
        // 5. Tambahkan tombol aksi untuk melihat halaman bookmark
        actions: [
          IconButton(
            icon: const Icon(Icons.bookmarks),
            onPressed: _bukaHalamanBookmark,
            tooltip: 'Bookmark Tersimpan',
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: daftarBerita.length,
        itemBuilder: (BuildContext context, int index) {
          final berita = daftarBerita[index];
          final isBookmarked = _bookmarkedBerita.contains(berita);

          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: ListTile(
              leading: Image.network(
                berita.imageUrl,
                width: 80,
                height: 80,
                fit: BoxFit.cover,
              ),
              title: Text(
                berita.judul,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(berita.deskripsi),
              // 6. Ubah trailing menjadi IconButton yang interaktif
              trailing: IconButton(
                icon: Icon(
                  isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                  color: isBookmarked ? Colors.blue : null,
                ),
                onPressed: () => _toggleBookmark(berita),
              ),
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Mengalihkan ke halaman detail berita...'),
                    duration: Duration(seconds: 2),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

// 7. Widget  untuk halaman bookmark
class HalamanBookmark extends StatelessWidget {
  final List<Berita> bookmarkedBerita;

  const HalamanBookmark({super.key, required this.bookmarkedBerita});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Berita Tersimpan'),
      ),
      body: bookmarkedBerita.isEmpty
          // Tampilkan pesan jika tidak ada bookmark
          ? const Center(
              child: Text(
                'Belum ada berita yang Anda simpan.',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            )
          // Tampilkan daftar bookmark jika ada
          : ListView.builder(
              itemCount: bookmarkedBerita.length,
              itemBuilder: (context, index) {
                final berita = bookmarkedBerita[index];
                return Card(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  child: ListTile(
                    leading: Image.network(
                      berita.imageUrl,
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                    ),
                    title: Text(berita.judul,
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text(berita.deskripsi),
                  ),
                );
              },
            ),
    );
  }
}