import 'package:flutter/material.dart';
import 'package:untitled/urunlerdao.dart';

class urunler {
  late int id;
  late String ad;
  late String kategori;
  late int stok;

  urunler(this.id,this.ad,this.kategori,this.stok);
}

class urunEkle extends StatefulWidget {
  @override
  _UrunEkleState createState() => _UrunEkleState();
}

class _UrunEkleState extends State<urunEkle> {
  final _formKey = GlobalKey<FormState>();

  String ad = '';
  String kategori = '';
  int stok = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(title: Text("Ürün Ekle"),backgroundColor: Colors.amber),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: "Ürün Adı"),
                validator: (value) =>
                value == null || value.isEmpty ? "Bu alan zorunludur" : null,
                onSaved: (value) => ad = value!,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: "Kategori"),
                onSaved: (value) => kategori = value!,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: "Stok Adedi"),
                keyboardType: TextInputType.number,
                validator: (value) =>
                value == null || int.tryParse(value) == null
                    ? "Geçerli bir sayı girin"
                    : null,
                onSaved: (value) => stok = int.parse(value!),
              ),
              SizedBox(height: 20),
              ElevatedButton.icon(
                icon: Icon(Icons.save),
                label: Text("Kaydet",style: TextStyle(fontSize: 18)),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.amber[300]),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();

                    await urunlerdao().urunEkle(ad, kategori, stok);

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
