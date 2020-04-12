
import 'package:html/parser.dart';
import 'package:http/http.dart';
//import 'package:scraper_html/buscador.dart' as buscador;
import 'package:flutter/material.dart';
//import 'package:async/async.dart';
//import 'package:http/http.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CSGO MARKET',
      theme: ThemeData(
        
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'CS GO Itens'),
    );
  }
}


class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  
  _MyHomePageState createState() => _MyHomePageState();
}

class User {

final String busca;

User(this.busca);

}

class _MyHomePageState extends State<MyHomePage> {

Future <List<User>> _getUsers () async {

String busca = 'case'; 

List price = [];

List name = [];

List quantidade = [];

List resposta = [];

Response response = 

await Client().get(Uri.parse('https://steamcommunity.com/market/search?appid=730&q=$busca/'));

var document = parse(response.body);

for (var id = 0; id < 10; id++){

var nome = document.getElementById('result_$id/_name').querySelectorAll('span.market_listing_item_name');

var preco = document.getElementById('result_$id/_name').querySelectorAll('span.market_table_value > span.normal_price');

var quant = document.getElementById('result_$id/_name').querySelectorAll('span.market_table_value > span.market_listing_num_listings_qty');


for (var link in preco) {
  price.add({
    'preco': link.text,
  });
}
for (var n in nome) {
  name.add({
    'nome': n.text,
  });
}
for (var q in quant) {
  quantidade.add({
    'quant': q.text,
  });
}
//print(linkMap.toString());
}
//print(price.toString());

for (var k = 0; k < 10; k++) {
resposta[k].add(
  name[k],
  price[k],
  quantidade[k],
);

}
//print(resposta.toSet());
return (resposta);
}

//@override
//void initState() { 
  //super.initState();
  //user = _user();}

//_user() async {

  //return await buscador.main();}


@override 
  Widget build(BuildContext context) {
    
      
    return Scaffold(
     
      appBar: AppBar(
       
      title: Text('CS'),
      ),
     
      body: 
      Container(child:
        new FutureBuilder(
       future: _getUsers(),
       builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.data == null) {
          return Container(
            child: Center(child: Text('Bingo, Bengo, Bongo....'),)
          );
       }else{      

          return      
          ListView.builder(
          scrollDirection: Axis.vertical,
          padding: new EdgeInsets.all(6.0),
          itemCount: snapshot.data.length,
          itemBuilder: (BuildContext context, int index) {              
          return (
          ListTile( 
          title: Text('data'),
          //title: Text(snapshot.data[index].nome),
          //subtitle: Text(snapshot.data[index].quant),
          //leading: Text(snapshot.data[index].preco),
                   )
                  );
          },
                          );}
          }
          )
          ));
          
                  

          
        }
         //builder
}