import 'package:flutter/material.dart';
import '../models/post.dart';
import '../services/api_service.dart';

class PostsScreen extends StatefulWidget {
  const PostsScreen({super.key});

  @override
  State<PostsScreen> createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {
  late Future<List<Post>> futurePosts;
  final ScrollController _scrollController = ScrollController();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    futurePosts = ApiService.fetchPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Post>>(
        future: futurePosts,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 60, color: Colors.red),
                  const SizedBox(height: 20),
                  Text(
                    'Erro ao carregar posts\n${snapshot.error}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed:
                        () => setState(() {
                          futurePosts = ApiService.fetchPosts();
                        }),
                    child: const Text('Tentar novamente'),
                  ),
                ],
              ),
            );
          }

          if (!snapshot.hasData) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 20),
                  Text('Carregando posts...'),
                ],
              ),
            );
          }

          final posts = snapshot.data!;

          return RefreshIndicator(
            onRefresh: () async {
              setState(() {
                futurePosts = ApiService.fetchPosts();
              });
            },
            child: CustomScrollView(
              controller: _scrollController,
              slivers: [
                SliverAppBar(
                  expandedHeight: 200,
                  flexibleSpace: FlexibleSpaceBar(
                    title: const Text(
                      'Posts',
                      style: TextStyle(color: Colors.white),
                    ),
                    background: Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.indigo, Colors.blue],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.article,
                          size: 60,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  pinned: true,
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    final post = posts[index];
                    return _buildPostCard(context, post);
                  }, childCount: posts.length),
                ),
                if (_isLoading)
                  const SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Center(child: CircularProgressIndicator()),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildPostCard(BuildContext context, Post post) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          // Aqui você pode adicionar navegação para detalhes do post
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Post #${post.id} selecionado'),
              duration: const Duration(seconds: 1),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.blue.withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.person, size: 20),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    'Usuário ${post.userId}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    '#${post.id}',
                    style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                post.title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                post.body,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade700,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.thumb_up_outlined, size: 20),
                    onPressed: () {},
                    color: Colors.grey,
                  ),
                  IconButton(
                    icon: const Icon(Icons.comment_outlined, size: 20),
                    onPressed: () {},
                    color: Colors.grey,
                  ),
                  IconButton(
                    icon: const Icon(Icons.share_outlined, size: 20),
                    onPressed: () {},
                    color: Colors.grey,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
