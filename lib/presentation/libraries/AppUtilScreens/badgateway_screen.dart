import 'package:flutter/material.dart';
import '../../themes/app_color.dart';
import 'package:flutter/services.dart';

class BadgatewayScreen extends StatelessWidget {
  const BadgatewayScreen({super.key});

  static const _supportPhone = '6296981547';

  void _showContactDialog(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Contact Support'),
        content: Text('Please call $_supportPhone for backend support.'),
        actions: [
          TextButton(
            onPressed: () async {
              await Clipboard.setData(const ClipboardData(text: _supportPhone));
              Navigator.of(ctx).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Phone number copied to clipboard'),
                ),
              );
            },
            child: const Text('Copy'),
          ),
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                horizontal: 24.0,
                vertical: 32.0,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 48,
                    backgroundColor: AppColor.primaryActionColor.withOpacity(
                      0.12,
                    ),
                    child: Icon(
                      Icons.cloud_off_rounded,
                      size: 52,
                      color: AppColor.primaryActionColor,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Bad Gateway (502)',
                    textAlign: TextAlign.center,
                    style: theme.textTheme.titleLarge?.copyWith(
                      color: theme.colorScheme.onSurface,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'The server is temporarily unavailable.\nPlease try again later or contact support.',
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: AppColor.grey,
                    ),
                  ),
                  const SizedBox(height: 28),

                  Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              'https://global-sport-network.s3.ap-south-1.amazonaws.com/scaled_1000008003.jpg',
                              width: 72,
                              height: 72,
                              fit: BoxFit.cover,
                              errorBuilder: (ctx, err, st) => Container(
                                width: 72,
                                height: 72,
                                color: AppColor.grey.withOpacity(0.1),
                                child: const Icon(
                                  Icons.person,
                                  size: 36,
                                  color: AppColor.grey,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Sourashis Das',
                                  style: theme.textTheme.bodyLarge?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Project Organizer',
                                  style: theme.textTheme.bodySmall,
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                            tooltip: 'Contact',
                            onPressed: () => _showContactDialog(context),
                            icon: CircleAvatar(
                              backgroundColor: AppColor.primaryActionColor,
                              child: const Icon(
                                Icons.call_rounded,
                                color: AppColor.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 28),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        backgroundColor: AppColor.primaryActionColor,
                      ),
                      onPressed: () {
                        // Try to return to the first route so app can recover or navigate to home.
                        Navigator.of(
                          context,
                        ).popUntil((route) => route.isFirst);
                      },
                      child: const Text(
                        'Refresh',
                        style: TextStyle(color: AppColor.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
