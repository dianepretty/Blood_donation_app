import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/auth/bloc.dart';
import '../blocs/auth/state.dart';
import '../widgets/main_navigation.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MainNavigationWrapper(
      currentPage: 'history',
      pageTitle: 'Donation History',
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is AuthAuthenticated) {
            return _buildHistoryContent(context);
          } else {
            return const Center(
              child: CircularProgressIndicator(color: Color(0xFFB83A3A)),
            );
          }
        },
      ),
    );
  }

  Widget _buildHistoryContent(BuildContext context) {
    // Mock donation history data - replace with actual data from your backend
    final donationHistory = [
      {
        'date': '2024-01-15',
        'hospital': 'City General Hospital',
        'bloodType': 'O+',
        'status': 'Completed',
        'amount': '450ml',
      },
      {
        'date': '2023-12-20',
        'hospital': 'Regional Medical Center',
        'bloodType': 'O+',
        'status': 'Completed',
        'amount': '450ml',
      },
      {
        'date': '2023-11-10',
        'hospital': 'Community Health Clinic',
        'bloodType': 'O+',
        'status': 'Completed',
        'amount': '450ml',
      },
    ];

    return RefreshIndicator(
      onRefresh: () async {
        // Refresh donation history
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Refreshing donation history...'),
            backgroundColor: Color(0xFFB83A3A),
          ),
        );
      },
      child:
      donationHistory.isEmpty
          ? _buildEmptyState(context)
          : ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: donationHistory.length,
        itemBuilder: (context, index) {
          return _buildHistoryCard(context, donationHistory[index]);
        },
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.history, size: 80, color: Colors.grey[400]),
          const SizedBox(height: 16),
          Text(
            'No Donation History',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Your donation history will appear here\nonce you make your first donation',
            style: TextStyle(fontSize: 16, color: Colors.grey[500]),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: () {
              // Navigate to book appointment
              Navigator.pushNamed(context, '/appointments');
            },
            icon: const Icon(Icons.add),
            label: const Text('Book Your First Donation'),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFB83A3A),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryCard(BuildContext context, Map<String, String> donation) {
    return Container(
        margin: const EdgeInsets.only(bottom: 16),
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
        child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      donation['date']!,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF333333),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF4CAF50).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        donation['status']!,
                        style: const TextStyle(
                          color: Color(0xFF4CAF50),
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Icon(
                      Icons.local_hospital,
                      color: const Color(0xFFB83A3A),
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        donation['hospital']!,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Color(0xFF666666),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.bloodtype, color: const Color(0xFFB83A3A), size: 20),
                    const SizedBox(width: 8),
                    Text(
                      'Blood Type: ${donation['bloodType']!}',
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color(0xFF666666),
                      ),
                    ),
                    const SizedBox(width: 24),
                    Icon(
                      Icons.water_drop,
                      color: const Color(0xFFB83A3A),
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Amount: ${donation['amount']!}',
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color(0xFF666666),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton.icon(
                      onPressed: () {
                        // View donation details
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Donation details coming soon!'),
                            backgroundColor: Color(0xFFB83A3A),
                          ),
                        );
                      },
                      icon: const Icon(Icons.info_outline, size: 16),
                      label: const Text('View Details'),
                      style: TextButton.styleFrom(
                        foregroundColor: const Color(0xFFB83A3A),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            ),
        );
    }
}