class Book {
  final String? title;
  final String? author;
  final String? notes;
  final String? categories;
  final String? description;
  final String? id;
  final String? userId;
  final String? photoUrl;
  final int? pageCount;
  final String? publishedDate;
  Book({
    this.publishedDate,
    this.pageCount,
    this.photoUrl,
    this.title,
    this.author,
    this.notes,
    this.categories,
    this.description,
    this.id,
    this.userId,
  });
  factory Book.formap(data) {
    return Book(
        author: data['author'],
        title: data['title'],
        categories: data['categories'],
        description: data['description'],
        id: data['id'],
        notes: data['notes'],
        userId: data['user_id'],
        photoUrl: data['photo_url'],
        pageCount: data['page_count'],
        publishedDate: data['published_date']);
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'user_id': userId,
      'author': author,
      'notes': notes,
      'photo_url': photoUrl,
      'published_date': publishedDate,
      // 'rating': rating,
      'description': description,
      'page_count': pageCount,
      // 'started_reading_at': startedReading,
      // 'finished_reading_at': finishedReading,
      'categories': categories,
    };
  }
}
