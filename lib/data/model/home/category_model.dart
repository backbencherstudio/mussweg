class Category {
  final String categoryId;
  final String categoryName;
  final String categoryDescription;
  final int status;
  final String photo;

  Category({
    required this.categoryId,
    required this.categoryName,
    required this.categoryDescription,
    required this.status,
    required this.photo,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      categoryId: json['category_id'] ?? '',
      categoryName: json['category_name'] ?? '',
      categoryDescription: json['category_description'] ?? '',
      status: json['status'] ?? 0,
      photo: json['photo'] ?? '',
    );
  }
}

class CategoryModel {
  final bool success;
  final String message;
  final List<Category> data;

  CategoryModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    var list = json['data'] as List? ?? [];
    List<Category> dataList =
    list.map((item) => Category.fromJson(item)).toList();

    return CategoryModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: dataList,
    );
  }
}
