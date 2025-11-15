class DisposalItem {
  final String productname;
  final String? productsize;
  final String condition;
  final String finalTotalAmount;
  final int productquantity;
  final String? productphoto;
  final String? photoUrl;
  final String status;
  final String paymentStatus;
  final String? comment;
  final String? penaltyAmount;

  DisposalItem({
    required this.productname,
    this.productsize,
    required this.condition,
    required this.finalTotalAmount,
    required this.productquantity,
    this.productphoto,
    this.photoUrl,
    required this.status,
    required this.paymentStatus,
    this.comment,
    this.penaltyAmount,
  });

  factory DisposalItem.fromJson(Map<String, dynamic> json) {
    return DisposalItem(
      productname: json['productname'] ?? '',
      productsize: json['productsize'],
      condition: json['condition'] ?? '',
      finalTotalAmount: json['final_total_amount'] ?? '',
      productquantity: json['productquantity'] ?? 0,
      productphoto: json['productphoto'] ?? '',
      photoUrl: json['photoUrl'] ?? '',
      status: json['status'] ?? '',
      paymentStatus: json['payment_status'] ?? '',
      comment: json['comment'],
      penaltyAmount: json['penaltyAmount'],
    );
  }
}
