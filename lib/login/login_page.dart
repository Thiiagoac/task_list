import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_list/cadastrar/cadastrar_page.dart';
import 'package:task_list/tarefas/tarefa_page.dart';
import 'package:task_list/widgets/expanded_button.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final DBRef = FirebaseDatabase.instance.reference();
  final usuarios = FirebaseDatabase.instance.reference().child('Usuarios');

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  TextEditingController emailController = new TextEditingController();
  TextEditingController senhaController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    print("rebuild");
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Row(
          children: <Widget>[
            Text("TaskList"),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(left: 15, right: 15, top: 15),
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
                        "Login",
                        style: TextStyle(fontSize: 20),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Form(key: _formKey, child: _formLogin(context))
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 13,
              ),
              FlatButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                color: Theme.of(context).backgroundColor,
                textColor: Colors.black,
                disabledColor: Colors.grey,
                disabledTextColor: Colors.black,
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => CadastrarPage(),
                  ));
                },
                child: Text(
                  "Cadastre-se",
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    senhaController.dispose();
  }

  Widget _formLogin(BuildContext context) {
    return Column(
      children: <Widget>[
        TextFormField(
          controller: emailController,
          validator: (value) {
            if (value.isEmpty) {
              return 'Por favor digite o e-mail';
            }
            return null;
          },
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
          validator: (value) {
            if (value.isEmpty) {
              return 'Por favor digite a senha';
            }
            return null;
          },
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
            if (_formKey.currentState.validate()) {
              fazerLogin(context, emailController.text, senhaController.text);
            }
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
                'Entrar',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(
                width: 5,
              ),
              Icon(Icons.exit_to_app),
            ],
          ),
        ),
      ],
    );
  }

  void fazerLogin(BuildContext context, String email, String senha) async {
    DataSnapshot dataValues = await usuarios.once().then((value) => value);
    Map<dynamic, dynamic> values = dataValues.value;
    bool userExist = false;

    final prefs = await SharedPreferences.getInstance();
    values.forEach((key, values) {
      if (values['user']['senha'] == senha &&
          values['user']['email'] == email) {
        userExist = true;
        prefs.setString('email', email);
        prefs.setString('iduser', key);
        print(key);
      }
    });

    if (userExist) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => ListaTarefasPage(email: email,),
        ),
      );
    } else {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text('Houve um erro ao tentar realizar o login'),
        duration: Duration(seconds: 3),
      ));
      emailController.clear();
      senhaController.clear();
    }
  }
}
