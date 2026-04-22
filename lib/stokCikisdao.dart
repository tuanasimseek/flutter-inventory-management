import 'package:untitled/VeriTabaniYardimcisi.dart';
import 'package:untitled/stokCikis.dart';

class stokCikisdao{
  Future<List<stok_cikis>> tumStok() async{
    var db=await VeriTabaniYardimcisi.vtErisim();
    List<Map<String,dynamic>> maps=await db!.rawQuery("Select * from stok_cikis");
    return List.generate(maps.length, (i)
    {
      var satir = maps[i];
      return stok_cikis(satir["id"], satir["urun_id"], satir["miktar"],satir["tarih"],satir["notlar"]);
    });
  }
  Future<void>stokCikis(int urun_id,int miktar,String tarih,String notlar) async {
    var db = await VeriTabaniYardimcisi.vtErisim();
    await db!.insert("stok_cikis", {
      "urun_id" : urun_id,
      "miktar" : miktar,
      "tarih" : tarih,
      "notlar" : notlar,
    });
  }
}