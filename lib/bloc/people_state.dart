part of 'people_bloc.dart';

abstract class PeopleState extends Equatable {
  List<Person> people;
  PeopleState(this.people) {
    log("state in PeopleState : " + people.length.toString());
  }

  @override
  List<Object> get props => people;
}

class PeopleInitial extends PeopleState {
  PeopleInitial() : super([]);
}

class PeopleAvailable extends PeopleState {
  PeopleAvailable(List<Person> people) : super(people);
  @override
  List<Object> get props => people;
}
