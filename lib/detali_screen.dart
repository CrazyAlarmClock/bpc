import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DetaliScreen extends StatelessWidget {
  DetaliScreen({@required this.document, this.statusColor, this.id});

  final document;
  Color statusColor;
  String id;


  void canceling(context) async {
    await Firestore.instance.collection('data')
        .document(id)
        .updateData({
      'visible': false,
    });

    Navigator.pop(context);

  }

  @override
  Widget build(BuildContext context) {
    Timestamp date = document['time'];

    return Scaffold(
      floatingActionButton: FlatButton.icon(
        color: Colors.pink,
          icon: Icon(
            Icons.close,
            color: Colors.white,
          ),
          onPressed:() => canceling(context),
          label: Text(
            'Отмена операции',
            style: TextStyle(color: Colors.white),
          )),
      appBar: AppBar(
        leading: CloseButton(color: Colors.white),
        backgroundColor: statusColor,
        elevation: 0.0,
        title: Container(
            child: Text(
          document['type'],
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 24.0, color: Colors.white),
        )),
      ),
      body: SingleChildScrollView(
        child: Column(children: <Widget>[
          SizedBox(height: 20,),
          Container(
            child: ListTile(
              leading: const Icon(
                Icons.date_range,
                color: Colors.pink,
              ),
              title: Text("Время", textScaleFactor: 1.2),
              subtitle: Text(
                '${date.toDate().year}.${date.toDate().month}.${date.toDate().day} ${date.toDate().hour}:${date.toDate().minute}',
                textScaleFactor: 1.2,
              ),
            ),
          ),
          Container(
            child: new ListTile(
              leading: const Icon(
                Icons.attach_money,
                color: Colors.pink,
              ),
              title: Text("Сумма"),
              subtitle: Text(document['sum'].toString()),
            ),
          ),
          Container(
            child: new ListTile(
              leading: const Icon(
                Icons.compare_arrows,
                color: Colors.pink,
              ),
              title: Text('Комиссия'),
              subtitle: Text(document['commission'].toString()),
            ),
          ),
          Container(
            child: new ListTile(
              leading: const Icon(
                Icons.gavel,
                color: Colors.pink,
              ),
              title: Text('Итого'),
              subtitle: Text(document['result'].toString() ?? "Нет"),
            ),
          ),
          Container(
            child: new ListTile(
              leading: const Icon(
                Icons.account_balance,
                color: Colors.pink,
              ),
              title: Text('Номер транзакции'),
              subtitle: Text(id ?? "Нет"),
            ),
          ),
          Container(
            child: new ListTile(
              leading: const Icon(
                Icons.label,
                color: Colors.pink,
              ),
              title: Text('Тип операции'),
              subtitle: Text(document['type'].toString() ?? "Нет"),
            ),
          ),
        ]),
      ),
    );
  }
}
