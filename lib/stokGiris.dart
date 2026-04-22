import 'package:flutter/material.dart';
import 'package:untitled/stokGirisdao.dart';

class stok_giris {
  late int id;
  late int urun_id ;
  late int miktar;
  late String tarih;
  late String notlar;

  stok_giris(this.id,this.urun_id,this.miktar,this.tarih,this.notlar);
}

class stokGiris extends StatefulWidget {
  @override
  _StokGirisState createState() => _StokGirisState();
}

class _StokGirisState extends State<stokGiris> {
  final _formKey = GlobalKey<FormState>();

  int urun_id = 0;
  int miktar = 0;
  String tarih = "";
  String notlar = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(title: Text("Stok Giriş"),backgroundColor: Colors.amber),
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

                    await stokGirisdao().stokGiris(urun_id, miktar, tarih, notlar);

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
