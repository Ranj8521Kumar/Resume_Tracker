import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../services/resume_service.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  void initState() {
    super.initState();
    // Fetch data when screen loads
    Future.microtask(() => 
      Provider.of<ResumeService>(context, listen: false).fetchDashboardData()
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              Provider.of<ResumeService>(context, listen: false).fetchDashboardData();
            },
          ),
        ],
      ),
      body: Consumer<ResumeService>(
        builder: (context, resumeService, child) {
          if (resumeService.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (resumeService.error != null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Error: ${resumeService.error}',
                    style: const TextStyle(color: Colors.red),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      resumeService.fetchDashboardData();
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          if (resumeService.resumeData.isEmpty) {
            return const Center(
              child: Text(
                'No resume tracking data available yet.\nUpload a resume to start tracking.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
            );
          }

          return ListView.builder(
            itemCount: resumeService.resumeData.length,
            itemBuilder: (context, index) {
              final data = resumeService.resumeData[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
            },
          );
        },
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
