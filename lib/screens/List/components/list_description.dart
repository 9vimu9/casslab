import 'package:flutter/material.dart';

class ListDescription extends StatelessWidget {
  const ListDescription({
    Key? key,
    required this.predictionLabel,
    required this.description,
    required this.confidence,
  }) : super(key: key);

  final String predictionLabel;
  final String description;
  final double confidence;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            predictionLabel,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14.0,
            ),
          ),
          const Padding(padding: EdgeInsets.symmetric(vertical: 2.0)),
          Text(
            description,
            style: const TextStyle(fontSize: 10.0),
          ),
          const Padding(padding: EdgeInsets.symmetric(vertical: 1.0)),
          Text(
            '$confidence %',
            style: const TextStyle(fontSize: 10.0),
          ),
        ],
      ),
    );
  }
}
