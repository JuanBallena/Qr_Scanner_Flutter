import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:qr_scanner/src/models/scan_model.dart';

class MapaPage extends StatefulWidget {

  @override
  _MapaPageState createState() => _MapaPageState();
}

class _MapaPageState extends State<MapaPage> {

  final map = MapController();
  String tipoMapa = 'satellite';

  @override
  Widget build(BuildContext context) {

    final ScanModel scan = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text('Coordenadas'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.my_location),
            onPressed: (){
              map.move( scan.getLatLng(), 15);
            },
          )
        ]
      ),
      body: _crearFlutterMap(scan),
      floatingActionButton: _crearBotonFlotante( context ),
    );
  }

  Widget _crearBotonFlotante(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.repeat),
      backgroundColor: Theme.of(context).primaryColor,
      onPressed: () {
        

        // setState(() {
        //   //streets, dark, light, outdoors, satellite
        //   if ( tipoMapa == 'satellite' ) {
        //     tipoMapa = 'mapbox-streets-v8';
        //   } else if( tipoMapa == 'mapbox-streets-v8' ) {
        //     tipoMapa = 'ligth';
        //   } else if( tipoMapa == 'ligth' ) {
        //     tipoMapa = 'outdoors';
        //   } else if( tipoMapa == 'outdoors' ) {
        //     tipoMapa = 'dark';
        //   } else {
        //     tipoMapa = 'satellite';
        //   }
        // });
      }
    );
  }

  Widget _crearFlutterMap(ScanModel scan) {
    print(scan);
    return FlutterMap(
      mapController: map,
      options: MapOptions(
        center: scan.getLatLng(),
        zoom: 15,
      ),
      layers: [
        _crearMapa(),
        _crearMarcadores( scan ),
      ]
    );
  }

  _crearMapa() {
    return TileLayerOptions(
      urlTemplate: 'https://api.mapbox.com/v4/{tileset_id}/{z}/{x}/{y}@2x.png?access_token={accessToken}',
      additionalOptions: {
        'accessToken':'pk.eyJ1IjoianVhbjkxMSIsImEiOiJja2Q5NzdmcGYwYnk4MnlzZ3ludXZocmViIn0._W8pjjv8gzcctayc7bJZ0A',
        'tileset_id':'mapbox.$tipoMapa'
      }
    );
  }

  _crearMarcadores( ScanModel scan ) {
    return MarkerLayerOptions(
      markers: <Marker>[
        Marker(
          width: 100.0,
          height: 100.0,
          point: scan.getLatLng(),
          builder: ( context ) => Container(
            child: Icon(
              Icons.location_on,
              size: 70.0,
              color: Theme.of(context).primaryColor)
          )
        )
      ]
    );
  }
}