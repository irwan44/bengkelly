class RssFeed {
   String? title;
   String? author;
   String? category;
   DateTime? date;
   String? content;
   String? imageUrl;

   RssFeed({
     this.title,
     this.author,
     this.category,
     this.date,
     this.content,
    this.imageUrl,
  });

  factory RssFeed.fromJson(Map<String, dynamic> json) {
    return RssFeed(
      title: json['title']['rendered'],
      author: json['_embedded']['author']?[0]['name'] ?? 'Unknown',
      category: json['_embedded']['wp:term']?[0][0]['name'] ?? 'Uncategorized',
      date: DateTime.parse(json['date']),
      content: json['content']['rendered'],
      imageUrl: json['_embedded']['wp:featuredmedia'] != null ? json['_embedded']['wp:featuredmedia'][0]['source_url'] : null,
    );
  }
}