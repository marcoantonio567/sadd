import 'package:flutter/material.dart';
import 'posts_screen.dart';
import 'comments_screen.dart';
import 'albums_screen.dart';
import 'photos_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const HomeContent(),
    const PostsScreen(),
    const CommentsScreen(),
    const AlbumsScreen(),
    const PhotosScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('API Consumer App'),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue, Colors.indigo],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.article), label: 'Posts'),
          BottomNavigationBarItem(
            icon: Icon(Icons.comment),
            label: 'Comentários',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.photo_album),
            label: 'Álbuns',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.photo), label: 'Fotos'),
        ],
      ),
    );
  }
}

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Bem-vindo ao API Consumer App',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          const Text(
            'Este aplicativo consome dados da API pública JSONPlaceholder.',
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 30),
          Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  const Text(
                    'Recursos disponíveis:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 15),
                  _buildFeatureCard(
                    context,
                    Icons.article,
                    'Posts',
                    '100 posts de exemplo',
                    () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const PostsScreen(),
                      ),
                    ),
                  ),
                  _buildFeatureCard(
                    context,
                    Icons.comment,
                    'Comentários',
                    '500 comentários de exemplo',
                    () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CommentsScreen(),
                      ),
                    ),
                  ),
                  _buildFeatureCard(
                    context,
                    Icons.photo_album,
                    'Álbuns',
                    '100 álbuns de exemplo',
                    () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AlbumsScreen(),
                      ),
                    ),
                  ),
                  _buildFeatureCard(
                    context,
                    Icons.photo,
                    'Fotos',
                    '5000 fotos de exemplo',
                    () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const PhotosScreen(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 30),
          const Card(
            elevation: 4,
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Sobre a API:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'JSONPlaceholder é uma API REST online gratuita que você pode usar sempre que precisar de alguns dados falsos.',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Não requer autenticação ou chave API.',
                    style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureCard(
    BuildContext context,
    IconData icon,
    String title,
    String subtitle,
    VoidCallback onTap,
  ) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      elevation: 2,
      child: ListTile(
        leading: Icon(icon, color: Colors.blue),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }
}
