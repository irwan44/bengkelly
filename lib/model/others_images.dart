class OthersImage {
  final String? image;

  OthersImage(this.image);

  OthersImage.fromJson(String json) : image = json;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image'] = this.image;

    return data;
  }
}