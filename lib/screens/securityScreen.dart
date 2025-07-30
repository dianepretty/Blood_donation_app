import 'package:blood_system/widgets/main_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../theme/theme.dart';
import 'package:blood_system/l10n/app_localizations.dart';
import '../blocs/language/bloc.dart';

class SecurityScreen extends StatefulWidget {
  const SecurityScreen({super.key});

  @override
  State<SecurityScreen> createState() => _SecurityScreenState();
}

class _SecurityScreenState extends State<SecurityScreen> {
  bool isTwoFactorEnabled = false;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    
    return MainNavigationWrapper(
      backgroundColor: Colors.white,
      currentPage: '/security',
      pageTitle: l10n.settings,
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        children: [
          SectionTitle(title: l10n.language),
          BlocBuilder<LanguageBloc, LanguageState>(
            builder: (context, languageState) {
              String currentLanguage = 'English';
              if (languageState is LanguageLoadedState) {
                switch (languageState.locale.languageCode) {
                  case 'en':
                    currentLanguage = l10n.english;
                    break;
                  case 'fr':
                    currentLanguage = l10n.french;
                    break;
                  case 'rw':
                    currentLanguage = l10n.kinyarwanda;
                    break;
                }
              }
              
              return ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(l10n.language),
                subtitle: Text(
                  currentLanguage,
                  style: TextStyle(color: Colors.blueGrey),
                ),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {
                  Navigator.pushNamed(context, '/language');
                },
              );
            },
          ),
          const SizedBox(height: 24),
          SectionTitle(title: l10n.security),
          ListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(l10n.changePassword),
            subtitle: Text(
              l10n.lastChanged(3),
              style: TextStyle(color: Colors.blueGrey),
            ),
            // trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            // onTap: () {
            //   Navigator.pushNamed(context, '/changePassword');
            // },
          ),
          const SizedBox(height: 24),
          // const SectionTitle(title: 'Two‑factor authentication'),
          // ListTile(
          //   contentPadding: EdgeInsets.zero,
          //   title: const Text('Two‑factor authentication'),
          //   subtitle: const Text(
          //     'Recommended',
          //     style: TextStyle(color: Colors.blueGrey),
          //   ),
          //   trailing: Switch(
          //     value: isTwoFactorEnabled,
          //     onChanged: (value) {
          //       setState(() {
          //         isTwoFactorEnabled = value;
          //       });
          //     },
          //   ),
          // ),
          _buildSection(l10n.appInformation, [
            _buildInfoTile(l10n.appVersion, '1.0.0'),
            _buildInfoTile(l10n.lastUpdated, '2025'),
          ]),
          const SizedBox(height: 24),
          SectionTitle(title: l10n.other),
          ListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(l10n.privacyPolicy),
            subtitle: Text(
              l10n.privacyPolicyDesc,
              style: TextStyle(color: Colors.blueGrey),
            ),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {},
          ),
          ListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(l10n.termsOfService),
            subtitle: Text(
              l10n.termsOfServiceDesc,
              style: TextStyle(color: Colors.blueGrey),
            ),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {},
          ),
        ],
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
            fontWeight: FontWeight.w600,
            color: Color(0xFF333333),
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
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 16, color: Color(0xFF666666)),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Color(0xFF333333),
            ),
          ),
        ],
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;

  const SectionTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }
}
