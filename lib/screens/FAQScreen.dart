import 'package:blood_system/widgets/main_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FAQScreen extends StatelessWidget {
  const FAQScreen({super.key});

  static const List<Map<String, String>> faqItems = [
    {
      'title': 'Getting Started',
      'subtitle': 'Learn about managing events, appointments, and profiles.',
    },
    {
      'title': 'General Questions',
      'subtitle': 'Find answers to common questions about Linklife.',
    },
    {
      'title': 'Troubleshooting',
      'subtitle': 'Troubleshoot issues with the app.',
    },
  ];

  static const List<Map<String, String>> supportItems = [
    {
      'title': 'How‑to Guides',
      'subtitle': 'Step‑by‑step guides for using Linklife features.',
    },
    {
      'title': 'Feature Documentation',
      'subtitle': "Detailed information about Linklife's features.",
    },
  ];

  static const List<Map<String, Object>> contactItems = [
    {
      'title': 'Email Support',
      'subtitle': 'linklife@gmail.com',
      'icon': Icons.email,
    },
    {
      'title': 'Phone Support',
      'subtitle': 'call us at +250 788 123 456',
      'icon': Icons.phone,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).copyWith(
      dividerColor: Colors.transparent,
      expansionTileTheme: const ExpansionTileThemeData(
        backgroundColor: Colors.white,
        collapsedBackgroundColor: Colors.white,
      ),
    );

    return MainNavigationWrapper(
      backgroundColor: Colors.white,
      currentPage: '/help',
      pageTitle: 'Help',
      child: Theme(
        data: theme,
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          children: [
            const SectionHeader(title: 'FAQs'),
            const SizedBox(height: 8),
            ...faqItems.map((item) {
              final title = item['title']!;
              final subtitle = item['subtitle']!;
              return ExpansionTile(
                tilePadding: EdgeInsets.zero,
                childrenPadding: const EdgeInsets.only(left: 56, bottom: 8),
                leading: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(Icons.help_outline, color: Colors.grey),
                ),
                title: Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      subtitle,
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                  ),
                ],
              );
            }).toList(),
            const SizedBox(height: 24),
            const SectionHeader(title: 'Support Information'),
            const SizedBox(height: 8),
            ...supportItems.map((item) {
              final title = item['title']!;
              final subtitle = item['subtitle']!;
              return ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    Icons.insert_drive_file_outlined,
                    color: Colors.grey,
                  ),
                ),
                title: Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                subtitle: Text(
                  subtitle,
                  style: TextStyle(color: Colors.grey[600]),
                ),
                onTap: () {},
              );
            }).toList(),
            const SizedBox(height: 24),
            _buildSection('Eligibility Requirements', [
              _buildInfoTile('Age', '16-17+'),
              _buildInfoTile('Weight', 'Minimum 110 lbs (50 kg)'),
              _buildInfoTile('Health', 'General good health'),
              _buildInfoTile('Documents', 'Valid photo ID required'),
            ]),
            const SizedBox(height: 24),
            const SectionHeader(title: 'Contact Us'),
            const SizedBox(height: 8),
            ...contactItems.map((item) {
              final title = item['title'] as String;
              final subtitle = item['subtitle'] as String;
              final icon = item['icon'] as IconData;
              return ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(icon, color: Colors.grey),
                ),
                title: Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                subtitle: Text(
                  subtitle,
                  style: TextStyle(color: Colors.grey[600]),
                ),
                onTap: () {},
              );
            }).toList(),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            // color: Color(0xFF333333),
          ),
        ),
        const SizedBox(height: 16),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(children: children),
        ),
      ],
    );
  }

  Widget _buildInfoTile(String label, String value) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Color(0xFF666666))),
          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              color: Color(0xFF333333),
            ),
          ),
        ],
      ),
    );
  }
}

class SectionHeader extends StatelessWidget {
  final String title;
  const SectionHeader({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).appBarTheme.titleTextStyle;
    return Text(
      title,
      style: (style ?? const TextStyle(fontSize: 20, color: Colors.black))
          .copyWith(fontWeight: FontWeight.bold),
    );
  }
}
