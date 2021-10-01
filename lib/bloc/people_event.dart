part of 'people_bloc.dart';

abstract class PeopleEvent extends Equatable {
  const PeopleEvent();

  @override
  List<Object> get props => [];
}

class AddPersonEvent extends PeopleEvent {
  Person person;
  AddPersonEvent(this.person);
}
