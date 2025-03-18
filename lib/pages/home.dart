import 'package:flutter/material.dart';
import 'package:pr_tracker/models/pr_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  final String title = "PRs tracker";
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<PrModel> prs = [];
  void _getPrs() {
    prs = PrModel.getPrs();
  }

  @override
  Widget build(BuildContext context) {
    _getPrs();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: ListView.separated(
          padding: EdgeInsets.only(
            top: 25
          ),
          separatorBuilder: (context, index) => SizedBox(height: 25),
          itemCount: prs.length, // Number of items in the list
          itemBuilder: (context, index) {
            return Container(
              height: 200,
              decoration: BoxDecoration(
                color: Colors.blueGrey.withAlpha(100),
                borderRadius: BorderRadius.circular(20)
              ),
              child: Column(
                children: [
                  Text(prs[index].name)
                ],
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _getPrs,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
