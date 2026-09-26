import 'package:flutter_test/flutter_test.dart';
import 'package:uts_pbo/main.dart';

void main() {
  testWidgets('app shows empty daftar obat screen', (tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('Katalog Apotek Obat'), findsOneWidget);
    expect(find.text('Belum ada data obat.'), findsOneWidget);
  });
}
