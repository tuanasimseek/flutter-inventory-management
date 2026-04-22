import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io';
import 'package:flutter/services.dart';

class VeriTabaniYardimcisi{
  static final String VeriTabaniAdi="envanter.sqlite";
  static Future<Database?>vtErisim() async{
    String veritabaniyolu=join(await getDatabasesPath(),VeriTabaniAdi);
    print("Veritabanı yolu: $veritabaniyolu");
    if (await databaseExists(veritabaniyolu)){
      print("Database var,kopyalamaya gerek yok");
    }
    else {
      ByteData data=await rootBundle.load("assets/DB/$VeriTabaniAdi");
      List<int>bytes=data.buffer.asUint8List(data.offsetInBytes,data.lengthInBytes);
      await File(veritabaniyolu).writeAsBytes(bytes,flush: true);
      print("Veri tabani kopyalandi");
    }
    return openDatabase(veritabaniyolu);
  }

}