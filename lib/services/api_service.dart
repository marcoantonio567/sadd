import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/post.dart';
import '../models/comment.dart';
import '../models/album.dart';
import '../models/photo.dart';

class ApiService {
  static const String baseUrl = 'https://jsonplaceholder.typicode.com';

  // Método para buscar posts
  static Future<List<Post>> fetchPosts() async {
    final response = await http.get(Uri.parse('$baseUrl/posts'));
    if (response.statusCode == 200) {
      List<dynamic> body = json.decode(response.body);
      return body.map((dynamic item) => Post.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load posts');
    }
  }

  // Método para buscar comentários
  static Future<List<Comment>> fetchComments() async {
    final response = await http.get(Uri.parse('$baseUrl/comments'));
    if (response.statusCode == 200) {
      List<dynamic> body = json.decode(response.body);
      return body.map((dynamic item) => Comment.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load comments');
    }
  }

  // Método para buscar álbuns
  static Future<List<Album>> fetchAlbums() async {
    final response = await http.get(Uri.parse('$baseUrl/albums'));
    if (response.statusCode == 200) {
      List<dynamic> body = json.decode(response.body);
      return body.map((dynamic item) => Album.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load albums');
    }
  }

  // Método para buscar fotos
  static Future<List<Photo>> fetchPhotos() async {
    final response = await http.get(Uri.parse('$baseUrl/photos'));
    if (response.statusCode == 200) {
      List<dynamic> body = json.decode(response.body);
      return body.map((dynamic item) => Photo.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load photos');
    }
  }
}
