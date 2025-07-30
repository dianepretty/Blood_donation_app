import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/language/bloc.dart';
import '../widgets/main_navigation.dart';
import 'package:blood_system/l10n/app_localizations.dart';

class LanguageSelectionScreen extends StatelessWidget {
  const LanguageSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    
    return MainNavigationWrapper(
      backgroundColor: Colors.white,
      currentPage: '/language',
      pageTitle: l10n.selectLanguage,
      child: BlocBuilder<LanguageBloc, LanguageState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Text(
                  l10n.selectLanguage,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[800],
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Choose your preferred language for the app',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 32),
                                _buildLanguageOption(
                  context,
                  l10n.english,
                  'English',
                  'en',
                  Icons.language,
                  Colors.blue,
                  state is LanguageLoadedState && state.locale.languageCode == 'en',
                ),
                const SizedBox(height: 16),
                _buildLanguageOption(
                  context,
                  l10n.french,
                  'French',
                  'fr',
                  Icons.language,
                  Colors.green,
                  state is LanguageLoadedState && state.locale.languageCode == 'fr',
                ),
                const SizedBox(height: 16),
                _buildLanguageOption(
                  context,
                  l10n.kinyarwanda,
                  'Kinyarwanda',
                  'rw',
                  Icons.language,
                  Colors.orange,
                  state is LanguageLoadedState && state.locale.languageCode == 'rw',
                ),
                const Spacer(),
                if (state is LanguageLoadedState)
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(l10n.languageChanged),
                            backgroundColor: Colors.green,
                          ),
                        );
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFD7263D),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                                              child: Text(
                          l10n.save,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildLanguageOption(
    BuildContext context,
    String displayName,
    String nativeName,
    String languageCode,
    IconData icon,
    Color color,
    bool isSelected,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: isSelected ? color.withOpacity(0.1) : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isSelected ? color : Colors.grey.shade300,
          width: isSelected ? 2 : 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            color: color,
            size: 24,
          ),
        ),
        title: Text(
          displayName,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: isSelected ? color : Colors.grey[800],
          ),
        ),
        subtitle: Text(
          nativeName,
          style: TextStyle(
            fontSize: 14,
            color: isSelected ? color.withOpacity(0.8) : Colors.grey[600],
          ),
        ),
        trailing: isSelected
            ? Icon(
                Icons.check_circle,
                color: color,
                size: 24,
              )
            : null,
        onTap: () {
          context.read<LanguageBloc>().add(
                LanguageChanged(Locale(languageCode)),
              );
        },
      ),
    );
  }
} 