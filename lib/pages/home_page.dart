import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_scanner/models/scan_model.dart';
import 'package:qr_scanner/pages/direcciones_page.dart';
import 'package:qr_scanner/pages/mapas_page.dart';
import 'package:qr_scanner/providers/db_providers.dart';
import 'package:qr_scanner/providers/ui_provider.dart';
import 'package:qr_scanner/widgets/custom_navigator.dart';
import 'package:qr_scanner/widgets/scan_button.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Historial'), elevation: 0, actions: [
          IconButton(
            icon: const Icon(Icons.delete_forever),
            onPressed: () {},
          )
        ]),
        body: const _HomePageBody(),
        bottomNavigationBar: const CustomNavigationBar(),
        floatingActionButton: const ScanButton(),
        floatingActionButtonLocation:
            FloatingActionButtonLocation.centerDocked);
  }
}

class _HomePageBody extends StatelessWidget {
  const _HomePageBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Obtener el selectedMenuOpt del provider
    final uiProvider = Provider.of<UiProvider>(
        context); //obtener el provider de la clase UiProvider

    // Cambiar para mostrar la página respectiva
    final currentIndex = uiProvider.selectedMenuOpt;

    //!temporal: leer la base de datos
    final tempScan = ScanModel(valor: 'http://google.com');
    DBProvider.db.nuevoScan(tempScan);

    switch (currentIndex) {
      case 0:
        return const MapasPage();
      case 1:
        return const DireccionesPage();
      default:
        return const MapasPage();
    }
  }
}
