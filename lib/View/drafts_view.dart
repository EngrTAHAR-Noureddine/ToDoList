import 'package:flutter/material.dart';


class DraftsView extends StatefulWidget {
  const DraftsView({Key key}) : super(key: key);

  @override
  _DraftsViewState createState() => _DraftsViewState();
}

class _DraftsViewState extends State<DraftsView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      color :Colors.purple
    );
  }
}
