import 'package:flutter/material.dart';
import 'package:untitled/stokCikisdao.dart';

class stok_cikis {
  late int id;
  late int urun_id ;
  late int miktar;
  late String tarih;
  late String notlar;

  stok_cikis(this.id,this.urun_id,this.miktar,this.tarih,this.notlar);
}


class stokCikis extends StatefulWidget {
  @override
  _StokCikisState createState() => _StokCikisState();
}

class _StokCikisState extends State<stokCikis> {
  final _formKey = GlobalKey<FormState>();

  int urun_id = 0;
  int miktar = 0;
  String tarih = "";
  String notlar = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(title: Text("Stok Çıkış"),backgroundColor: Colors.amber),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: "Ürün ID"),
                keyboardType: TextInputType.number,
                validator: (value) =>
                value == null || int.tryParse(value) == null
                    ? "Geçerli bir sayı girin"
                    : null,
                onSaved: (value) => urun_id = int.parse(value!),
              ),
              TextFormField(
                decoration: InputDecoration(labelText: "Miktar"),
                keyboardType: TextInputType.number,
                validator: (value) =>
                value == null || int.tryParse(value) == null
                    ? "Geçerli bir sayı girin"
                    : null,
                onSaved: (value) => miktar = int.parse(value!),
              ),
              TextFormField(
                decoration: InputDecoration(labelText: "Tarih"),
                validator: (value) =>
                value == null || value.isEmpty ? "Bu alan zorunludur" : null,
                onSaved: (value) => tarih = value!,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: "Notlar"),
                validator: (value) =>
                value == null || value.isEmpty ? "Bu alan zorunludur" : null,
                onSaved: (value) => notlar = value!,
              ),
              SizedBox(height: 20),
              ElevatedButton.icon(
                icon: Icon(Icons.save),
                label: Text("Kaydet",style: TextStyle(fontSize: 18)),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.amber[300]),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();

                    await stokCikisdao().stokCikis(urun_id, miktar, tarih, notlar);

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Ürün kaydedildi")),
                    );

                    Navigator.pop(context);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
