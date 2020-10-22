class Tarefa {
  String id;
  String tarefa;

  Tarefa({this.id, this.tarefa});

  Tarefa.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    tarefa = json['tarefa'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['tarefa'] = this.tarefa;
    return data;
  }
}