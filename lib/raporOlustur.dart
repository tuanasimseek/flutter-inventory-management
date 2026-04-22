import 'package:flutter/material.dart';
import 'raporOlusturDao.dart';

class Rapor {
  int id;
  int toplamUrun;
  int stokGiris;
  int stokCikis;
  int dusukStok;
  int kritikSeviye;

  Rapor({
    required this.id,
    required this.toplamUrun,
    required this.stokGiris,
    required this.stokCikis,
    required this.dusukStok,
    required this.kritikSeviye,
  });

  factory Rapor.fromMap(Map<String, dynamic> map) {
    return Rapor(
      id: map["id"],
      toplamUrun: map["toplamUrun"],
      stokGiris: map["stokGiris"],
      stokCikis: map["stokCikis"],
      dusukStok: map["dusukStok"],
      kritikSeviye: map["kritikSeviye"],
    );
  }
}

class RaporOlustur extends StatefulWidget {
  const RaporOlustur({super.key});

  @override
  State<RaporOlustur> createState() => _RaporOlusturState();
}

class _RaporOlusturState extends State<RaporOlustur> {
  Rapor? raporVerisi;

  @override
  void initState() {
    super.initState();
    _verileriYukle();
  }

  void _verileriYukle() async {
    var dao = raporOlusturDao();
    var veri = await dao.raporVerileriniGetir(); // GERÇEK ZAMANLI sorgu
    setState(() {
      raporVerisi = veri;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text("Rapor Oluştur"),
        backgroundColor: Colors.amber,
      ),
      body: raporVerisi == null
          ? const Center(child: CircularProgressIndicator())
          : Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Stok Durumu",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            _raporSatiri("Toplam Ürün Sayısı", raporVerisi!.toplamUrun.toString()),
            _raporSatiri("Stok Girişi Yapılan", raporVerisi!.stokGiris.toString()),
            _raporSatiri("Stok Çıkışı Yapılan", raporVerisi!.stokCikis.toString()),
            _raporSatiri("Düşük Stoklu Ürünler", raporVerisi!.dusukStok.toString()),
            _raporSatiri("Kritik Seviye Altı", raporVerisi!.kritikSeviye.toString()),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _raporSatiri(String baslik, String deger) {
    return Card(
      child: ListTile(
        leading: const Icon(Icons.analytics),
        title: Text(baslik),
        trailing: Text(deger, style: const TextStyle(fontWeight: FontWeight.bold)),
      ),
    );
  }
}
