import 'package:eventify/common/widgets/Loader.dart';
import 'package:eventify/common/widgets/star.dart';
import 'package:eventify/features/admin/model/feedback.dart';
import 'package:eventify/features/admin/services/admin_services.dart';
import 'package:flutter/material.dart';

class GetFeedbackScreen extends StatefulWidget {
  static const String id = '/getfeedbacks';

  @override
  _GetFeedbackScreenState createState() => _GetFeedbackScreenState();
}

class _GetFeedbackScreenState extends State<GetFeedbackScreen> {
  List<Feedbacks> feedbackList = [];
  AdminServices adminservices = AdminServices();
  bool isLoading = true;
  bool hasError = false;

  @override
  void initState() {
    super.initState();
    // Fetch feedback data when the screen is loaded
    fetchFeedbackData();
  }

  void fetchFeedbackData() async {
    try {
      List<Feedbacks> feedback = await adminservices.getFeedbacks(context);
      setState(() {
        feedbackList = feedback;
        isLoading = false;
        hasError = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
        hasError = true;
      });
      // Handle error, show a snackbar or any other error handling mechanism
      showSnackBar(context, e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Feedback'),
      ),
      body: buildFeedbackList(),
    );
  }

  Widget buildFeedbackList() {
    if (isLoading) {
      return Center(
        child: Loader(),
      );
    } else if (hasError) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'Failed to fetch feedbacks. Please try again.',
            style: TextStyle(color: Colors.red),
          ),
        ),
      );
    } else if (feedbackList.isEmpty) {
      return Center(
        child: Text('No feedbacks available.'),
      );
    } else {
      return ListView.separated(
        itemCount: feedbackList.length,
        separatorBuilder: (context, index) => Divider(),
        itemBuilder: (context, index) {
          final feedback = feedbackList[index];
          return buildFeedbackItem(feedback);
        },
      );
    }
  }

  Widget buildFeedbackItem(Feedbacks feedback) {
    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'User: ${feedback.username}',
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8.0),
          Star(rating: feedback.rating),
          SizedBox(height: 8.0),
          Text(
            'Feedback: ${feedback.feedback}',
            style: TextStyle(fontSize: 16.0),
          ),
        ],
      ),
    );
  }

  void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 3),
      ),
    );
  }
}
