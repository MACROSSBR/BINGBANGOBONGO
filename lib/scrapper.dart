import 'dart:convert';
import 'package:http/http.dart';
import 'package:html/parser.dart';
import 'package:html/dom.dart';



main (BaseClient client) async {







  // API call
  Response response = await client.get('https://steamcommunity.com/market/search?appid=730');
  
  if (response.statusCode != 200) return response.body;
   
  // html parser
  
  var document = parse(response.body);
  
  List<Element> linknomes = document.querySelectorAll('div.market_listing_item_name_block > span.market_listing_item_name');
  List<Element> linkprecos = document.querySelectorAll('span.market_table_value > span.normal_price');
  List<Element> linkquants = document.querySelectorAll('span.market_table_value > span.market_listing_num_listings_qty');

  List<Map<String, dynamic>> linkMap = [];


  
  for (var i = 0; i < 9 ; i++) {
    
   linkMap.add({
     'nome': linknomes[i].text,
     'preço': linkprecos[i].text,
     'quant': linkquants[i].text,
      
   });
  }
  
  print(linkMap);
  

  print(json.encode(linkMap));
    
  
   



  return json.encode(linkMap);
    
  
}

  