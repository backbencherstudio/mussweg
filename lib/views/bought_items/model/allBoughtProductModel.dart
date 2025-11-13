
 class AllBoughtProductModel {
   bool? success;
   String? message;
   List<Data>? data;
   Pagination? pagination;

   AllBoughtProductModel({this.success, this.message, this.data, this.pagination});

   AllBoughtProductModel.fromJson(Map<String, dynamic> json) {
     success = json['success'];
     message = json['message'];
     if (json['data'] != null) {
       data = <Data>[];
       json['data'].forEach((v) {
         data!.add(Data.fromJson(v));
       });
     }
     pagination = json['pagination'] != null ? Pagination.fromJson(json['pagination']) : null;
   }

   Map<String, dynamic> toJson() {
     final Map<String, dynamic> data = {};
     data['success'] = success;
     data['message'] = message;
     if (this.data != null) data['data'] = this.data!.map((v) => v.toJson()).toList();
     if (pagination != null) data['pagination'] = pagination!.toJson();
     return data;
   }
 }

 class Data {
   String? orderId;
   String? orderStatus;
   OrderPartner? orderPartner;
   List<Items>? items;

   Data({this.orderId, this.orderStatus, this.orderPartner, this.items});

   Data.fromJson(Map<String, dynamic> json) {
     orderId = json['order_id']?.toString();
     orderStatus = json['order_status']?.toString();
     orderPartner = json['order_partner'] != null ? OrderPartner.fromJson(json['order_partner']) : null;
     if (json['items'] != null) {
       items = <Items>[];
       json['items'].forEach((v) => items!.add(Items.fromJson(v)));
     }
   }

   Map<String, dynamic> toJson() {
     final Map<String, dynamic> data = {};
     data['order_id'] = orderId;
     data['order_status'] = orderStatus;
     if (orderPartner != null) data['order_partner'] = orderPartner!.toJson();
     if (items != null) data['items'] = items!.map((v) => v.toJson()).toList();
     return data;
   }
 }

 class OrderPartner {
   String? id;
   String? name;
   String? email;
   String? avatar;

   OrderPartner({this.id, this.name, this.email, this.avatar});

   OrderPartner.fromJson(Map<String, dynamic> json) {
     id = json['id']?.toString();
     name = json['name']?.toString();
     email = json['email']?.toString();
     avatar = json['avatar']?.toString();
   }

   Map<String, dynamic> toJson() {
     final Map<String, dynamic> data = {};
     data['id'] = id;
     data['name'] = name;
     data['email'] = email;
     data['avatar'] = avatar;
     return data;
   }
 }

 class Items {
   int quantity;
   double price;
   double totalPrice;
   String? productId;
   String? productTitle;
   String? productOwnerId;
   List<String>? productPhoto;

   Items({
     required this.quantity,
     required this.price,
     required this.totalPrice,
     this.productId,
     this.productTitle,
     this.productOwnerId,
     this.productPhoto,
   });

   Items.fromJson(Map<String, dynamic> json)
       : quantity = json['quantity'] is String ? int.tryParse(json['quantity']) ?? 0 : json['quantity'] ?? 0,
         price = json['price'] is String ? double.tryParse(json['price']) ?? 0.0 : (json['price']?.toDouble() ?? 0.0),
         totalPrice = json['total_price'] is String
             ? double.tryParse(json['total_price']) ?? 0.0
             : (json['total_price']?.toDouble() ?? 0.0),
         productId = json['product_id']?.toString(),
         productTitle = json['product_title']?.toString(),
         productOwnerId = json['product_owner_id']?.toString(),
         productPhoto = json['product_photo'] != null ? List<String>.from(json['product_photo']) : null;

   Map<String, dynamic> toJson() {
     final Map<String, dynamic> data = {};
     data['quantity'] = quantity;
     data['price'] = price;
     data['total_price'] = totalPrice;
     data['product_id'] = productId;
     data['product_title'] = productTitle;
     data['product_owner_id'] = productOwnerId;
     data['product_photo'] = productPhoto;
     return data;
   }
 }

 class Pagination {
   int total;
   int page;
   int perPage;
   int totalPages;
   bool? hasNextPage;
   bool? hasPrevPage;

   Pagination({
     required this.total,
     required this.page,
     required this.perPage,
     required this.totalPages,
     this.hasNextPage,
     this.hasPrevPage,
   });

   Pagination.fromJson(Map<String, dynamic> json)
       : total = json['total'] is String ? int.tryParse(json['total']) ?? 0 : json['total'] ?? 0,
         page = json['page'] is String ? int.tryParse(json['page']) ?? 0 : json['page'] ?? 0,
         perPage = json['perPage'] is String ? int.tryParse(json['perPage']) ?? 0 : json['perPage'] ?? 0,
         totalPages = json['totalPages'] is String ? int.tryParse(json['totalPages']) ?? 0 : json['totalPages'] ?? 0,
         hasNextPage = json['hasNextPage'],
         hasPrevPage = json['hasPrevPage'];

   Map<String, dynamic> toJson() {
     final Map<String, dynamic> data = {};
     data['total'] = total;
     data['page'] = page;
     data['perPage'] = perPage;
     data['totalPages'] = totalPages;
     data['hasNextPage'] = hasNextPage;
     data['hasPrevPage'] = hasPrevPage;
     return data;
   }
 }
