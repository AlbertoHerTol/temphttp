import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}
class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() {
    print("Constructor MyApp");
    return new MyAppState(); //el estado ---> otra clase
  }
}

class MyAppState extends State<MyApp> {
  String respuesta='Cargando...';


  Future<String> consultar() async {
    print("Lanza la consulta :-)");
    var respuesta = await http.get('https://jsonplaceholder.typicode.com/posts/1'); //await para que espere
    // sample info available in response
    int statusCode = respuesta.statusCode;
    Map<String, String> headers = respuesta.headers;
    String contentType = headers['content-type'];
    String js = respuesta.body;
    print(statusCode.toString()+"\n"+ headers.toString()+"\n"+ js.toString());
    print(respuesta.toString());
    return(js);
  }

  MyApp(){
    print('Constructor MyAppState');
    var s = consultar().then((x){
      print('Entrando en then()');
      print(x);
      setState((){
        respuesta=x;
      });
    });// la funcion asincrona usa then
    print(s.toString());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to Flutter',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Welcome to Flutter'),
        ),
        body: Center(
          child: Text(respuesta),
        ),
      ),
    );
  }
}