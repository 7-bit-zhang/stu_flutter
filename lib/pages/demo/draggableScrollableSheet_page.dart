import 'package:flutter/material.dart';
import 'package:study_demo/widget/appbar.dart';

class DraggableScrollableSheetPage extends StatefulWidget {
  const DraggableScrollableSheetPage({super.key});

  @override
  State<DraggableScrollableSheetPage> createState() =>
      _DraggableScrollableSheetPageState();
}

class _DraggableScrollableSheetPageState
    extends State<DraggableScrollableSheetPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: StudyAppBar.MyAppBar("", context),
        body: Center(
            child: Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: [
            InteractiveViewer(
              child: Image.asset(
                "assets/images/dao.jpg",
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            DraggableScrollableSheet(
              initialChildSize: 0.25,
              minChildSize: 0.25,
              maxChildSize: 1,
              expand: false,
              snap: true,
              snapSizes: const [.5], //拖动到0.5时自动暂停
              builder: (context, scrollController) {
                return Container(
                  color: Colors.white,
                  child: ListView.builder(
                    controller: scrollController,
                    itemCount: 25,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text('Item $index'),
                      );
                    },
                  ),
                );
              },
            )
          ],
        )));
  }
}
