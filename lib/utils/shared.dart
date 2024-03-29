import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';

class Shared {
  static Future<HttpClient> customHttpClient() async {
    SecurityContext context = SecurityContext();
    try {
      List<int> certBytes = [];
      certBytes = (await rootBundle.load('certificate/certificates.pem'))
          .buffer
          .asInt8List();
      debugPrint('bytes: $certBytes');
      context.setTrustedCertificatesBytes(certBytes);
      debugPrint('Success Certificate');
    } on TlsException catch (e) {
      if (e.osError?.message != null &&
          e.osError!.message.contains('CERT_ALREADY_IN_HASH_TABLE')) {
        debugPrint('cert already trusted');
      } else {
        debugPrint('Tls Exception: $e');
        rethrow;
      }
    } catch (e) {
      debugPrint('Error Certificate: $e');
      rethrow;
    }

    HttpClient httpClient = HttpClient(context: context);
    httpClient.badCertificateCallback =
        (X509Certificate cert, String host, int port) {
      return true;
    };
    return httpClient;
  }

  static Future<http.Client> createLEClient() async {
    IOClient client = IOClient(await customHttpClient());
    return client;
  }
}
