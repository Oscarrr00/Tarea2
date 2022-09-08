import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

enum serviceQuality { Amazing, Good, Ok }

class _HomePageState extends State<HomePage> {
  // TODO: completar todo lo necesario
  var costController = TextEditingController();
  serviceQuality? selected = serviceQuality.Amazing;
  bool switched = false;
  double total = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Tip time'), backgroundColor: Colors.green),
      body: ListView(
        children: [
          SizedBox(height: 14),
          ListTile(
            leading: Icon(Icons.add_business, color: Colors.green),
            title: Padding(
              padding: EdgeInsets.only(right: 24),
              child: TextField(
                  controller: costController,
                  decoration: InputDecoration(
                    labelStyle: TextStyle(color: Colors.green),
                    focusedBorder: new OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.green, width: 3),
                    ),
                    label: Text("Cost of Service",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  )),
            ),
          ),
          ListTile(
            leading: Icon(Icons.room_service, color: Colors.green),
            title: Text("How was the service?"),
          ),
          ListTile(
            title: Text("Amazing (20%)"),
            leading: Radio<serviceQuality>(
              activeColor: Colors.green,
              value: serviceQuality.Amazing,
              groupValue: selected,
              onChanged: (serviceQuality? value) {
                setState(() {
                  selected = value;
                });
              },
            ),
          ),
          ListTile(
            title: Text("Good (18%)"),
            leading: Radio<serviceQuality>(
              activeColor: Colors.green,
              value: serviceQuality.Good,
              groupValue: selected,
              onChanged: (serviceQuality? value) {
                setState(() {
                  selected = value;
                });
              },
            ),
          ),
          ListTile(
            title: Text("Ok (15%)"),
            leading: Radio<serviceQuality>(
              activeColor: Colors.green,
              value: serviceQuality.Ok,
              groupValue: selected,
              onChanged: (serviceQuality? value) {
                setState(() {
                  selected = value;
                });
              },
            ),
          ),
          ListTile(
            leading: Icon(Icons.call_made, color: Colors.green),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Round up tip?"),
                Switch(
                    activeColor: Colors.green,
                    value: switched,
                    onChanged: (value) {
                      switched = !switched;
                      setState(() {});
                    }),
              ],
            ),
          ),
          ListTile(
            leading: SizedBox(),
            title: MaterialButton(
              textColor: Colors.white,
              color: Colors.green,
              child: Text("CALCULATE"),
              onPressed: () {
                if (costController.text == '') {
                  _showMyDialog();
                } else {
                  _tipCalculation();
                }
                setState(() {});
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 15, top: 15),
            child: Text(
              "Tip Amount: \$ ${total.toStringAsFixed(2)}",
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }

  void _tipCalculation() {
    double cost = double.parse(costController.text);
    double cost_service = 0;
    switch (selected) {
      case serviceQuality.Amazing:
        cost_service = cost + cost * .20;
        break;
      case serviceQuality.Good:
        cost_service = cost + cost * .18;
        break;
      case serviceQuality.Ok:
        cost_service = cost + cost * .15;
        break;
      default:
        cost_service = 0;
    }
    if (switched) {
      total = cost_service.ceil().toDouble();
    } else {
      total = cost_service;
    }
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('No escribio nada en el cuadro de texto'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text(
                    'Por favor escriba algo en el cuadro de texto para que funcione correctamente'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Aceptar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
