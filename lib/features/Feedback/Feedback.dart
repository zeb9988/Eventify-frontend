import 'package:eventify/features/Feedback/FeedbackServices.dart';
import 'package:flutter/material.dart';
import 'package:smooth_star_rating_null_safety/smooth_star_rating_null_safety.dart';

class FeedbackScreen extends StatefulWidget {
  static const String id = '/Feedback';
  const FeedbackScreen({Key? key}) : super(key: key);

  @override
  _FeedbackScreenState createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  double _rating = 0.0;
  final TextEditingController _feedbackController = TextEditingController();
  final FeedbackServices feedbackservice = FeedbackServices();

  void submitFeedback() {
    feedbackservice.feedback(
      context: context,
      rating: _rating,
      feedback: _feedbackController.text,
    );
  }

  String getEmojiForRating(double rating) {
    if (rating >= 4.0) {
      return '😊'; // Happy face emoji for high ratings
    } else if (rating >= 2.0) {
      return '😐'; // Neutral face emoji for medium ratings
    } else {
      return '😞'; // Sad face emoji for low ratings
    }
  }

  @override
  void dispose() {
    _feedbackController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Feedback'),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              width: 0.5,
              color: Colors.grey,
            ),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.all(5.0),
                child: Text(
                  'Rate Your Experience',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Display the star rating along with emoji
                    RichText(
                      text: TextSpan(
                        text: getEmojiForRating(_rating) + ' ',
                        style: TextStyle(fontSize: 24),
                        children: [
                          WidgetSpan(
                            child: SmoothStarRating(
                              rating: _rating,
                              size: 30,
                              borderColor: Colors.orange,
                              color: Colors.yellow,
                              filledIconData: Icons.star,
                              halfFilledIconData: Icons.star_half,
                              defaultIconData: Icons.star_border,
                              starCount: 5,
                              allowHalfRating: true,
                              spacing: 2.0,
                              onRatingChanged: (value) {
                                setState(() {
                                  _rating = value;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Feedback',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              // Feedback text field
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _feedbackController,
                  maxLines: 4,
                  decoration: const InputDecoration(
                    hintText: 'Write your feedback here...',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                  ),
                  onPressed: submitFeedback,
                  child: const Text('Submit'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
