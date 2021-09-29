import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:latihan_bloc/model/person.dart';

class ListPersonBloc extends Bloc<ListPersonEvent, List<Person>> {
  ListPersonBloc() : super([]) {
    // ignore: void_checks
    on<AcceptPerson>((event, emit) {
      state[event.index].accepted = !state[event.index].accepted;
      print(state[event.index].accepted);
      emit(state);
    });
    // ignore: void_checks
    on<AddPerson>((event, emit) {
      state.add(Person(event.name, sex: event.sex));
      print(state);
      emit(state);
      
    });
  }
}

abstract class ListPersonEvent {}

class AddPerson extends ListPersonEvent {
  AddPerson(this.name, this.sex);
  String name;
  bool sex;
}

class AcceptPerson extends ListPersonEvent {
  AcceptPerson(this.index);
  int index;
}
