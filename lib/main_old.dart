//import 'package:html/parser.dart' show parse;
//import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
//import 'buscador.dart' as lista;


main() => runApp(CSAPP());

class CSAPP extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ListViewWidget(),
     
    );
  }
}

class ListViewWidget extends StatefulWidget {



      
      @override
      _ListViewWidgetState createState() => _ListViewWidgetState();
    }
    
    class _ListViewWidgetState extends State<ListViewWidget> {

  get nomes => nomes;

  get linkMap => linkMap;

     
      @override
      Widget build(BuildContext context) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              'ListView Widget',
              
            ),
            
          ),
          body: ListView.builder(
            
            itemCount: nomes.length,
           
            itemBuilder: (BuildContext context, int index) {
              return Container(
                color: Colors.blue[500],
                child: ListView(
                  children:                 
                    nomes[index]['nome']            
                                ),
                  
                );
                          },
            
          ),
        );
      }
    }