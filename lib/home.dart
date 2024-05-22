import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:postgres/postgres.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _counter = 0;
  bool subirArchivos = false;
  String usuario = "";
  Future<void> sucursales() async {
    final conn = await Connection.open(
      Endpoint(
        host: 'aws-0-us-west-1.pooler.supabase.com',
        database: 'postgres',
        port: 5432,
        username: 'postgres.dosnjylifgwtfqzyzlih',
        password: 'porqueria1324',
      ),
      // The postgres server hosted locally doesn't have SSL by default. If you're
      // accessing a postgres server over the Internet, the server should support
      // SSL and you should swap out the mode with `SslMode.verifyFull`.
      settings: const ConnectionSettings(sslMode: SslMode.disable),
    );
    final result2 = await conn.execute(
      Sql.named('SELECT * FROM "Usuario" WHERE "UsuarioID" = @id'),
      parameters: {'id': '1'},
    );
    setState(() {
      usuario = "${result2[0][1]}";
      subirArchivos = false;
    });
    print(result2[0][1]);
  }

  List<dynamic> sucursal = [];
  Future<void> suc() async {
    setState(() {
      subirArchivos = true;
    });
    var baseUrl1 = "https://prd.autocentro.mx/api/lista-suc";
    http.Response response = await http.get(Uri.parse(baseUrl1));
    if (response.statusCode == 200) {
      sucursales();
      var jsonL = json.decode(response.body);
      setState(() {
        sucursal = jsonL;
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
                : Text("${usuario}"),
            // ElevatedButton(
            //     onPressed: () {
            //       Navigator.pushNamed(context, 'r');
            //     },
            //     child: Text("a"))
          ],
        ),
      ),
    );
  }
}
