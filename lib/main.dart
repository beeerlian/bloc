import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:latihan_bloc/bloc/list_person_bloc.dart';
import 'package:latihan_bloc/bloc/stream_bloc_nopackage.dart';
import 'package:latihan_bloc/model/person.dart';

class SimpleBlocObserver extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    print(event);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print(transition);
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    print(error);
    super.onError(bloc, error, stackTrace);
  }
}

void main() {
  Bloc.observer = SimpleBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return ListPersonBloc();
      },
      child: MaterialApp(home: Home()),
    );
  }
}

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);
  ListPersonStreamBloc streamBloc = ListPersonStreamBloc();
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void dispose() {
    widget.streamBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _buildStreamBlocWithoutPackage(context, widget.streamBloc);
  }

  Widget _buildStreamBlocWithoutPackage(
      BuildContext context, ListPersonStreamBloc streamBloc) {
    return Scaffold(
      body: StreamBuilder<List<Person>>(
          stream: streamBloc.streamData,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return _buildListPersonStreamBloc(snapshot.data as dynamic);
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else {
              return _buildEmptyView();
            }
          }),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () => streamBloc.inputSink.add(AddPerson("naufal", true))),
    );
  }

  Widget _buildListPersonStreamBloc(List<Person> people) {
    return ListView(
        children: List.generate(people.length,
            (index) => _buildListTileStreamBloc(people[index], index)));
  }

  Widget _buildListTileStreamBloc(Person person, int index) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: ListTile(
          leading: const Icon(Icons.person),
          title: Text(person.name),
          trailing: Checkbox(
              value: person.accepted,
              onChanged: (value) {
                return widget.streamBloc.inputSink.add(AcceptPerson(index));
              }),
        ));
  }

  Widget _buildHomeWithBlocProvider(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ListPersonBloc, List<Person>>(
        builder: (context, listPerson) {
          print("build list item");
          return ListView.builder(
              itemCount: listPerson.length,
              itemBuilder: (context, index) => _buildCardItemBlocProvider(
                  listPerson[index], context, index));
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () =>
            context.read<ListPersonBloc>().add(AddPerson("Naufal", true)),
      ),
    );
  }

  Widget _buildEmptyView() {
    return const Center(
      child: Text("List is Empty"),
    );
  }

  Widget _buildCardItemBlocProvider(
      Person person, BuildContext context, int index) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: ListTile(
          leading: const Icon(Icons.person),
          title: Text(person.name),
          trailing: Checkbox(
              value: person.accepted,
              onChanged: (value) {
                return context.read<ListPersonBloc>().add(AcceptPerson(index));
              }),
        ));
  }
}
