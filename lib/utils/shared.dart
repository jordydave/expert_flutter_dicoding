import 'dart:io';

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
      context.setTrustedCertificatesBytes(certBytes);
    } on TlsException catch (e) {
      if (e.osError?.message != null &&
          e.osError!.message.contains('CERT_ALREADY_IN_HASH_TABLE')) {
      } else {
        rethrow;
      }
    } catch (e) {
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
