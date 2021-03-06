import 'dart:async';
import 'dart:core';
import 'package:flutter/material.dart';
import 'package:html/parser.dart';
import 'package:http/http.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'CS',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

TextEditingController editingController = TextEditingController();

bool _isButtonClicked = false;
var _buttonIcon = Icons.cloud_download;
var _buttonText = 'Procurar';
var _buttonColor = Colors.grey;
String buscador = 'case';
final controladordabusca = TextEditingController();


  @override
  Widget build(BuildContext context) {
    var futureBuilder = new FutureBuilder(
      future: _isButtonClicked ? _getData() : null,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          return 
          Row (
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget> [Text('Clique para buscar',textAlign: TextAlign.center, textScaleFactor: 1.5,)]);
          case ConnectionState.waiting:
            return Column (
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: <Widget> [CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.blue))]);
          default:
            if (snapshot.hasError)
              return new Text('Erro: ${snapshot.error}');
            else
              return    
              createListView(context, snapshot);
        }
      },
    );

    return new Scaffold(
      appBar: new AppBar(
        title: 
          TextField(
        controller: controladordabusca,
        onChanged: (newvalue) => buscador = newvalue,
        decoration: InputDecoration(
        labelText: "Procurar",
        hintText: "Procurar",
        prefixIcon: Icon(Icons.search),
        border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(25.0)))),
        ),


      ),
      body: futureBuilder,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
          floatingActionButton: FloatingActionButton.extended(
            backgroundColor: _buttonColor,
            onPressed: () {
              ///Calling method to fetch data from the server
              _getData();
    
              ///You need to reset UI by calling setState.
              setState(() {
                _isButtonClicked == false
                    ? _isButtonClicked = true
                    : _isButtonClicked = false;
    
                if (!_isButtonClicked) {
                  _buttonIcon = Icons.cloud_download;
                  _buttonColor = Colors.green;
                  _buttonText = "Procurar";
                } else {
                  _buttonIcon = Icons.replay;
                  _buttonColor = Colors.deepOrange;
                  _buttonText = "Resetar";
                }
              });
            },
            icon: Icon(
              _buttonIcon,
              color: Colors.white,
            ),
            label: Text(
              _buttonText,
              style: TextStyle(color: Colors.white),
            ),
    ));
  }

Future<Map<String,dynamic>> _getData() async {

var interno = Map<String,dynamic>();
    
String busca = buscador;



var document;



Response response = 

await Client().get(Uri.parse('https://steamcommunity.com/market/search?appid=730&q=$busca/'));

document = parse(response.body);

for (int id = 0; id < 10; id++){

var nome = document.getElementById('result_$id/_name').querySelectorAll('span.market_listing_item_name');

var preco = document.getElementById('result_$id/_name').querySelectorAll('span.market_table_value > span.normal_price');

var quant = document.getElementById('result_$id/_name').querySelectorAll('span.market_table_value > span.market_listing_num_listings_qty');

for (var a in nome) {
  interno['nome$id'] = a.innerHtml;
  }

for (var b in preco) {
  interno['preco$id'] = b.innerHtml;
  }

for (var c in quant) {
  interno['quant$id'] = c.innerHtml;
  }
}


     await new Future.delayed(new Duration(seconds: 2));

    return interno;
  }

  Widget createListView(BuildContext context, AsyncSnapshot snapshot) {
    Map<String,dynamic> interno = snapshot.data;
    
    return new ListView.builder(
      
        itemCount: 10,
        itemBuilder: 
        (BuildContext context, int index) {
          return new Column(
            children: <Widget>[
              new ListTile(
                title: Text(interno['nome$index']),
                subtitle: Text(interno['quant$index']),
                trailing: Text(interno['preco$index']),
              ),
              new Divider(height: 2.0,),
            ],
          );
        },
    );
  }
}