import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:task_list/widgets/expanded_button.dart';

class CadastrarPage extends StatefulWidget {
  @override
  _CadastrarPageState createState() => _CadastrarPageState();
}

class _CadastrarPageState extends State<CadastrarPage> {
  final DBRef = FirebaseDatabase.instance.reference();

  TextEditingController emailController;
  TextEditingController senhaController;
  TextEditingController nomeController;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    senhaController = TextEditingController();
    nomeController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    senhaController.dispose();
    nomeController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var sizeScreen = MediaQuery.of(context).size;
    print("rebuild");
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: <Widget>[
            SvgPicture.asset(
              'assets/images/logo.svg',
              width: 32,
              height: 32,
            ),
            Text("TaskList"),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(left: 15, right: 15, top: 15),
          width: sizeScreen.width,
          height: sizeScreen.height * 0.875,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 20,
              ),
              Card(
                borderOnForeground: true,
                elevation: 6,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.0),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.only(right: 15, left: 15, bottom: 15),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Cadastro",
                        style: TextStyle(fontSize: 20),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      _formLogin(context)
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 13,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _formLogin(BuildContext context) {
    return Column(
      children: <Widget>[
        TextFormField(
          controller: nomeController,
          decoration: InputDecoration(
            hintText: "Digite seu nome",
            labelText: "Nome",
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(
                  color: Colors.black, style: BorderStyle.solid, width: 2),
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        TextFormField(
          controller: emailController,
          decoration: InputDecoration(
            hintText: "Digite seu e-mail",
            labelText: "E-mail",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(
                  color: Colors.black, style: BorderStyle.solid, width: 2),
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        TextFormField(
          controller: senhaController,
          obscureText: true,
          decoration: InputDecoration(
            hintText: "Digite sua senha",
            labelText: "Senha",
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(
                  color: Colors.black, style: BorderStyle.solid, width: 2),
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        ExpandedRaisedButton(
          padding: const EdgeInsets.symmetric(vertical: 10),
          onPressed: () {
            DBRef.child('Usuarios')
                .push()
                .child("user")
                .set({
              'nome': nomeController.text,
              'email': emailController.text,
              'senha': senhaController.text,
            }).asStream();
            nomeController.clear();
            emailController.clear();
            senhaController.clear();
            Navigator.of(context).pop();
          },
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(22.0),
          ),
          color: Theme.of(context).primaryColor,
          textColor: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Cadastrar',
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
