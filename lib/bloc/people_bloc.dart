import 'dart:developer';
import 'dart:html';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:latihan_bloc/model/person.dart';

part 'people_event.dart';
part 'people_state.dart';

class PeopleBloc extends Bloc<PeopleEvent, PeopleState> {
  PeopleBloc() : super(PeopleInitial()) {
    // on<AddPersonEvent>((event, emit) {
    //   if (state is PeopleInitial) {

    //     emit(PeopleAvailable(state.people));
    //   }
    //   if (state is PeopleAvailable) {
    //     state.people.add(event.person);
    //     log("state in bloc : " + state.people.length.toString());
    //     emit(PeopleAvailable(state.people));
    //   }
    // });
  }

  @override
  Stream<PeopleState> mapEventToState(PeopleEvent event) async* {
    if (event is AddPersonEvent) {
      if (state is PeopleInitial) {
        yield PeopleAvailable([]);
      }
      if (state is PeopleAvailable) {
        state.people.add(event.person);
        log("state in bloc : " + state.people.length.toString());
        yield PeopleAvailable(state.people);
      }
    }
  }
}
