import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_scanner/providers/scan_list_provider.dart';

class MapasPage extends StatelessWidget {
  const MapasPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final scanListProvider = Provider.of<ScanListProvider>(
      context,
    );

    final scans = scanListProvider.scans;

    return ListView.builder(
      itemCount: scans.length,
      itemBuilder: (_, i) => Dismissible(
        key: UniqueKey(),
        background: Container(
          color: Colors.red,
        ),
        onDismissed: (DismissDirection direction) {
          Provider.of<ScanListProvider>(context, listen: false)
              .borrarScanPorId(scans[i].id!);
        }, //! impacta en la base de datos
        child: ListTile(
            leading: const Icon(Icons.map, color: Colors.deepPurple),
            title: Text(scans[i].valor),
            subtitle: Text(scans[i].id.toString()),
            trailing: const Icon(Icons.keyboard_arrow_right,
                color: Colors.grey), // indicador de que se puede hacer tap
            onTap: () => print(scans[i].id)),
      ),
    );
  }
}
