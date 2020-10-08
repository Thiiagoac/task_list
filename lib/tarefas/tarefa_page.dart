import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_list/login/login_page.dart';
import 'package:task_list/tarefas/tarefa_store.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:task_list/widgets/tile.dart';

class ListaTarefasPage extends StatefulWidget {
  @override
  _ListaTarefasPageState createState() => _ListaTarefasPageState();
}

class _ListaTarefasPageState extends State<ListaTarefasPage> {
  TarefaStore tarefaStore;
  TextEditingController tarefaController = TextEditingController();
  String idUser;

  @override
  void initState() {
    super.initState();
  }

  void setUser() async {
    final prefs = await SharedPreferences.getInstance();
    idUser = prefs.getString('iduser');
  }

  void removeUserCache() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('iduser');
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => LoginPage(),
    ));
  }

  @override
  Widget build(BuildContext context) {
    setUser();
    tarefaStore = TarefaStore(idUser: idUser);
    tarefaStore.loadTask();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Row(
          children: <Widget>[
            Text("TaskList"),
          ],
        ),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 10),
            child: IconButton(
              icon: Icon(
                Icons.cached,
                size: 30,
                color: Colors.black,
              ),
              color: Theme.of(context).accentColor,
              onPressed: () {
                tarefaStore.loadTask();
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: 10),
            child: IconButton(
              icon: Icon(
                Icons.exit_to_app,
                size: 30,
                color: Colors.black,
              ),
              color: Theme.of(context).accentColor,
              onPressed: () {
                tarefaStore.loadTask();
              },
            ),
          )
        ],
      ),
      body: Container(
        margin: EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Observer(builder: (_) {
                return Container(
                  alignment: Alignment.topCenter,
                  decoration: new BoxDecoration(
                    color: Colors.white,
                    borderRadius: new BorderRadius.circular(15),
                  ),
                  child: Stack(
                    alignment: Alignment.centerRight,
                    children: <Widget>[
                      TextFormField(
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Descreva sua tarefa';
                          }
                          return null;
                        },
                        controller: tarefaController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Color(0xFFF0F0F0),
                          border: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 0, style: BorderStyle.none),
                            borderRadius: BorderRadius.circular(22.0),
                          ),
                          hintText: "Digite sua tarefa ...",
                          labelStyle: TextStyle(color: Colors.black),
                        ),
                      ),
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: Theme.of(context).accentColor,
                        child: IconButton(
                          color: Colors.white,
                          icon: Icon(
                            Icons.add,
                            size: 30,
                          ),
                          onPressed: () {
                            tarefaStore.addTask(tarefaController.text);
                            tarefaController.clear();
                          },
                        ),
                      ),
                    ],
                  ),
                );
              }),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 12),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Suas Tarefas",
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                ),
              ),
              Container(
                child: Observer(builder: (_) {
                  return ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.all(8),
                    itemCount: tarefaStore.tarefas.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Tile(
                        title: tarefaStore.tarefas[index],
                        trailing: IconButton(
                          icon: Icon(Icons.delete),
                          color: Theme.of(context).accentColor,
                          onPressed: () {
                            tarefaStore.removeTarefa(index);
                          },
                        ),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) =>
                        Divider(
                      color: Colors.black54,
                      indent: 10,
                      endIndent: 10,
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
