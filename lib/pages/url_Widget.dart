// reference_footer.dart

// ignore_for_file: avoid_print, unnecessary_to_list_in_spreads

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ReferenceItem {
  final String linkText;
  final Uri url;

  ReferenceItem({
    required this.linkText,
    required this.url,
  });
}

class ReferenceFooter extends StatelessWidget {
  final String title;
  final List<ReferenceItem> references;

  const ReferenceFooter({
    super.key,
    this.title = 'แหล่งอ้างอิง',
    required this.references,
  });

  Future<void> _launchUrl(Uri url) async {
    try {
      if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
        throw Exception('ไม่สามารถเปิด URL นี้ได้: $url');
      }
    } catch (e) {
      print('เกิดข้อผิดพลาดในการเปิด URL: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: Column(
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF004aad),
            ),
          ),
          const SizedBox(height: 10),
          ...references
              .map((reference) => Column(
                    children: [
                      InkWell(
                        onTap: () => _launchUrl(reference.url),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 16),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.link, color: Color(0xFF0BD8F3)),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  reference.linkText,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.blue[800],
                                  ),
                                ),
                              ),
                              const Icon(Icons.open_in_new, color: Colors.grey),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 10,)
                    ],
                  ))
              .toList(),
        ],
      ),
    );
  }
}
