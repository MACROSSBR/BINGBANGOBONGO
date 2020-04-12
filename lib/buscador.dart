//import 'package:flutter/material.dart';
import 'package:html/parser.dart' show parse;
import 'package:http/http.dart';



main () async {

String busca = 'case'; 

var linkMap = [];

var nomes = [];

var quants = [];

Response response = 

await Client().get(Uri.parse('https://steamcommunity.com/market/search?appid=730&q=$busca/'));

var document = parse(response.body);

for (var id = 0; id < 10; id++){

//nome.add({'nome': document.getElementById('result_$id/_name').attributes});

var nome = document.getElementById('result_$id/_name').querySelectorAll('span.market_listing_item_name');

var preco = document.getElementById('result_$id/_name').querySelectorAll('span.market_table_value > span.normal_price');

var quant = document.getElementById('result_$id/_name').querySelectorAll('span.market_table_value > span.market_listing_num_listings_qty');


for (var link in preco) {
  linkMap.add({
    'preço': link.text,
  });
}
for (var name in nome) {
  nomes.add({
    'nome': name.text,
  });
}
for (var q in quant) {
  quants.add({
    'quant': q.text,
  });
}

  print(id);
  print(nomes[id]['nome'].toString());
  print(linkMap[id]['preço'].toString());
  print(quants[id]['quant'].toString());
}

}






