import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ck5/models/Transactions.dart';
import 'package:ck5/providers/transation_provider.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<TransactionProvider>(context, listen: false).initData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Checkpoint5"),
          backgroundColor: Colors.green,
          actions: [
            IconButton(
                icon: Icon(Icons.exit_to_app),
                onPressed: () {
                  SystemNavigator.pop();
                })
          ],
        ),
        body: Consumer(
          builder: (context, TransactionProvider provider, Widget child) {
            var count = provider.transactions.length; //นับจำนวนข้อมูล
            if (count <= 0) {
              return Center(
                child: Text(
                  "Sorry! No Data, Please Add Data.",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 25),
                ),
              );
            } else {
              return ListView.builder(
                  itemCount: count,
                  itemBuilder: (context, int index) {
                    Transactions data = provider.transactions[index];
                    return Card(
                      elevation: 5,
                      margin: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 15),
                      child: ListTile(
                        leading: CircleAvatar(
                          radius: 30,
                          child: FittedBox(
                            child: Text(
                                DateFormat("dd/MM/yyyy").format(data.date)),
                          ),
                        ),
                        title: Text(
                            "Welcome to Animate System,\nName: ${data.name}\nLastName: ${data.lastname}\nPhone: 0${data.phone.toInt().toString()}\nE-mail: ${data.email}\nPassword: ${data.password}"),
                      ),
                    );
                  });
            }
          },
        ));
  }
}
