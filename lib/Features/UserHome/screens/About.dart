import 'package:flutter/material.dart';

class PolicyScreen extends StatelessWidget {
  static const String id = '/About';

  final String policyContent = '''
    Eventify App Policies
    
    1. Data Privacy: Eventify prioritizes the security and privacy of your personal and event-related data. We employ robust measures to safeguard your information.
    2. User Conduct: Users are expected to engage respectfully and ethically within the Eventify community. Any misuse or violation of community standards may result in account suspension.
    3. Terms of Service: By using the Eventify app, you agree to adhere to our terms of service. This includes compliance with all policies outlined here and any future updates.
    4. Content Usage: Users must respect intellectual property rights and ensure they have the right to share any content on Eventify. Misuse of content may lead to the removal of the content or termination of the account.
    5. Booking and Transactions: Users engaging in bookings and transactions through Eventify must adhere to the agreed-upon terms. Any fraudulent activities will be taken seriously, and legal actions may be pursued.
    6. Notification Preferences: Eventify utilizes notifications for important updates, bookings, and reminders. Users can manage their notification preferences within the app settings.
    7. Analytics and User Data: Eventify collects analytics to improve user experience and service quality. User data is anonymized and used responsibly in compliance with privacy regulations.
    8. Support and Assistance: Eventify provides customer support for users, vendors, and administrators. Users can reach out for assistance with any inquiries or issues.
    9. Community Guidelines: Users are encouraged to follow community guidelines for a positive and inclusive experience. Any content or behavior violating these guidelines may result in account actions.
    10. Updates and Changes: Eventify may update policies, features, or terms. Users will be notified of significant changes, and continued use of the app implies acceptance of these updates.
    
    11. Payment Security: Eventify employs secure payment gateways to ensure the confidentiality and integrity of financial transactions. Users can trust the platform for secure payment processing.
    12. Vendor Registration and Approval: Vendors registering on Eventify undergo a verification process. Eventify reserves the right to approve or reject vendor registrations based on predefined criteria.
    13. Service Availability: Eventify strives to ensure that all listed services are available as described. In the rare event of service unavailability, users will be notified, and alternatives or refunds will be provided.
    14. Cancellation and Refund: Users can cancel bookings within the stipulated timeframes. Eventify follows a fair cancellation and refund policy, and users are encouraged to review specific service terms.
    15. User Feedback: Eventify values user feedback for continuous improvement. Users are encouraged to provide constructive feedback and ratings based on their experiences with vendors and services.
    16. Intellectual Property Rights: Eventify respects intellectual property rights. Users and vendors must ensure they have the right to share content on the platform and avoid infringement of copyrights or trademarks.
    17. System Updates: Eventify regularly updates its systems to enhance performance and security. Users are advised to keep their apps updated to access the latest features and improvements.
    18. User Education: Eventify provides resources and educational content to help users navigate the platform effectively. Users are encouraged to explore help resources and contact support if needed.
    19. Community Engagement: Eventify fosters a community-driven environment. Users are invited to participate in discussions, forums, and events to enhance their overall experience and contribute to the community.
    20. Legal Compliance: Eventify operates in compliance with applicable laws and regulations. Users and vendors are expected to adhere to local laws and regulations while using the platform.

    Thank you for being a part of Eventify! For a detailed understanding, please refer to our comprehensive policies on our official website.
  ''';

  const PolicyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('App Policies'),
        backgroundColor: Colors.white, // Your app's theme color
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  'Version 1.0.0',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 16),
              Text(
                policyContent,
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
