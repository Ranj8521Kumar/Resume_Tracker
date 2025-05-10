import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ResumeData {
  final String recipient;
  final int viewCount;
  final DateTime firstViewedAt;
  final DateTime lastViewedAt;

  ResumeData({
    required this.recipient,
    required this.viewCount,
    required this.firstViewedAt,
    required this.lastViewedAt,
  });

  factory ResumeData.fromJson(Map<String, dynamic> json) {
    return ResumeData(
      recipient: json['recipient'],
      viewCount: json['viewCount'],
      firstViewedAt: DateTime.parse(json['firstViewedAt']),
      lastViewedAt: DateTime.parse(json['lastViewedAt']),
    );
  }
}

class ResumeService extends ChangeNotifier {
  final String baseUrl = 'https://my-resume-32bl.onrender.com';
  List<ResumeData> _resumeData = [];
  bool _isLoading = false;
  String? _error;

  List<ResumeData> get resumeData => _resumeData;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchDashboardData() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final response = await http.get(Uri.parse('$baseUrl/track'));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        _resumeData = data.map((item) => ResumeData.fromJson(item)).toList();
      } else {
        _error = 'Failed to load dashboard data: ${response.statusCode}';
      }
    } catch (e) {
      _error = 'Error connecting to server: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<Map<String, dynamic>> uploadResume(File file, String recipient, String email) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      var request = http.MultipartRequest('POST', Uri.parse('$baseUrl/upload'));

      request.fields['recipient'] = recipient;
      request.fields['email'] = email;

      request.files.add(
        await http.MultipartFile.fromPath(
          'resume',
          file.path,
        ),
      );

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      return _processUploadResponse(response, recipient);
    } catch (e) {
      _error = 'Error uploading resume: $e';
      return {'success': false, 'message': _error};
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Method for web platform that accepts bytes instead of File
  Future<Map<String, dynamic>> uploadResumeWeb(
      Uint8List fileBytes, String fileName, String recipient, String email) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      var request = http.MultipartRequest('POST', Uri.parse('$baseUrl/upload'));

      request.fields['recipient'] = recipient;
      request.fields['email'] = email;

      // Create a MultipartFile from bytes for web
      request.files.add(
        http.MultipartFile.fromBytes(
          'resume',
          fileBytes,
          filename: fileName,
        ),
      );

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      return _processUploadResponse(response, recipient);
    } catch (e) {
      _error = 'Error uploading resume: $e';
      return {'success': false, 'message': _error};
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Helper method to process the upload response
  Future<Map<String, dynamic>> _processUploadResponse(
      http.Response response, String recipient) async {
    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      if (data['success']) {
        // Save the tracking link to shared preferences
        final prefs = await SharedPreferences.getInstance();
        final trackingLinks = prefs.getStringList('trackingLinks') ?? [];
        final trackingLink = '$baseUrl/track/${Uri.encodeComponent(recipient)}';

        if (!trackingLinks.contains(trackingLink)) {
          trackingLinks.add(trackingLink);
          await prefs.setStringList('trackingLinks', trackingLinks);
        }

        return {
          'success': true,
          'trackingLink': trackingLink,
        };
      } else {
        _error = data['message'] ?? 'Upload failed';
        return {'success': false, 'message': _error};
      }
    } else {
      _error = 'Server error: ${response.statusCode}';
      return {'success': false, 'message': _error};
    }
  }

  Future<List<String>> getSavedTrackingLinks() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList('trackingLinks') ?? [];
  }
}
