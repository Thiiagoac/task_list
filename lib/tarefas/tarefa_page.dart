import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_list/login/login_page.dart';
import 'package:task_list/tarefas/tarefa_store.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:task_list/widgets/tile.dart';

class ListaTarefasPage extends StatefulWidget {
  String email;

  ListaTarefasPage({this.email});

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
    tarefaStore = TarefaStore();
    setUser();
  }

  Future setUser() async {
    final prefs = await SharedPreferences.getInstance();
    idUser = prefs.getString('iduser');
    await tarefaStore.loadTasks();
  }

  void removeUserCache() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('iduser');
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => LoginPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
              onPressed: () async {
                await tarefaStore.loadTasks();
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
                removeUserCache();
              },
            ),
          )
        ],
      ),
      drawer: Drawer(
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.85,
                child: DrawerHeader(
                  decoration:
                      BoxDecoration(color: Theme.of(context).accentColor),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "TaskList",
                        style: TextStyle(color: Colors.white, fontSize: 23),
                      ),
                      Divider(color: Colors.white,),
                      SizedBox(height: 30,),
                      Text(
                        'Bem vindo',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      Text(
                        widget.email,
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: ListView(children: [
                ListTile(
                  title: Text("Home"),
                  onTap: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => ListaTarefasPage(email: widget.email,),
                      ),
                    );
                  },
                ),
                ListTile(
                  title: Text("Relatórios"),
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                ),
              ]),
            )
          ],
        ),
      ),
      body: Container(
        margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
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
              ),
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
                  switch (tarefaStore.tarefas.length) {
                    case 0:
                      return Container(
                          padding: EdgeInsets.all(10),
                          child: Text('Não existem tarefas registradas'));
                      break;
                    default:
                      return ListView.separated(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        padding: const EdgeInsets.all(8),
                        itemCount: tarefaStore.tarefas.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Tile(
                            title: tarefaStore.tarefas[index].tarefa,
                            trailing: IconButton(
                              icon: Icon(Icons.delete_forever),
                              color: Colors.black54,
                              onPressed: () {
                                tarefaStore.removerTask(index);
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
                      break;
                  }
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
