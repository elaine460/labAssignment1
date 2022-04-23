import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class BTCScreen extends StatelessWidget {
  const BTCScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        backgroundColor: const Color.fromARGB(255, 119, 133, 214),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(10, 40, 10, 5),
          child: Column(
            children: [
              Flexible(
                flex: 3,
                child: Image.asset('assets/images/mylogo.png', scale: 2.5),
              ),
              const Flexible(
                flex: 7,
                child: BTCForm(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BTCForm extends StatefulWidget {
  const BTCForm({Key? key}) : super(key: key);

  @override
  State<BTCForm> createState() => _BTCFormState();
}

class _BTCFormState extends State<BTCForm> {
  TextEditingController amountEditingController = TextEditingController();
  String toCurrency = "eth",
      output = "",
      totalInput = " ",
      statement = " ",
      description = "No data available",
      result = "";
  var name = " ", unit = " ", type = " ", baseUnit = " ";
  double amount = 0.0, value = 0.0, baseCurrency = 0.0;
  List<String> currencyList = [
    //Crypto Currency,
    //"btc",
    "eth",
    "ltc",
    "bch",
    "bnb",
    "eos",
    "xrp",
    "xlm",
    "link",
    "dot",
    "yfi",
    "bits",
    "sats",
    //"Fiat Money",
    "usd",
    "aed",
    "ars",
    "aud",
    "bdt",
    "bhd",
    "bmd",
    "brl",
    "cad",
    "chf",
    "clp",
    "cny",
    "czk",
    "dkk",
    "eur",
    "gbp",
    "hkd",
    "huf",
    "idr",
    "ils",
    "inr",
    "jpy",
    "krw",
    "kwd",
    "lkr",
    "mmk",
    "mxn",
    "myr",
    "ngn",
    "nok",
    "nzd",
    "php",
    "pkr",
    "pln",
    "rub",
    "sar",
    "sek",
    "sgd",
    "thb",
    "try",
    "twd",
    "uah",
    "vef",
    "vnd",
    "zar",
    "xdr",
    //"Commodity",
    "xag",
    "xau",
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const Text(
            "BTC Currency Converter",
            style: TextStyle(
                fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          const SizedBox(height: 25),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 2, 16, 0),
            child: TextField(
              controller: amountEditingController,
              keyboardType: const TextInputType.numberWithOptions(),
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: "enter a value",
                hintStyle: const TextStyle(color: Colors.grey, fontSize: 18),
                suffixText: "btc",
                suffixStyle: const TextStyle(color: Colors.black, fontSize: 18),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
          ),
          const SizedBox(height: 14),
          Padding(
            padding: const EdgeInsets.fromLTRB(50, 6, 20, 6),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                DropdownButton(
                  itemHeight: null,
                  value: toCurrency,
                  onChanged: (newValue) {
                    setState(() {
                      toCurrency = newValue.toString();
                    });
                  },
                  items: currencyList.map((toCurrency) {
                    return DropdownMenuItem(
                      child: Text(toCurrency,
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                      value: toCurrency,
                    );
                  }).toList(),
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Colors.green,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 15)),
                    onPressed: _loadCurrency,
                    child: const Text("Convert", style: TextStyle(fontSize: 18))),
              ],
            ),
          ),
          const SizedBox(height: 20),
          SingleChildScrollView(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              width: 358,
              height: 200,
              padding: const EdgeInsets.fromLTRB(10, 15, 10, 5),
              child: Column(
                children: [
                  const Text("Result", style: TextStyle(fontSize: 22)),
                  const SizedBox(height: 16),
                  Text(statement, style: const TextStyle(fontSize: 20)),
                  const SizedBox(height: 12),
                  Text(result, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),textAlign: TextAlign.center),
                  const SizedBox(height: 22),
                  Text(description, style: const TextStyle(fontSize: 18),textAlign: TextAlign.center),
                  
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _loadCurrency() async {
    var url = Uri.parse('https://api.coingecko.com/api/v3/exchange_rates');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonData = response.body;
      var parsedData = json.decode(jsonData);
      baseCurrency = parsedData['rates']['btc']['value'];
      baseUnit = parsedData['rates']['btc']['unit'];
      value = parsedData['rates'][toCurrency]['value'];
      unit = parsedData['rates'][toCurrency]['unit'];
      name = parsedData['rates'][toCurrency]['name'];
      type = parsedData['rates'][toCurrency]['type'];

      setState(() {
        statement = "$baseCurrency $baseUnit = $value $unit";
        amount = double.parse(amountEditingController.text);
        output = (baseCurrency * value * amount).toStringAsFixed(2);

        totalInput  = (baseCurrency * amount).toStringAsFixed(2);
        result = "$totalInput $baseUnit = $output $unit";

        if (type == "crypto") {
          description = "$name is $type currency ";
        } else if (type == "fiat") {
          description = "$name is $type money";
        } else if (type == "commodity") {
          description = "$name is $type";
        }
      });
    }
  }
}
