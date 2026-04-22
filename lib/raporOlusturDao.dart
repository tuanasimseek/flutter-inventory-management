import 'package:untitled/VeriTabaniYardimcisi.dart';
import 'package:untitled/raporOlustur.dart';

class raporOlusturDao {
  // Veritabanındaki en güncel raporu getirir (eski yöntem)
  Future<Rapor?> raporVeriTabanindanGetir() async {
    var db = await VeriTabaniYardimcisi.vtErisim();
    List<Map<String, dynamic>> maps = await db!.rawQuery("SELECT * FROM rapor ORDER BY id DESC LIMIT 1");

    if (maps.isNotEmpty) {
      return Rapor.fromMap(maps.first);
    } else {
      return null;
    }
  }

  // Gerçek zamanlı rapor verilerini hesapla
  Future<Rapor> raporVerileriniGetir() async {
    var db = await VeriTabaniYardimcisi.vtErisim();

    var toplamUrunSorgu = await db!.rawQuery("SELECT COUNT(*) as sayi FROM urunler");
    int toplamUrun = toplamUrunSorgu.first["sayi"] as int;

    var girisSorgu = await db.rawQuery("SELECT SUM(miktar) as toplam FROM stok_giris");
    int stokGiris = girisSorgu.first["toplam"] != null ? girisSorgu.first["toplam"] as int : 0;

    var cikisSorgu = await db.rawQuery("SELECT SUM(miktar) as toplam FROM stok_cikis");
    int stokCikis = cikisSorgu.first["toplam"] != null ? cikisSorgu.first["toplam"] as int : 0;

    var dusukStokSorgu = await db.rawQuery("SELECT COUNT(*) as sayi FROM urunler WHERE stok < 10");
    int dusukStok = dusukStokSorgu.first["sayi"] as int;

    var kritikSeviyeSorgu = await db.rawQuery("SELECT COUNT(*) as sayi FROM urunler WHERE stok < 3");
    int kritikSeviye = kritikSeviyeSorgu.first["sayi"] as int;

    return Rapor(
      id: 0,
      toplamUrun: toplamUrun,
      stokGiris: stokGiris,
      stokCikis: stokCikis,
      dusukStok: dusukStok,
      kritikSeviye: kritikSeviye,
    );
  }

  // İsteğe bağlı: Hesaplanan raporu rapor tablosuna kaydet
  Future<void> raporEkle(Rapor rapor) async {
    var db = await VeriTabaniYardimcisi.vtErisim();
    await db!.insert("rapor", {
      "toplamUrun": rapor.toplamUrun,
      "stokGiris": rapor.stokGiris,
      "stokCikis": rapor.stokCikis,
      "dusukStok": rapor.dusukStok,
      "kritikSeviye": rapor.kritikSeviye,
    });
  }
}
