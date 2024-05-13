import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _counter = 0;
  bool subirArchivos = false;
  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  List<dynamic> sucursal = [];
  Future<void> suc() async {
    setState(() {
      subirArchivos = true;
    });
    var baseUrl1 = "http://prd.autocentro.mx/api/lista-suc";
    http.Response response = await http.get(Uri.parse(baseUrl1));
    if (response.statusCode == 200) {
      var jsonL = json.decode(response.body);
      setState(() {
        sucursal = jsonL;
        subirArchivos = false;
      });
    } else {
      showErrorStatusCode();
    }
  }

  showErrorStatusCode() {
    setState(() {
      subirArchivos = false;
    });
    showDialog<String>(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) => Center(
        child: AlertDialog(
          actionsAlignment: MainAxisAlignment.center,
          title: const Center(
            child: Text('La conexión no fue posible'),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blueGrey),
              child: const Text('Aceptar'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    suc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Titulo"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            subirArchivos == true
                ? const Center(
                    child: SizedBox(
                      width: 30,
                      height: 30,
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.black12,
                        color: Colors.blueGrey,
                      ),
                    ),
                  )
                : Text("${sucursal[0]["NombreSucursal"]}"),
            ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, 'r');
                },
                child: Text("a"))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
