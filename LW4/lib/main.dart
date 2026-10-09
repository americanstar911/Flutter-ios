import 'package:flutter/material.dart';

void main() {
  runApp(const BusinessApp());
}

class BusinessApp extends StatelessWidget {
  const BusinessApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ProfileCardScreen(),
    );
  }
}

class ProfileCardScreen extends StatefulWidget {
  const ProfileCardScreen({super.key});

  @override
  State<ProfileCardScreen> createState() => _ProfileCardScreenState();
}

class _ProfileCardScreenState extends State<ProfileCardScreen> {
  final int _defaultFollowers = 1320;
  final int _defaultLikes = 120;

  bool _isFollowing = false;
  late int _followerCount;
  late int _likesCount;

  @override
  void initState() {
    super.initState();
    _followerCount = _defaultFollowers;
    _likesCount = _defaultLikes;
  }

  void _toggleFollow() {
    setState(() {
      _isFollowing = !_isFollowing;
      _isFollowing ? _followerCount++ : _followerCount--;
    });
  }

  // +1
  void _incrementLike() {
    setState(() {
      _likesCount++;
    });
  }

  // -1
  void _decrementLike() {
    setState(() {
      _likesCount--;
    });
  }

  void _resetState() {
    setState(() {
      _isFollowing = false;
      _followerCount = _defaultFollowers;
      _likesCount = _defaultLikes;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Developer Profile'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Center(
        child: Card(
          elevation: 6,
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.lime,
                  child: Icon(Icons.person, size: 50, color: Colors.white),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Nurdaulet Amanzholov',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const Text('IT Student'),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        Text(
                          '$_followerCount',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Text(
                          'Followers',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          '$_likesCount',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Text(
                          'Likes',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // follow
                    ElevatedButton.icon(
                      onPressed: _toggleFollow,
                      icon: Icon(_isFollowing ? Icons.check : Icons.person_add),
                      label: Text(_isFollowing ? 'Following' : 'Follow'),
                    ),

                    // reset
                    TextButton.icon(
                      onPressed: _resetState,
                      icon: const Icon(Icons.refresh, color: Colors.grey),
                      label: const Text(
                        'Reset',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),

                    // like/dislike
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        OutlinedButton.icon(
                          onPressed: _incrementLike,
                          icon: const Icon(Icons.thumb_up, color: Colors.green),
                          label: const Text('Like'),
                        ),
                        const SizedBox(height: 8),
                        OutlinedButton.icon(
                          onPressed: _decrementLike,
                          icon: const Icon(Icons.thumb_down, color: Colors.red),
                          label: const Text('Dislike'),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
