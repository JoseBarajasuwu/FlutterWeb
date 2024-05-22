// import 'dart:convert';
// import 'dart:io';
// import 'package:shelf/shelf.dart';
// import 'package:shelf/shelf_io.dart' as io;
// import 'package:shelf_router/shelf_router.dart';
// import 'package:postgres/postgres.dart';

// // Conexión a la base de datos

// void main() async {
//   final conn = await Connection.open(
//     Endpoint(
//       host: 'localhost',
//       database: 'postgres',
//       username: 'user',
//       password: 'pass',
//     ),
//     // The postgres server hosted locally doesn't have SSL by default. If you're
//     // accessing a postgres server over the Internet, the server should support
//     // SSL and you should swap out the mode with `SslMode.verifyFull`.
//     settings: const ConnectionSettings(sslMode: SslMode.disable),
//   );
//   final result2 = await conn.execute(
//     Sql.named('SELECT * FROM a_table WHERE id=@id'),
//     parameters: {'id': 'example row'},
//   );
//   print(result2.first.toColumnMap());
//   var router = Router();

//   // Define rutas
//   router.get('/data', _getDataHandler);
//   router.post('/data', _postDataHandler);

//   var handler =
//       const Pipeline().addMiddleware(logRequests()).addHandler(router);

//   var port = int.parse(Platform.environment['PORT'] ?? '8080');
//   var server = await io.serve(handler, '0.0.0.0', port);
//   print('Server listening on port ${server.port}');
// }

// // Controlador para manejar GET /data
// Future<Response> _getDataHandler(Request request) async {
//   // List<List<dynamic>> results =
//   //     await connection.query('SELECT * FROM your_table');
//   // return Response.ok(results.toString());
//   // name parameter query
// }

// // Controlador para manejar POST /data
// Future<Response> _postDataHandler(Request request) async {
//   var body = await request.readAsString();
//   var data = jsonDecode(body);

//   // Suponiendo que tienes una tabla con columnas "id" y "name"
//   await connection.query(
//     'INSERT INTO your_table (id, name) VALUES (@id, @name)',
//     substitutionValues: {'id': data['id'], 'name': data['name']},
//   );

//   return Response.ok('Data inserted successfully');
// }
