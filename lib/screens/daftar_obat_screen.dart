import 'package:flutter/material.dart';
import '../models/obat.dart';
import 'form_tambah_obat.dart';

class DaftarObatScreen extends StatefulWidget {
  const DaftarObatScreen({super.key});

  @override
  State createState() => _DaftarObatScreenState();
}

class _DaftarObatScreenState extends State {
  final List _daftarObat = [];

  void _tambahObat(Obat obatBaru) {
    setState(() {
      _daftarObat.add(obatBaru);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // SEDIKIT TAMBAHAN DESAIN NAVBAR
      appBar: AppBar(
        toolbarHeight: 70,
        backgroundColor: Colors.teal.shade700,
        elevation: 4,
        shadowColor: Colors.teal.withOpacity(0.5),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(0)),
        ),
        leading: const Icon(
          Icons.local_pharmacy,
          color: Colors.white,
          size: 28,
        ),
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Apotek Sehat",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
                color: Colors.white,
              ),
            ),
            Text(
              "Katalog Obat Digital",
              style: TextStyle(
                fontSize: 13,
                color: Colors.white70,
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.white),
            tooltip: 'Cari Obat',
            onPressed: () {
              // TODO: Fitur pencarian
            },
          ),
          IconButton(
            icon: const Icon(Icons.notifications_none, color: Colors.white),
            tooltip: 'Notifikasi',
            onPressed: () {
              // TODO: Fitur notifikasi
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      // DESAIAN TAMBAHAN SELESAI

      body: _daftarObat.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.local_pharmacy, size: 80, color: Colors.grey[400]),
                  const SizedBox(height: 16),
                  Text(
                    "Belum ada data obat.",
                    style: TextStyle(fontSize: 18, color: Colors.grey[600]),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _daftarObat.length,
              itemBuilder: (context, index) {
                Obat obat = _daftarObat[index];
                return Card(
                  elevation: 2,
                  margin: const EdgeInsets.only(bottom: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(16),
                        ),
                        child: obat.urlGambar.isNotEmpty
                            ? Image.network(
                                obat.urlGambar,
                                height: 180,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) =>
                                    Container(
                                      height: 180,
                                      color: Colors.grey[300],
                                      child: const Icon(
                                        Icons.broken_image,
                                        size: 50,
                                        color: Colors.grey,
                                      ),
                                    ),
                              )
                            : Container(
                                height: 180,
                                color: Colors.green[100],
                                child: const Icon(
                                  Icons.medication,
                                  size: 50,
                                  color: Colors.green,
                                ),
                              ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              obat.nama,
                              style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              obat.informasi(),
                              style: TextStyle(
                                color: Colors.grey[800],
                                height: 1.5,
                              ),
                            ),
                            const Divider(height: 24),
                            _buildInfoRow(
                              Icons.medical_information,
                              "Aturan Pakai",
                              obat.aturanPakai(),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          // Buka layar FormTambahObat
          final Obat? obatBaru = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const FormTambahObat()),
          );

          if (obatBaru != null) {
            _tambahObat(obatBaru);
          }
        },
        icon: const Icon(Icons.add),
        label: const Text("Tambah Obat"),
        backgroundColor: Colors.teal,
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String title, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 20, color: Colors.teal),
        const SizedBox(width: 8),
        Expanded(
          child: RichText(
            text: TextSpan(
              style: const TextStyle(color: Colors.black87, fontSize: 14),
              children: [
                TextSpan(
                  text: "$title:\n",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                TextSpan(text: value, style: const TextStyle(height: 1.5)),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
