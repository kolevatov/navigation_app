import 'package:scoped_model/scoped_model.dart';
import 'package:flutter/material.dart';

class ScopedPage extends StatefulWidget {
  const ScopedPage({Key? key}) : super(key: key);

  @override
  _ScopedPageState createState() => _ScopedPageState();
}

class _ScopedPageState extends State<ScopedPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ScopedModel Widgets'),
        centerTitle: true,
      ),
      body: ListView(
        children: <Widget>[
          ScopedModel<CounterModel>(
            model: CounterModel(),
            child: _PageRootWidget(),
          ),
        ],
      ),
    );
  }
}

class _PageRootWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<CounterModel>(
      builder: (context, child, model) => Padding(
        padding: const EdgeInsets.only(
            top: 32.0, left: 16.0, right: 16.0, bottom: 32.0),
        child: Card(
          margin: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              const SizedBox(
                height: 8.0,
              ),
              Text('Root Widget', style: Theme.of(context).textTheme.headline4),
              const SizedBox(height: 8),
              Text('${model.counter}',
                  style: Theme.of(context).textTheme.headline4),
              const SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  _Counter(),
                  _Counter(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Counter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<CounterModel>(
      builder: (context, child, model) => Card(
        margin: const EdgeInsets.all(4.0).copyWith(bottom: 16.0),
        color: Colors.yellowAccent,
        child: Column(
          children: <Widget>[
            const SizedBox(
              height: 8.0,
            ),
            const Text('Child Widget'),
            Text('${model.counter}',
                style: Theme.of(context).textTheme.headline4),
            ButtonBar(
              children: <Widget>[
                IconButton(
                  icon: const Icon(Icons.remove),
                  color: Colors.red,
                  onPressed: () {
                    model._decrement();
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.add),
                  color: Colors.green,
                  onPressed: () {
                    model._increment();
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class CounterModel extends Model {
  int _counter = 0;

  int get counter => _counter;

  void _increment() {
    _counter++;
    notifyListeners();
  }

  void _decrement() {
    _counter--;
    notifyListeners();
  }
}
