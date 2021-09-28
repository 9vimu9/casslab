import 'package:casslab/screens/List/components/background.dart';
import 'package:casslab/screens/List/components/saved_prediction_item.dart';
import 'package:flutter/material.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // This size provide us total height and width of our screen
    return Background(
      child: Container(
        padding: EdgeInsets.only(top: 60),
        child: SingleChildScrollView(
          child: ListView(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            // <- added
            primary: false,
            // <- added
            padding: const EdgeInsets.all(8.0),
            itemExtent: 106.0,
            children: <SavedPredictionItem>[
              SavedPredictionItem(
                description: 'Flutter',
                confidence: 34,
                thumbnail: Container(
                  decoration: const BoxDecoration(color: Colors.blue),
                ),
                predictionLabel: 'Healthy',
              ),
              SavedPredictionItem(
                description: 'Dash',
                confidence: 884000,
                thumbnail: Container(
                  decoration: const BoxDecoration(color: Colors.yellow),
                ),
                predictionLabel: 'Mitea',
              ),
              SavedPredictionItem(
                description: 'Flutter',
                confidence: 34,
                thumbnail: Container(
                  decoration: const BoxDecoration(color: Colors.blue),
                ),
                predictionLabel: 'Healthy',
              ),
              SavedPredictionItem(
                description: 'Dash',
                confidence: 884000,
                thumbnail: Container(
                  decoration: const BoxDecoration(color: Colors.yellow),
                ),
                predictionLabel: 'Mitea',
              ),
              SavedPredictionItem(
                description: 'Flutter',
                confidence: 34,
                thumbnail: Container(
                  decoration: const BoxDecoration(color: Colors.blue),
                ),
                predictionLabel: 'Healthy',
              ),
              SavedPredictionItem(
                description: 'Dash',
                confidence: 884000,
                thumbnail: Container(
                  decoration: const BoxDecoration(color: Colors.yellow),
                ),
                predictionLabel: 'Mitea',
              ),
              SavedPredictionItem(
                description: 'Flutter',
                confidence: 34,
                thumbnail: Container(
                  decoration: const BoxDecoration(color: Colors.blue),
                ),
                predictionLabel: 'Healthy',
              ),
              SavedPredictionItem(
                description: 'Dash',
                confidence: 884000,
                thumbnail: Container(
                  decoration: const BoxDecoration(color: Colors.yellow),
                ),
                predictionLabel: 'Mitea',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
