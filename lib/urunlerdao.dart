import 'package:untitled/VeriTabaniYardimcisi.dart';
import 'package:untitled/urunEkle.dart';

class urunlerdao{
  Future<List<urunler>> tumUrunler() async{
    var db=await VeriTabaniYardimcisi.vtErisim();
    List<Map<String,dynamic>> maps=await db!.rawQuery("Select * from urunler");
    return List.generate(maps.length, (i)
    {
      var satir = maps[i];
      return urunler(satir["id"], satir["ad"], satir["kategori"],satir["stok"]);
    });
  }

  Future<void>urunEkle(String ad,String kategori,int stok) async {
    var db = await VeriTabaniYardimcisi.vtErisim();
    await db!.insert("urunler", {
      "ad": ad,
      "kategori": kategori,
      "stok": stok,
    });
  }
}