import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class Scanner extends StatefulWidget{
  @override
  ScannerState createState() => ScannerState();
}

class ScannerState extends State<Scanner> {
  String _scanBarcode = 'Unknown';

  Future<void> scanQR() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      FlutterBarcodeScanner.getBarcodeStreamReceiver(
          "#00466b", "Cancel", false, ScanMode.QR)
          .listen((qrcode) {
        print(qrcode.toString().substring(0, 5));
      });
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _scanBarcode = barcodeScanRes;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: InkWell(
          onTap: (){
            scanQR();
          },
          child: Container(
            child: Center(child:Text("Click to Scan",style: TextStyle(color: Colors.white,fontSize: 30,fontWeight: FontWeight.w700),),),
            height: double.infinity,
            width: double.infinity,
            margin: EdgeInsets.all(90),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xff00466b),
            ),

          ),
        )
      ),
    );
  }
}