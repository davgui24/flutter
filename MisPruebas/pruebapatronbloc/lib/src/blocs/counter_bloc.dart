import 'package:bloc/bloc.dart';


enum CounterEvents{ increment, decrement, reset }



class CounterBloc extends Bloc<CounterEvents, int> {
  @override
  
  int get initialState => 100;

  @override
  Stream<int> mapEventToState(CounterEvents event) async*{
    int counter = this.state;

    if(event == CounterEvents.increment){
      counter ++;
    }else if(event == CounterEvents.decrement){
      counter --;
    }else if(event == CounterEvents.reset){
      counter = 100;
    }
    yield counter;
   }

}
