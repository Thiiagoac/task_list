import 'package:firebase_database/firebase_database.dart';
import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_list/models/Tarefa.dart';

part 'tarefa_store.g.dart';

class TarefaStore = _TarefaStore with _$TarefaStore;

abstract class _TarefaStore with Store {
  final DBRef = FirebaseDatabase.instance.reference().child("Usuarios");

  ObservableList<Tarefa> tarefas = ObservableList<Tarefa>();

  @observable
  String newTarefa = "";

  @action
  Future<void> addTask(String tarefa) async {
    print(tarefa);
    final prefs = await SharedPreferences.getInstance();
    String idUser = prefs.getString('iduser');
    DBRef.child(idUser).child("tarefas").push().set(tarefa);
    loadTasks();
  }

  @action
  Future<dynamic> loadTasks() async {
    tarefas.clear();
    final prefs = await SharedPreferences.getInstance();
    String idUser = prefs.getString('iduser');
    DataSnapshot dataValues = await DBRef.child(idUser)
        .child('tarefas')
        .once()
        .then((value) => value);

    Map<dynamic, dynamic> tarefasUser = dataValues.value;
    List<Tarefa> lista = List<Tarefa>();
    if (tarefasUser != null) {
      tarefasUser.forEach((key, values) {
        Tarefa t = Tarefa(id: key,tarefa: values.toString());
        lista.add(t);
      });

      lista.forEach((element) {
        print(element);
        tarefas.add(element);
      });
    }
  }

  @action
  Future<dynamic> removerTask(int index) async {
    final prefs = await SharedPreferences.getInstance();
    String idUser = prefs.getString('iduser');
    DBRef.child(idUser).child("tarefas").child(tarefas[index].id).remove();
    await loadTasks();
  }
}
