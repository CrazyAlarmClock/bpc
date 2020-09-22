import 'package:bpc/detali_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}
final _scaffoldKey = GlobalKey<ScaffoldState>();


class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
            padding: const EdgeInsets.all(10.0),
            child: StreamBuilder<QuerySnapshot>(
              stream: Firestore.instance.collection('data').where('visible', isEqualTo: true)
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError)
                  return new Text('Error: ${snapshot.error}');
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return new CircularProgressIndicator();
                  default:
                    return new ListView(
                      children: snapshot.data.documents
                          .map((DocumentSnapshot document) {
                        return new CustomCard(
                          document: document,
                        );
                      }).toList(),
                    );
                }
              },
            )),
      ),
    );
  }
}

class CustomCard extends StatelessWidget {
  CustomCard({@required this.document});

  Color statusColor = Colors.green;

  final DocumentSnapshot document;
  @override
  Widget build(BuildContext context) {

    if(document['type'] == 'Перевод'){
      statusColor = Colors.yellow;
    }else if(document['type'] == 'Снятие'){
      statusColor = Colors.red;
    }

    return Card(
        child: InkWell(
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => DetaliScreen(document: document, statusColor: statusColor, id: document.documentID,)));
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(height: 15),
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 2.0),
                  child: RichText(
                    text: TextSpan(
                      style: DefaultTextStyle.of(context).style,
                      children: <TextSpan>[
                        TextSpan(text: 'Тип: ',),
                        TextSpan(text: document['type'], style: TextStyle(color: statusColor, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  )
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 2.0),
                  child: Text(
                     'Номер транзакции: ' + document.documentID.toString() ?? 'NULLLL',
                    style: TextStyle(
                        fontWeight: FontWeight.normal, fontSize: 14.0),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 2.0),
                  child: Text(
                    'Номер транзакции: ' + document['sum'].toString() ?? 'NULLLL',
                    style: TextStyle(
                        fontWeight: FontWeight.normal, fontSize: 16.0),
                  ),
                ),
                SizedBox(height: 15),

                SizedBox(height: 15),
              ],
            )));
  }
}
