import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mussweg/views/profile/widgets/simple_apppbar.dart';

class BidList extends StatefulWidget {
  const BidList({super.key});

  @override
  State<BidList> createState() => _BidListState();
}

class _BidListState extends State<BidList> {
  final List<Map<String, dynamic>> bids = [
    {
      'title': 'Floyd Miles',
      'subTitle': '\$18.00',
      'leading': 'assets/icons/myyyy.jpeg',
    },
    {
      'title': 'Esther Howard',
      'subTitle': '\$16.00',
      'leading': 'assets/icons/myyyy.jpeg',
    },
    {
      'title': 'Jacob Jones',
      'subTitle': '\$15.00',
      'leading': 'assets/icons/myyyy.jpeg',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimpleApppbar(title: 'Bid Request'),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Product Info Card
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                padding: EdgeInsets.all(8.w),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8.r),
                      child: Image.asset(
                        'assets/images/post_card.png',
                        width: 80.w,
                        height: 60.h,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Men Exclusive T-Shirt',
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xff4A4C56),
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            'Size XL (New Condition)',
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: const Color(0xff777980),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          '\$20.00',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18.sp,
                            color: const Color(0xffDE3526),
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          '(12h :12m :30s)',
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: const Color(0xff1A9882),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              SizedBox(height: 20.h),

              // Total Bid Title
              Text(
                'Total Bid',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xff4A4C56),
                ),
              ),

              SizedBox(height: 10.h),

              ListView.builder(
                itemCount: bids.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  final bid = bids[index];
                  return ListTile(
                    contentPadding: EdgeInsets.symmetric(vertical: 6.h),
                    leading: ClipOval(
                      child: Image.asset(
                        bid['leading'],
                        width: 50.w,
                        height: 50.h,
                        fit: BoxFit.cover,
                      ),
                    ),
                    title: Text(
                      bid['title'],
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xff4A4C56),
                      ),
                    ),
                    subtitle: Text(
                      bid['subTitle'],
                      style: TextStyle(
                        fontSize: 15.sp,
                        color: Colors.grey.shade700,
                      ),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xffDE3526),
                            padding: EdgeInsets.symmetric(
                                horizontal: 12.w, vertical: 6.h),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6.r),
                            ),
                          ),
                          child: Text(
                            'Accept',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12.sp,
                            ),
                          ),
                        ),
                        SizedBox(width: 8.w),
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            side: const BorderSide(color: Color(0xffDE3526)),
                            padding: EdgeInsets.symmetric(
                                horizontal: 12.w, vertical: 6.h),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6.r),
                            ),
                          ),
                          child: Text(
                            'Reject',
                            style: TextStyle(
                              color: const Color(0xffDE3526),
                              fontSize: 12.sp,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
