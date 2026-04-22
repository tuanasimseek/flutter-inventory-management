import 'package:flutter/material.dart';
import 'urunEkle.dart';
import 'stokGiris.dart';
import 'stokCikis.dart';
import 'raporOlustur.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mağaza Envanter Takibi',
      home: const MyHomePage(title: 'Mağaza Envanter Takibi'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    double ekranGenislik = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text(widget.title, style: const TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.amber,
      ),
      body: Padding(
        padding: const EdgeInsets.all(0),
        child: Column(
          children: [
            Image.asset(
              "resimler/anaSayfa3.jpg",
              width: ekranGenislik * 2.0,
              fit: BoxFit.contain,
            ),
            SizedBox(height: 20),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  children: [
                    anaButon(
                      renk: Colors.cyan.shade400,
                      ikon: Icons.add_box,
                      baslik: "Ürün Ekle",
                      hedef: urunEkle(),
                    ),
                    anaButon(
                      renk: Colors.red.shade400,
                      ikon: Icons.arrow_downward,
                      baslik: "Stok Giriş",
                      hedef: stokGiris(),
                    ),
                    anaButon(
                      renk: Colors.orangeAccent.shade400,
                      ikon: Icons.arrow_upward,
                      baslik: "Stok Çıkış",
                      hedef: stokCikis(),
                    ),
                    anaButon(
                      renk: Colors.teal.shade400,
                      ikon: Icons.analytics,
                      baslik: "Rapor Oluştur",
                      hedef: const RaporOlustur(),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget anaButon({
    required Color renk,
    required IconData ikon,
    required String baslik,
    required Widget hedef,
  }) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (_) => hedef));
      },
      child: Container(
        decoration: BoxDecoration(
          color: renk,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 6,
              offset: const Offset(2, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(ikon, color: Colors.white, size: 48),
            const SizedBox(height: 12),
            Text(
              baslik,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
      ),
    );
  }
}
