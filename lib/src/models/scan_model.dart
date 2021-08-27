import 'package:latlong/latlong.dart';

class ScanModel {
  
  int id;
  String tipo;
  String valor;

  ScanModel({
    this.id,
    this.tipo,
    this.valor,
  }) {
    if (this.valor.contains('http')) {
      this.tipo = 'http';
    } else {
      this.tipo = 'geo';
    }
  }

  factory ScanModel.fromJson(Map<String, dynamic> json) => new ScanModel(
    id    : json["id"],
    tipo  : json["tipo"],
    valor : json["valor"],
  );

  Map<String, dynamic> toJson() => {
    "id"    : id,
    "tipo"  : tipo,
    "valor" : valor,
  };

  //geo:40.72319227869225,-74.01418104609378
  LatLng getLatLng() {
     final lalo = valor.substring(4).split(',');
     final lat = double.parse( lalo[0] );
     final lng = double.parse( lalo[1] );

     return LatLng( lat, lng );
  }

}
