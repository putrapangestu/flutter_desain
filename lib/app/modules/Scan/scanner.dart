import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:aplikasi_scanner/app/core/api_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:shared_preferences/shared_preferences.dart';

class QRViewExample extends StatefulWidget {
  const QRViewExample({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _QRViewExampleState();
}

class _QRViewExampleState extends State<QRViewExample> {
  bool scanning = false;
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  
  final ApiClient _apiClient = ApiClient();

  getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    String? token = prefs.getString('token');
    return token;
  }

  void scanApi(BuildContext context, String? code) async {
    try {
      Response response = await _apiClient.scanner(
        code ?? '', getToken()
      );

      ScaffoldMessenger.of(context).hideCurrentSnackBar();

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Success scann'),
            backgroundColor: Colors.green.shade300,
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: ${response.data['message']}'),
            backgroundColor: Colors.red.shade300,
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $e'),
          backgroundColor: Colors.red.shade300,
        ),
      );
    }
  }

  @override
  void reassemble() {
    super.reassemble();
    if (scanning) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          _buildQrView(context),
          Positioned.fill(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: const EdgeInsets.all(16.0),
                color: Colors.black.withOpacity(0.5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(
                        Icons.arrow_back_ios_new,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                    IconButton(
                      onPressed: () async {
                        if (scanning) {
                          await controller?.resumeCamera();
                        } else {
                          await controller?.stopCamera();
                        }
                        setState(() {
                          scanning = !scanning;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        // ignore: deprecated_member_use
                        primary: scanning ? Colors.grey : Colors.blue,
                      ),
                      icon: Icon(
                        scanning ? Icons.videocam_off : Icons.videocam,
                        size: 30,
                        color: Colors.white,
                      ),
                    ),
                    IconButton(
                      onPressed: () async {
                        await controller?.toggleFlash();
                        setState(() {});
                      },
                      icon: FutureBuilder(
                        future: controller?.getFlashStatus(),
                        builder: (context, snapshot) {
                          if (snapshot.data == true) {
                            return const Icon(
                              Icons.flash_on,
                              color: Colors.white,
                              size: 30,
                            );
                          } else {
                            return const Icon(
                              Icons.flash_off,
                              color: Colors.white,
                              size: 30,
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    return Container(
      constraints: const BoxConstraints.expand(),
      child: AspectRatio(
        aspectRatio: 1.0,
        child: QRView(
          key: qrKey,
          onQRViewCreated: _onQRViewCreated,
          overlay: QrScannerOverlayShape(
            borderColor: const Color.fromARGB(255, 255, 255, 255),
            borderRadius: 10,
            borderLength: 30,
            borderWidth: 10,
          ),
          onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
        ),
      ),
    );
  }

  void _showBarcodeContent(String barcodeContent) {
    FlutterRingtonePlayer.play(fromAsset: 'assets/sound/notifdua.mp3', volume: 0.5,);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding:
                      const EdgeInsets.only(right: 5, left: 10, top: 9, bottom: 5),
                  child: const Text(
                    'ISI BARCODE',
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 25,
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                Text(
                  'Barcode Type : ${describeEnum(result!.format)} \n  Data : ${result!.code}',
                  style: const TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 20,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: Center(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.blue,
                      ),
                      child: TextButton(
                        child: const Text(
                          'Kembali',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        onPressed: () async {
                          await controller?.resumeCamera();
                          // ignore: use_build_context_synchronously
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        if (scanning) {
          return;
        }
        scanning = true;

        result = scanData;
        if (result != null) {
          _showBarcodeContent(
              'Barcode Type: ${describeEnum(result!.format)}   Data: ${result!.code}');
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("Success scan"),
                  backgroundColor: Colors.green.shade300,
                ),
              );
              // scanApi(context,result!.code);
        }
        if (Platform.isAndroid) {
          controller.pauseCamera();

          scanning = false;
        }
      });
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
