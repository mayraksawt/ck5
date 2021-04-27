import 'package:flutter/material.dart';
import 'package:ck5/models/Transactions.dart';
import 'package:ck5/providers/transation_provider.dart';
import 'package:provider/provider.dart';

class FormScreen extends StatelessWidget {
  final formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final lastnameController = TextEditingController();
  final addressController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Register'),
          backgroundColor: Colors.green,
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Form(
            key: formKey,
            child: ListView(
              children: [
                TextFormField(
                  decoration: new InputDecoration(
                    labelText: "Name",
                  ),
                  autofocus: true,
                  controller: nameController,
                  validator: (String str) {
                    if (str.isEmpty) {
                      return "Enter your Name";
                    }
                    return null;
                  },
                ),
                TextFormField(
                  decoration: new InputDecoration(
                    labelText: "LastName",
                  ),
                  autofocus: true,
                  controller: lastnameController,
                  validator: (String str) {
                    if (str.isEmpty) {
                      return "Enter your LastName";
                    }
                    return null;
                  },
                ),
                TextFormField(
                  decoration: new InputDecoration(labelText: "Phone"),
                  keyboardType: TextInputType.number,
                  controller: phoneController,
                  validator: (String str) {
                    if (str.isEmpty) {
                      return "Enter your Phone";
                    }
                    return null;
                  },
                ),
                TextFormField(
                  decoration: new InputDecoration(
                    labelText: "Address",
                  ),
                  autofocus: true,
                  controller: addressController,
                  validator: (String str) {
                    if (str.isEmpty) {
                      return "Enter your Address";
                    }
                    return null;
                  },
                ),
                TextFormField(
                  decoration: new InputDecoration(
                    labelText: "Email",
                  ),
                  autofocus: true,
                  controller: emailController,
                  validator: (String str) {
                    if (str.isEmpty) {
                      return "Enter your Email";
                    }
                    return null;
                  },
                ),
                TextFormField(
                  obscureText: true,
                  decoration: new InputDecoration(
                    labelText: "Password",
                  ),
                  autofocus: true,
                  controller: passwordController,
                  validator: (String str) {
                    if (str.isEmpty) {
                      return "Enter your Password";
                    }
                    return null;
                  },
                ),
                // ignore: deprecated_member_use
                FlatButton(
                  child: Text('Add Data'),
                  color: Colors.lightGreen,
                  textColor: Colors.white,
                  onPressed: () {
                    if (formKey.currentState.validate()) {
                      var name = nameController.text;
                      var lastname = lastnameController.text;
                      var address = addressController.text;
                      var phone = phoneController.text;
                      var email = emailController.text;
                      var password = passwordController.text;

                      Transactions statement = Transactions(
                          name: name,
                          lastname: lastname,
                          address: address,
                          phone: double.parse(phone),
                          email: email,
                          password: password,
                          date: DateTime.now());
                      var provider = Provider.of<TransactionProvider>(context,
                          listen: false);
                      provider.addTransaction(statement);
                    }
                  },
                )
              ],
            ),
          ),
        ));
  }
}
