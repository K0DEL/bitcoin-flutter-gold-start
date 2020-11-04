import 'dart:convert';
import 'package:http/http.dart' as http;

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

const coinAPIURL = 'https://rest.coinapi.io/v1/exchangerate';
const apiKey = 'FA663ABF-CF95-4184-ACE2-FA9B6CAAE76A';

class CoinData {
  Future getCoinData(String selectedCurrency) async {
    Map <String, String> lastPriceList = {};
    String requestURL;
    var decodedData;
    double lastPrice;
    //TODO 4: Use a for loop here to loop through the cryptoList and request the data for each of them in turn.
    for (int i=0;i<cryptoList.length;i++){

      requestURL = '$coinAPIURL/${cryptoList[i]}/$selectedCurrency?apikey=$apiKey';

      http.Response response = await http.get(requestURL);

      if (response.statusCode == 200) {
        decodedData = jsonDecode(response.body);
        lastPrice = decodedData['rate'];
        lastPriceList[cryptoList[i]] = lastPrice.toStringAsFixed(0);

      } else {
        print(response.statusCode);
        throw 'Problem with the get request';
      }
    }
    //TODO 5: Return a Map of the results instead of a single value.
    return lastPriceList;
  }
}
