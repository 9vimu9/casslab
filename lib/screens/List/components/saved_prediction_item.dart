import 'package:flutter/material.dart';

import 'list_description.dart';

class SavedPredictionItem extends StatelessWidget {
  const SavedPredictionItem({
    Key? key,
    required this.thumbnail,
    required this.predictionLabel,
    required this.description,
    required this.confidence,
  }) : super(key: key);

  final Widget thumbnail;
  final String predictionLabel;
  final String description;
  final double confidence;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 2,
            child: thumbnail,
          ),
          Expanded(
            flex: 3,
            child: ListDescription(
              predictionLabel: predictionLabel,
              description: description,
              confidence: confidence,
            ),
          ),
        ],
      ),
    );
  }
}

