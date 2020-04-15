import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/counter_bloc.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final CounterBloc _counterBloc = new CounterBloc();


  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _counterBloc,
      child: SafeArea(
              child: Scaffold(
             body: Center(
             child: BlocBuilder<CounterBloc, int>(builder: (_, state){
                 return Text('Counter is --> ${state}');
              }
            ),
          ),
          floatingActionButton: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              FloatingActionButton(
                heroTag: 'increment',
                child: Icon(Icons.add),
                onPressed: (){
                  _counterBloc.add(CounterEvents.increment);
                },
              ),
              FloatingActionButton(
                 heroTag: 'decrement',
                child: Icon(Icons.remove),
                onPressed: (){
                  _counterBloc.add(CounterEvents.decrement);
                },
              ),
              FloatingActionButton(
                 heroTag: 'reset',
                child: Icon(Icons.restore),
                onPressed: (){
                  _counterBloc.add(CounterEvents.reset);
                },
              )
            ],
          ),
        ),
      ),
    );
  }




  @override
  void dispose() {
    _counterBloc?.close();
    super.dispose();
  }
}