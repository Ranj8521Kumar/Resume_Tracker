import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../services/resume_service.dart';

class ResumeCard extends StatelessWidget {
  final ResumeData data;

  const ResumeCard({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              data.recipient,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            _buildInfoRow(
              'Total Views',
              data.viewCount.toString(),
              Icons.visibility,
            ),
            _buildInfoRow(
              'First Viewed',
              DateFormat('MMM d, yyyy - h:mm a').format(data.firstViewedAt),
              Icons.calendar_today,
            ),
            _buildInfoRow(
              'Last Viewed',
              DateFormat('MMM d, yyyy - h:mm a').format(data.lastViewedAt),
              Icons.update,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Icon(icon, size: 16, color: Colors.grey),
          const SizedBox(width: 8),
          Text(
            '$label: ',
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              color: Colors.grey,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
