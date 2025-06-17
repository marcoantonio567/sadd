class Post {
  final int userId;
  final int id;
  final String title;
  final String body;
  bool isLiked;
  int likeCount;

  Post({
    required this.userId,
    required this.id,
    required this.title,
    required this.body,
    this.isLiked = false,
    this.likeCount = 0,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
      body: json['body'],
      likeCount: json['likeCount'] ?? 0,
    );
  }
}
