// Abstraksi: Obat menjadi class dasar untuk semua jenis obat.
// Class ini tidak dibuat menjadi objek secara langsung.
abstract class Obat {
  // Data umum yang dimiliki setiap obat.
  String nama;
  int harga;
  String indikasi;
  String urlGambar;

  // Constructor untuk mengisi data obat.
  Obat(this.nama, this.harga, this.indikasi, this.urlGambar);

  // Setiap jenis obat memiliki aturan pakai yang berbeda.
  String aturanPakai();

  // Informasi umum yang bisa digunakan oleh semua jenis obat.
  String informasi() {
    return "Harga : Rp $harga\nIndikasi : $indikasi";
  }
}

// Inheritance: ObatSirup mewarisi data dan fungsi dari Obat.
class ObatSirup extends Obat {
  // Data tambahan khusus untuk obat sirup.
  int volumeMl;

  // Mengisi data umum melalui constructor dari Obat.
  ObatSirup(
    String nama,
    int harga,
    String indikasi,
    String urlGambar,
    this.volumeMl,
  ) : super(nama, harga, indikasi, urlGambar);

  // Polimorfisme: aturan pakai disesuaikan untuk obat sirup.
  @override
  String aturanPakai() {
    return "Kocok dahulu sebelum diminum. Gunakan sendok takar. (Isi: $volumeMl ml)";
  }
}

// Inheritance: ObatTablet mewarisi data dan fungsi dari Obat.
class ObatTablet extends Obat {
  // Data tambahan khusus untuk obat tablet.
  int jumlahButir;

  // Mengisi data umum melalui constructor dari Obat.
  ObatTablet(
    String nama,
    int harga,
    String indikasi,
    String urlGambar,
    this.jumlahButir,
  ) : super(nama, harga, indikasi, urlGambar);

  // Polimorfisme: aturan pakai disesuaikan untuk obat tablet.
  @override
  String aturanPakai() {
    return "Diminum dengan air putih setelah makan. (Isi: $jumlahButir butir)";
  }
}

// Inheritance: ObatSalep mewarisi data dan fungsi dari Obat.
class ObatSalep extends Obat {
  // Data tambahan khusus untuk obat salep.
  int beratGram;

  // Mengisi data umum melalui constructor dari Obat.
  ObatSalep(
    String nama,
    int harga,
    String indikasi,
    String urlGambar,
    this.beratGram,
  ) : super(nama, harga, indikasi, urlGambar);

  // Polimorfisme: aturan pakai disesuaikan untuk obat salep.
  @override
  String aturanPakai() {
    return "Oleskan tipis-tipis pada area yang sakit/luka luar. (Berat: $beratGram gram)";
  }
}
