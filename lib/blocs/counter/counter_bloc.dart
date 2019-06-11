import 'package:bloc/bloc.dart';
import 'package:metronome/blocs/counter/counter_event.dart';
import 'package:metronome/blocs/counter/counter_state.dart';

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  void onIncrement() {
    this.dispatch(new IncrementEvent());
  }

  void onDecrement() {
    this.dispatch(new DecrementEvent());
  }

  @override
  CounterState get initialState => CounterState.initial();

  @override
  Stream<CounterState> mapEventToState(
    CounterEvent event,
  ) async* {
    final _currentState = currentState;
    if (event is IncrementEvent) {
      yield CounterState(counter: _currentState.counter + 1);
    } else if (event is DecrementEvent) {
      yield CounterState(counter: _currentState.counter - 1);
    }
  }
}
