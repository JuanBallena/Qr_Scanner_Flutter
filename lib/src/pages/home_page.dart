//import 'dart:io';

import 'package:flutter/material.dart';

import 'package:qr_scanner/src/bloc/scans_bloc.dart';

import 'package:qr_scanner/src/models/scan_model.dart';

import 'package:qr_scanner/src/pages/direcciones_page.dart';
import 'package:qr_scanner/src/pages/mapas_dart.dart';

import 'package:qr_scanner/src/utils/scans_util.dart' as utils;

import 'package:barcode_scan/barcode_scan.dart';
//import 'package:qr_scanner/src/providers/db_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final scansBloc = new ScansBloc();

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QR Scanner'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.delete_forever),
            onPressed: scansBloc.borrarScanTodos,
          )
        ]
      ),
      body: _callPage(currentIndex),
      bottomNavigationBar: _crearBottomNavBar(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.filter_center_focus),
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () => _scanQR(context),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked
      
      ,
    );
  }

  _scanQR(BuildContext context) async {
    //https://laravel.com/docs/7.x/readme
    //geo:40.72319227869225,-74.01418104609378

    ScanResult scanResult;
      
    try {
      scanResult = await BarcodeScanner.scan();
    } catch (e) {
      print(e.toString());
    }

    if ( scanResult != null ) {
      final scan = ScanModel( valor: scanResult.rawContent);
      scansBloc.agregarScan(scan);

      utils.abrirScan(context, scan);

      // if ( Platform.isIOS ) {
      //   Future.delayed(Duration( milliseconds: 750 ), () {
      //     utils.abrirScan(context, scan);
      //   });
      // } else {
      //   utils.abrirScan(context, scan);
      // }
    }

  }

  Widget _crearBottomNavBar() {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (index) {
        setState(() {
          currentIndex = index;
        });
      },
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.map),
          title: Text('Map')
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.brightness_5),
          title: Text('Direcciones')
        )
      ]
    );
  }

  Widget _callPage(int paginaActual) {
    switch (paginaActual) {
      case 0: return MapasPage();
      case 1: return DireccionesPage();
      default: return MapasPage();
    }
  }
}