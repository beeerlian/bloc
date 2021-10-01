import 'dart:async';
import 'dart:developer';

import 'package:latihan_bloc/bloc/list_person_bloc.dart';
import 'package:latihan_bloc/model/person.dart';

class ListPersonStreamBloc {
  List<Person> people = [];
  final StreamController _inputStreamController = StreamController();
  StreamSink get inputSink => _inputStreamController.sink;

  final StreamController<List<Person>> _outputStreamController = StreamController<List<Person>>();
  StreamSink get outputSink => _outputStreamController.sink;

  Stream<List<Person>> get streamData => _outputStreamController.stream;

  ListPersonStreamBloc() {
    
    _inputStreamController.stream.listen((event) {
      if (event is AcceptPerson) {
        people[event.index].accepted = !people[event.index].accepted;
        outputSink.add(people);
        
        log("person index ke-${event.index}, accepted = ${people[event.index].accepted}");
      } 
      else if (event is AddPerson) {
        people.add(Person(event.name, sex: event.sex));
        outputSink.add(people);

        log("Add ${event.name}, sex : ${event.sex}");
      }
    });
  }

  void dispose() {
    _outputStreamController.close();
    _inputStreamController.close();
  }
}