import 'package:untitled/VeriTabaniYardimcisi.dart';
import 'package:untitled/stokGiris.dart';

class stokGirisdao{
  Future<List<stok_giris>> tumStok() async{
    var db=await VeriTabaniYardimcisi.vtErisim();
    List<Map<String,dynamic>> maps=await db!.rawQuery("Select * from stok_giris");
    return List.generate(maps.length, (i)
    {
      var satir = maps[i];
      return stok_giris(satir["id"], satir["urun_id"], satir["miktar"],satir["tarih"],satir["notlar"]);
    });
  }
  Future<void>stokGiris(int urun_id,int miktar,String tarih,String notlar) async {
    var db = await VeriTabaniYardimcisi.vtErisim();
    await db!.insert("stok_giris", {
      "urun_id" : urun_id,
      "miktar" : miktar,
      "tarih" : tarih,
      "notlar" : notlar,
    });
  }
}