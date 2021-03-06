// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tarefa_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$TarefaStore on _TarefaStore, Store {
  final _$newTarefaAtom = Atom(name: '_TarefaStore.newTarefa');

  @override
  String get newTarefa {
    _$newTarefaAtom.reportRead();
    return super.newTarefa;
  }

  @override
  set newTarefa(String value) {
    _$newTarefaAtom.reportWrite(value, super.newTarefa, () {
      super.newTarefa = value;
    });
  }

  final _$addTaskAsyncAction = AsyncAction('_TarefaStore.addTask');

  @override
  Future<void> addTask(String tarefa) {
    return _$addTaskAsyncAction.run(() => super.addTask(tarefa));
  }

  final _$loadTasksAsyncAction = AsyncAction('_TarefaStore.loadTasks');

  @override
  Future<dynamic> loadTasks() {
    return _$loadTasksAsyncAction.run(() => super.loadTasks());
  }

  final _$removerTaskAsyncAction = AsyncAction('_TarefaStore.removerTask');

  @override
  Future<dynamic> removerTask(int index) {
    return _$removerTaskAsyncAction.run(() => super.removerTask(index));
  }

  @override
  String toString() {
    return '''
newTarefa: ${newTarefa}
    ''';
  }
}
