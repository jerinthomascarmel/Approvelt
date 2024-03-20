import 'package:approvelt/models/request_item_model.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRImage extends StatelessWidget {
  static const String routeName = '/home/display/qr';
  const QRImage({super.key});
  @override
  Widget build(BuildContext context) {
    final RequestItemModel requestItemModel =
        ModalRoute.of(context)!.settings.arguments as RequestItemModel;
    final String username = requestItemModel.nameSentBy;
    final DateTime endDateInDateTime = DateTime.parse(requestItemModel.endDate);
    final String validString =
        requestItemModel.isApproved && endDateInDateTime.isAfter(DateTime.now())
            ? "Valid Now "
            : "Not Valid";

    final vcardData = 'Name :Mr.$username\n'
        '$validString \n';

    return Scaffold(
      appBar: AppBar(
        title: const Text('QR code'),
        centerTitle: true,
      ),
      body: Center(
        child: QrImage(
          data: vcardData,
          version: QrVersions.auto,
          size: 300.0,
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          padding: const EdgeInsets.all(25.0),
        ),
      ),
    );
  }
}
