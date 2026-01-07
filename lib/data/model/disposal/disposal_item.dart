class DisposalItem {
  final String disposalId;
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
    required this.disposalId,
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
      disposalId: json['disposalId'] as String,
      productname: json['productname'] as String,
      productsize: json['productsize'],
      condition: json['condition'] as String,
      finalTotalAmount: json['final_total_amount'].toString(),
      productquantity: json['productquantity'] as int,
      productphoto: json['productphoto'],
      photoUrl: json['photoUrl'],
      status: json['status'] as String,
      paymentStatus: json['payment_status'] as String,
      comment: json['comment'],
      penaltyAmount: json['penaltyAmount'],
    );
  }
}
