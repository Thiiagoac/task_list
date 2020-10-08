import 'package:firebase_database/firebase_database.dart';
import 'package:mobx/mobx.dart';

part 'tarefa_store.g.dart';

class TarefaStore = _TarefaStore with _$TarefaStore;

abstract class _TarefaStore with Store {
  final String idUser;
  final DBRef = FirebaseDatabase.instance.reference().child("Usuarios");

  _TarefaStore({this.idUser});

  ObservableList<String> tarefas = ObservableList<String>();

  @observable
  String newTarefa = "";

  @action
  void addTask(String tarefa) {
    DBRef.child(idUser).child("tarefas").push().set(tarefa);
    tarefas.add(tarefa);
  }

  @action
  void loadTask() async {
    tarefas = List<String>();
    DataSnapshot dataValues = await DBRef.child(idUser)
        .child('tarefas')
        .once()
        .then((value) => value);

    Map<dynamic, dynamic> tarefasUser = dataValues.value;
    List<String> lista = List<String>();
    if (tarefasUser != null) {
      tarefasUser.forEach((key, values) {
        lista.add(values.toString());
      });

      lista.forEach((element) {
        print(element);
        tarefas.add(element);
      });
    }
  }

  @action
  void removeTarefa(int index) async {
    print(index);
  }
}
