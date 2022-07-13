import 'package:flutter/material.dart';

class ExpandableWidget extends StatefulWidget {
  final String sectionTitle;
  final String description;
  final Widget trailing;

  const ExpandableWidget({
    Key? key,
    required this.sectionTitle,
    required this.description,
    required this.trailing,
  }) : super(key: key);

  @override
  State<ExpandableWidget> createState() => _ExpandableWidgetState();
}

class _ExpandableWidgetState extends State<ExpandableWidget> {
  bool _isExpanded = false;

  void _expand() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 5,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Divider(
            thickness: 1,
            color: Colors.black38,
          ),
          SizedBox(
            height: 10,
          ),
          GestureDetector(
            onTap: _expand,
            child: Card(
              elevation: 0,
              child: Row(
                children: [
                  Text(
                    widget.sectionTitle,
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  Spacer(),
                  widget.trailing,
                      Icon(
                        _isExpanded ? Icons.expand_less : Icons.expand_more,
                        size: 30,
                      ),
                ],
              ),
            ),
          ),
          if(_isExpanded)
          Text(
            "${widget.description}",
            style: TextStyle(color: Colors.black54, fontSize: 16),
          ),
        ],
      ),
    );
  }
}
