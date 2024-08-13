// ignore_for_file: library_private_types_in_public_api

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:graphview/GraphView.dart';

class TreeViewPage extends StatefulWidget {
  const TreeViewPage({super.key});

  @override
  _TreeViewPageState createState() => _TreeViewPageState();
}

class _TreeViewPageState extends State<TreeViewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Wrap(
          children: [
            SizedBox(
              width: 100,
              child: TextFormField(
                initialValue: builder.siblingSeparation.toString(),
                decoration:
                    const InputDecoration(labelText: "Sibling Separation"),
                onChanged: (text) {
                  builder.siblingSeparation = int.tryParse(text) ?? 100;
                  setState(() {});
                },
              ),
            ),
            SizedBox(
              width: 100,
              child: TextFormField(
                initialValue: builder.levelSeparation.toString(),
                decoration:
                    const InputDecoration(labelText: "Level Separation"),
                onChanged: (text) {
                  builder.levelSeparation = int.tryParse(text) ?? 100;
                  setState(() {});
                },
              ),
            ),
            SizedBox(
              width: 100,
              child: TextFormField(
                initialValue: builder.subtreeSeparation.toString(),
                decoration:
                    const InputDecoration(labelText: "Subtree separation"),
                onChanged: (text) {
                  builder.subtreeSeparation = int.tryParse(text) ?? 100;
                  setState(() {});
                },
              ),
            ),
            SizedBox(
              width: 100,
              child: TextFormField(
                initialValue: builder.orientation.toString(),
                decoration: const InputDecoration(labelText: "Orientation"),
                onChanged: (text) {
                  builder.orientation = int.tryParse(text) ?? 100;
                  setState(() {});
                },
              ),
            ),
            ElevatedButton(
              onPressed: () {
                final node12 = Node.Id(r.nextInt(100));
                var edge =
                    graph.getNodeAtPosition(r.nextInt(graph.nodeCount()));
                graph.addEdge(edge, node12);
                setState(() {});
              },
              child: const Text("Add"),
            )
          ],
        ),
        Expanded(
          child: InteractiveViewer(
              constrained: false,
              boundaryMargin: const EdgeInsets.all(100),
              minScale: 0.1,
              maxScale: 5.6,
              child: GraphView(
                graph: graph,
                algorithm:
                    BuchheimWalkerAlgorithm(builder, TreeEdgeRenderer(builder)),
                paint: Paint()
                  ..color = Colors.green
                  ..strokeWidth = 1
                  ..style = PaintingStyle.stroke,
                builder: (Node node) {
                  // I can decide what widget should be shown here based on the id
                  var a = node.key!.value as int;
                  return rectangleWidget(a);
                },
              )),
        ),
      ],
    ));
  }

  Widget rectangleWidget(int a) {
    return InkWell(
      onTap: () {
        EasyLoading.showToast(a.toString());
      },
      child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            boxShadow: const [
              BoxShadow(color: Colors.blue, spreadRadius: 1),
            ],
          ),
          // ignore: unnecessary_brace_in_string_interps
          child: Text('Node ${a}')),
    );
  }

  Random r = Random();

  final Graph graph = Graph()..isTree = true;
  BuchheimWalkerConfiguration builder = BuchheimWalkerConfiguration();

  @override
  void initState() {
    super.initState();
    final node1 = Node.Id(1);
    final node2 = Node.Id(2);
    final node3 = Node.Id(3);
    final node4 = Node.Id(4);
    final node5 = Node.Id(5);
    final node6 = Node.Id(6);
    final node8 = Node.Id(7);
    final node7 = Node.Id(8);
    final node9 = Node.Id(9);
    final node10 = Node.Id(10);
    final node11 = Node.Id(11);
    final node12 = Node.Id(12);

    graph.addEdge(node1, node2);
    graph.addEdge(node1, node3, paint: Paint()..color = Colors.red);
    graph.addEdge(node1, node4, paint: Paint()..color = Colors.blue);
    graph.addEdge(node2, node5);
    graph.addEdge(node2, node6);
    graph.addEdge(node6, node7, paint: Paint()..color = Colors.red);
    graph.addEdge(node6, node8, paint: Paint()..color = Colors.red);
    graph.addEdge(node4, node9);
    graph.addEdge(node4, node10, paint: Paint()..color = Colors.black);
    graph.addEdge(node4, node11, paint: Paint()..color = Colors.red);
    graph.addEdge(node11, node12);

    builder
      ..siblingSeparation = (50)
      ..levelSeparation = (100)
      ..subtreeSeparation = (50)
      ..orientation = (BuchheimWalkerConfiguration.ORIENTATION_TOP_BOTTOM);
  }
}
