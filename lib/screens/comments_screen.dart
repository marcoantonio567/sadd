import 'package:flutter/material.dart';
import '../models/comment.dart';
import '../services/api_service.dart';

class CommentsScreen extends StatefulWidget {
  const CommentsScreen({super.key});

  @override
  State<CommentsScreen> createState() => _CommentsScreenState();
}

class _CommentsScreenState extends State<CommentsScreen> {
  late Future<List<Comment>> futureComments;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    futureComments = ApiService.fetchComments();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Comment>>(
        future: futureComments,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return _buildErrorWidget(snapshot.error.toString());
          }

          if (!snapshot.hasData) {
            return _buildLoadingWidget();
          }

          final comments = snapshot.data!;

          return CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: 180,
                flexibleSpace: FlexibleSpaceBar(
                  title: const Text(
                    'Comentários',
                    style: TextStyle(color: Colors.white),
                  ),
                  background: Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.purple, Colors.deepPurple],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: const Center(
                      child: Icon(Icons.comment, size: 60, color: Colors.white),
                    ),
                  ),
                ),
                pinned: true,
              ),
              SliverPadding(
                padding: const EdgeInsets.all(16),
                sliver: SliverToBoxAdapter(
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Pesquisar comentários...',
                      prefixIcon: const Icon(Icons.search),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                          setState(() {});
                        },
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      filled: true,
                      fillColor: Colors.grey.shade100,
                    ),
                    onChanged: (value) => setState(() {}),
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  final comment = comments[index];
                  if (_searchController.text.isNotEmpty &&
                      !comment.name.toLowerCase().contains(
                        _searchController.text.toLowerCase(),
                      ) &&
                      !comment.body.toLowerCase().contains(
                        _searchController.text.toLowerCase(),
                      )) {
                    return const SizedBox.shrink();
                  }
                  return _buildCommentCard(comment);
                }, childCount: comments.length),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildCommentCard(Comment comment) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.purple.shade100,
                  child: Text(
                    comment.name[0],
                    style: const TextStyle(color: Colors.purple),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        comment.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        comment.email,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              comment.body,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade800,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Chip(
                  label: Text('Post #${comment.postId}'),
                  backgroundColor: Colors.purple.shade50,
                  labelStyle: const TextStyle(color: Colors.purple),
                ),
                const Spacer(),
                Text(
                  'ID: ${comment.id}',
                  style: TextStyle(fontSize: 12, color: Colors.grey.shade500),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorWidget(String error) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, size: 60, color: Colors.red),
          const SizedBox(height: 20),
          Text(
            'Erro ao carregar comentários\n$error',
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 18),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed:
                () => setState(() {
                  futureComments = ApiService.fetchComments();
                }),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.purple,
              foregroundColor: Colors.white,
            ),
            child: const Text('Tentar novamente'),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingWidget() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(),
          SizedBox(height: 20),
          Text('Carregando comentários...'),
        ],
      ),
    );
  }
}
