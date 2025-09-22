import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:mussweg/views/profile/widgets/simple_apppbar.dart';
import '../../../../view_model/profile/transaction_service_provider/transaction_service.dart';

class TransactionsHistoryPage extends StatelessWidget {
  const TransactionsHistoryPage({super.key});

  final List<Map<String, dynamic>> transactions = const [
    {'name': 'Jacob Jones', 'time': 'Today, 8:19 am', 'amount': '+20.00', 'color': Color(0xff116557), 'avatar': 'assets/icons/user_profile.png'},
    {'name': 'Darrell Steward', 'time': 'Today, 8:19 am', 'amount': '-20.00', 'color': Color(0xffB02E3A), 'avatar': 'assets/icons/user_profile.png'},
    {'name': 'Annette Black', 'time': 'Today, 8:19 am', 'amount': '-20.00', 'color': Color(0xffB02E3A), 'avatar': 'assets/icons/user_profile.png'},
    {'name': 'Kathryn Murphy', 'time': 'Today, 8:19 am', 'amount': '+20.00', 'color': Color(0xff116557), 'avatar': 'assets/icons/user_profile.png'},
    {'name': 'Courtney Henry', 'time': 'Today, 8:19 am', 'amount': '+20.00', 'color': Color(0xff116557), 'avatar': 'assets/icons/user_profile.png'},
    {'name': 'Albert Flores', 'time': 'Today, 8:19 am', 'amount': '+20.00', 'color': Color(0xff116557), 'avatar': 'assets/icons/user_profile.png'},
    {'name': 'Cody Fisher', 'time': 'Today, 8:19 am', 'amount': '+20.00', 'color': Color(0xff116557), 'avatar': 'assets/icons/user_profile.png'},
  ];

  List<Map<String, dynamic>> _filteredTransactions(String filter) {
    if (filter == 'Sent Money') {
      return transactions.where((tx) => tx['amount'].startsWith('-')).toList();
    } else if (filter == 'Receive Money') {
      return transactions.where((tx) => tx['amount'].startsWith('+')).toList();
    }
    return transactions;
  }

  @override
  Widget build(BuildContext context) {
    final service = GetIt.instance<TransactionService>();

    return Scaffold(
      appBar: const SimpleApppbar(title: 'Transactions History'),
      body: AnimatedBuilder(
        animation: service,
        builder: (context, _) {
          final filteredTransactions = _filteredTransactions(service.selectedFilter);

          return Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildFilterChip(service, 'All'),
                    _buildFilterChip(service, 'Sent Money'),
                    _buildFilterChip(service, 'Receive Money'),
                  ],
                ),
              ),
              Expanded(
                child: ListView.separated(
                  itemCount: filteredTransactions.length,
                  separatorBuilder: (_, __) => Divider(color: Colors.grey.shade200),
                  itemBuilder: (context, index) {
                    final tx = filteredTransactions[index];
                    return _buildTransactionItem(
                      context,
                      tx['name'],
                      tx['time'],
                      tx['amount'],
                      tx['color'],
                      tx['avatar'],
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
  Widget _buildFilterChip(TransactionService service, String text) {
    bool isSelected = service.selectedFilter == text;
    return GestureDetector(
      onTap: () => service.setFilter(text),
      child: Chip(
        label: Text(
          text,
          style: TextStyle(
            color: isSelected ? Colors.red : Colors.black,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            fontSize: 14.sp,
          ),
        ),
        backgroundColor: isSelected ? Colors.red.withOpacity(0.2) : Colors.grey[200],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.r),
        ),
      ),
    );
  }

  Widget _buildTransactionItem(
      BuildContext context,
      String name,
      String time,
      String amount,
      Color amountColor,
      String avatarUrl) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: Row(
        children: [
          CircleAvatar(
            radius: 24.w,
            backgroundImage: AssetImage(avatarUrl),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.sp,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  time,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          Text(
            amount,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16.sp,
              color: amountColor,
            ),
          ),
        ],
      ),
    );
  }
}