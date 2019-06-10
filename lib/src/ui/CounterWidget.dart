import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:metronome/src/ui/MyHomePage.dart';

import 'package:metronome/src/blocs/counter/counter_bloc.dart';
import 'package:metronome/src/blocs/counter/counter_state.dart';

class CounterWidget extends StatelessWidget {
  const CounterWidget({
    Key key,
    @required this.widget,
  }) : super(key: key);

  final MyHomePage widget;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: BlocBuilder(
            bloc: BlocProvider.of<CounterBloc>(context),
            builder: (context, CounterState state) {
              return
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'You have pushed the button this many times:',
                      ),
                      Text(
                        '${state.counter}',
                        style: Theme.of(context).textTheme.display1,
                      ),
                    ],
                  ),
                );
            }
        ),
        floatingActionButton: Row(mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[FloatingActionButton(
                onPressed: () => BlocProvider.of<CounterBloc>(context).onIncrement(),
                tooltip: 'Increment',
                child: Icon(Icons.add)),
              FloatingActionButton(
                  onPressed: () => BlocProvider.of<CounterBloc>(context).onDecrement(),
                  tooltip: 'Decrement',
                  child: Icon(Icons.remove)
              )]
        ));
  }
}