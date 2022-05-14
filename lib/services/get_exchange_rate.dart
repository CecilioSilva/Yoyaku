import 'dart:convert';
import 'dart:io';
import 'package:xml/xml.dart';

Future<Map> getExchange() async {
  final HttpClient httpClient = HttpClient();
  const uri = r'https://www.ecb.europa.eu/stats/eurofxref/eurofxref-daily.xml';
  final request = await httpClient.getUrl(Uri.parse(uri));
  final response = await request.close();
  final stream = response.transform(utf8.decoder);
  final contents = await stream.join();
  final document = XmlDocument.parse(contents);

  Map rates = {};
  document.findAllElements('Cube').forEach(
    (element) {
      if (element.children.isNotEmpty) {
        for (var p0 in element.children) {
          if (p0.getAttribute('currency') != null) {
            rates[p0.getAttribute('currency')] = double.parse(
              p0.getAttribute('rate') ?? '1',
            );
          }
        }
      }
    },
  );

  rates['EUR'] = 1.0;

  return rates;
}

Map initalRates = {
  'USD': 1.0583,
  'JPY': 135.57,
  'BGN': 1.9558,
  'CZK': 24.55,
  'DKK': 7.441,
  'GBP': 0.84215,
  'HUF': 379.74,
  'PLN': 4.7043,
  'RON': 4.948,
  'SEK': 10.4035,
  'CHF': 1.0229,
  'ISK': 138.2,
  'NOK': 9.7838,
  'HRK': 7.565,
  'TRY': 15.6857,
  'AUD': 1.4828,
  'BRL': 5.3045,
  'CAD': 1.3572,
  'CNY': 6.9377,
  'HKD': 8.3045,
  'IDR': 15259.86,
  'ILS': 3.5178,
  'INR': 81.0705,
  'KRW': 1341.98,
  'MXN': 21.6259,
  'MYR': 4.6142,
  'NZD': 1.6118,
  'PHP': 55.195,
  'SGD': 1.4602,
  'THB': 36.331,
  'ZAR': 16.8406,
  'EUR': 1.0,
};
