import 'package:flutter/material.dart';

import '../models/obat.dart';

class FormTambahObat extends StatefulWidget {
  const FormTambahObat({super.key});

  @override
  State<FormTambahObat> createState() => _FormTambahObatState();
}

class _FormTambahObatState extends State<FormTambahObat> {
  // Key untuk mengecek validasi semua input dalam Form.
  final _formKey = GlobalKey<FormState>();

  // Controller untuk mengambil dan menyimpan input pengguna.
  final _namaController = TextEditingController();
  final _hargaController = TextEditingController();
  final _indikasiController = TextEditingController();
  final _gambarController = TextEditingController();
  final _atributKhususController = TextEditingController();

  String _jenisObat = 'Sirup';

  // Menghapus Controller saat halaman ditutup untuk mencegah memory leak.
  @override
  void dispose() {
    _namaController.dispose();
    _hargaController.dispose();
    _indikasiController.dispose();
    _gambarController.dispose();
    _atributKhususController.dispose();
    super.dispose();
  }

  void _simpanData() {
    // Menjalankan validasi Form.
    if (_formKey.currentState?.validate() ?? false) {
      Obat obatBaru;

      // Mengambil data dari Controller.
      String nama = _namaController.text;
      int harga = int.parse(
        _hargaController.text,
      ); // Mengubah teks menjadi angka.
      String indikasi = _indikasiController.text;
      String gambar = _gambarController.text;
      int atributKhusus = int.parse(_atributKhususController.text);

      // [INSTANSIASI OBJEK]
      // Membuat objek sesuai jenis obat yang dipilih.
      if (_jenisObat == 'Sirup') {
        obatBaru = ObatSirup(nama, harga, indikasi, gambar, atributKhusus);
      } else if (_jenisObat == 'Tablet') {
        obatBaru = ObatTablet(nama, harga, indikasi, gambar, atributKhusus);
      } else {
        obatBaru = ObatSalep(nama, harga, indikasi, gambar, atributKhusus);
      }

      // [NAVIGASI & PENGIRIMAN DATA]
      // Menutup form dan mengirim objek obatBaru ke halaman sebelumnya.
      Navigator.pop(context, obatBaru);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Tambah Data Obat",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Colors.white,
            letterSpacing: 1.5,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.teal.shade700,
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 4,
        shadowColor: Colors.teal.withOpacity(0.4),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(0)),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey, // Menghubungkan Key dengan Form.
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              DropdownButtonFormField(
                initialValue: _jenisObat,
                decoration: _inputStyle("Jenis Obat", Icons.category_outlined),
                items: ['Sirup', 'Tablet', 'Salep']
                    .map(
                      (jenis) =>
                          DropdownMenuItem(value: jenis, child: Text(jenis)),
                    )
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _jenisObat = value!;
                    _atributKhususController
                        .clear(); // Menghapus input atribut saat jenis berubah.
                  });
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _namaController, // Menghubungkan Controller.
                decoration: _inputStyle("Nama Obat", Icons.medication_outlined),
                // Validasi nama tidak boleh kosong.
                validator: (value) =>
                    value!.isEmpty ? 'Nama tidak boleh kosong' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _hargaController,
                keyboardType: TextInputType.number,
                decoration: _inputStyle(
                  "Harga (Rp)",
                  Icons.attach_money_outlined,
                ),
                validator: (value) {
                  if (value!.isEmpty) return 'Harga tidak boleh kosong';
                  if (int.tryParse(value) == null) return 'Harus berupa angka';
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _indikasiController,
                decoration: _inputStyle(
                  "Indikasi / Kegunaan",
                  Icons.health_and_safety_outlined,
                ),
                validator: (value) =>
                    value!.isEmpty ? 'Indikasi tidak boleh kosong' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _gambarController,
                decoration: _inputStyle("URL Gambar Obat", Icons.image_search),
                validator: (value) =>
                    value!.isEmpty ? 'URL tidak boleh kosong' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _atributKhususController,
                keyboardType: TextInputType.number,
                decoration: _inputStyle(
                  // Label berubah sesuai jenis obat.
                  _jenisObat == 'Sirup'
                      ? "Volume (ml)"
                      : _jenisObat == 'Tablet'
                      ? "Jumlah Butir"
                      : "Berat (gram)",
                  Icons.info_outlined,
                ),
                validator: (value) {
                  if (value!.isEmpty) return 'Atribut ini wajib diisi';
                  if (int.tryParse(value) == null) return 'Harus berupa angka';
                  return null;
                },
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed:
                    _simpanData, // Menjalankan fungsi simpan saat diklik.
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  backgroundColor: Colors.teal,
                ),
                child: const Text(
                  "SIMPAN OBAT",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 1.5,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Membuat style input agar semua field memiliki tampilan yang sama.
  InputDecoration _inputStyle(String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon, color: Colors.teal),
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.teal, width: 2),
      ),
    );
  }
}
