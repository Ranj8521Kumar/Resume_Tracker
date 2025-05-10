import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/services.dart';
import 'package:file_picker/file_picker.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../services/resume_service.dart';

class UploadScreen extends StatefulWidget {
  const UploadScreen({Key? key}) : super(key: key);

  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  final _formKey = GlobalKey<FormState>();
  final _recipientController = TextEditingController();
  final _emailController = TextEditingController();
  File? _selectedFile;
  Uint8List? _selectedFileBytes;
  String? _selectedFileName;
  String? _trackingLink;
  bool _isUploading = false;
  bool _isWeb = kIsWeb;

  Future<void> _pickFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
        withData: _isWeb, // Get file bytes for web platform
      );

      if (result != null) {
        setState(() {
          if (_isWeb) {
            // For web, use bytes
            _selectedFileBytes = result.files.single.bytes;
            _selectedFileName = result.files.single.name;
          } else {
            // For mobile/desktop, use File
            _selectedFile = File(result.files.single.path!);
          }
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error picking file: $e')),
      );
    }
  }

  Future<void> _uploadResume() async {
    bool canProceed = _formKey.currentState!.validate() &&
                      (_isWeb ? _selectedFileBytes != null : _selectedFile != null);

    if (canProceed) {
      setState(() {
        _isUploading = true;
      });

      try {
        final resumeService = Provider.of<ResumeService>(context, listen: false);
        final Map<String, dynamic> result;

        if (_isWeb) {
          // For web platform
          result = await resumeService.uploadResumeWeb(
            _selectedFileBytes!,
            _selectedFileName!,
            _recipientController.text.trim(),
            _emailController.text.trim(),
          );
        } else {
          // For mobile/desktop platforms
          result = await resumeService.uploadResume(
            _selectedFile!,
            _recipientController.text.trim(),
            _emailController.text.trim(),
          );
        }

        if (result['success']) {
          setState(() {
            _trackingLink = result['trackingLink'];
            _isUploading = false;
          });
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(result['message'])),
          );
          setState(() {
            _isUploading = false;
          });
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
        setState(() {
          _isUploading = false;
        });
      }
    }
  }

  Future<void> _copyToClipboard() async {
    if (_trackingLink != null) {
      await Clipboard.setData(ClipboardData(text: _trackingLink!));
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Tracking link copied to clipboard')),
      );
    }
  }

  Future<void> _openLink() async {
    if (_trackingLink != null) {
      final Uri url = Uri.parse(_trackingLink!);
      if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Could not open $url')),
        );
      }
    }
  }

  @override
  void dispose() {
    _recipientController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upload Resume'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  controller: _recipientController,
                  decoration: const InputDecoration(
                    labelText: 'Recipient Name',
                    hintText: 'e.g., Company or Recruiter Name',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a recipient name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: 'Your Email',
                    hintText: 'Enter your email for notifications',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                OutlinedButton.icon(
                  onPressed: _pickFile,
                  icon: const Icon(Icons.upload_file),
                  label: const Text('Select Resume (PDF)'),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                  ),
                ),
                const SizedBox(height: 10),
                if (_isWeb ? _selectedFileName != null : _selectedFile != null)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Text(
                      'Selected file: ${_isWeb ? _selectedFileName! : _selectedFile!.path.split('/').last}',
                      style: const TextStyle(color: Colors.green),
                    ),
                  ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _isUploading ? null : _uploadResume,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                  ),
                  child: _isUploading
                      ? const CircularProgressIndicator()
                      : const Text('Generate Tracking Link'),
                ),
                if (_trackingLink != null) ...[
                  const SizedBox(height: 30),
                  const Divider(),
                  const SizedBox(height: 10),
                  const Text(
                    'Tracking Link Generated!',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    _trackingLink!,
                    style: const TextStyle(fontSize: 14),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton.icon(
                        onPressed: _copyToClipboard,
                        icon: const Icon(Icons.copy),
                        label: const Text('Copy Link'),
                      ),
                      ElevatedButton.icon(
                        onPressed: _openLink,
                        icon: const Icon(Icons.open_in_browser),
                        label: const Text('Open Link'),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

