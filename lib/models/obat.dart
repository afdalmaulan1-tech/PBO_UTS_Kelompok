// =========================================================================
// [KONSEP 1: ABSTRAKSI]
// Membuat blueprint dasar yang wajib dimiliki semua jenis obat.
// Tidak dapat dibuat objek langsung.
// =========================================================================
abstract class Obat {
  // Atribut umum yang dimiliki semua obat.
  String nama;
  int harga;
  String indikasi;
  String urlGambar;

  // Constructor untuk menerima data obat.
  Obat(this.nama, this.harga, this.indikasi, this.urlGambar);

  // Method abstrak: wajib diisi oleh class turunan.
  String aturanPakai();

  // Method konkret: sudah memiliki isi dan dapat digunakan class turunan.
  String informasi() {
    return "Harga : Rp $harga\nIndikasi : $indikasi";
  }
}

// =========================================================================
// [KONSEP 2 & 3: INHERITANCE & POLIMORFISME]
// =========================================================================

// INHERITANCE: ObatSirup mewarisi atribut dan method dari Obat.
class ObatSirup extends Obat {
  // Atribut khusus untuk obat sirup.
  int volumeMl;

  // Constructor menggunakan super untuk mengisi data dari Obat.
  ObatSirup(
    String nama,
    int harga,
    String indikasi,
    String urlGambar,
    this.volumeMl,
  ) : super(nama, harga, indikasi, urlGambar);

  // POLIMORFISME: aturanPakai memiliki implementasi khusus untuk sirup.
  @override
  String aturanPakai() {
    return "Kocok dahulu sebelum diminum. Gunakan sendok takar. (Isi: $volumeMl ml)";
  }
}

// INHERITANCE: ObatTablet mewarisi atribut dan method dari Obat.
class ObatTablet extends Obat {
  // Atribut khusus untuk obat tablet.
  int jumlahButir;

  // Constructor menggunakan super untuk mengisi data dari Obat.
  ObatTablet(
    String nama,
    int harga,
    String indikasi,
    String urlGambar,
    this.jumlahButir,
  ) : super(nama, harga, indikasi, urlGambar);

  // POLIMORFISME: aturanPakai memiliki implementasi khusus untuk tablet.
  @override
  String aturanPakai() {
    return "Diminum dengan air putih setelah makan. (Isi: $jumlahButir butir)";
  }
}

// INHERITANCE: ObatSalep mewarisi atribut dan method dari Obat.
class ObatSalep extends Obat {
  // Atribut khusus untuk obat salep.
  int beratGram;

  // Constructor menggunakan super untuk mengisi data dari Obat.
  ObatSalep(
    String nama,
    int harga,
    String indikasi,
    String urlGambar,
    this.beratGram,
  ) : super(nama, harga, indikasi, urlGambar);

  // POLIMORFISME: aturanPakai memiliki implementasi khusus untuk salep.
  @override
  String aturanPakai() {
    return "Oleskan tipis-tipis pada area yang sakit/luka luar. (Berat: $beratGram gram)";
  }
}
