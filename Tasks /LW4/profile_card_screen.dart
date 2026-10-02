import 'package:flutter/material.dart';

class ProfileCardScreen extends StatefulWidget {
  const ProfileCardScreen({super.key});

  @override
  State<ProfileCardScreen> createState() => _ProfileCardScreenState();
}

class _ProfileCardScreenState extends State<ProfileCardScreen> {
  bool _isFollowing = false;
  bool _isLiked = false;
  int _followerCount = 1320;
  int _likesCount = 120;

  void _toggleFollow() {
    setState(() {
      if (_isFollowing) {
        _isFollowing = false;
        _followerCount--;
      } else {
        _isFollowing = true;
        _followerCount++;
      }
    });
  }

  void _toggleLike() {
    setState(() {
      if (_isLiked) {
        _isLiked = false;
        _likesCount--;
      } else {
        _isLiked = true;
        _likesCount++;
      }
    });
  }

  void _reset() {
    setState(() {
      _isFollowing = false;
      _isLiked = false;
      _followerCount = 1320;
      _likesCount = 120;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile Card'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Center(
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.indigo,
                  child: Icon(Icons.person, size: 50, color: Colors.white),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Nurdaulet Orazgeldy',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                const Text('Senior Lecturer'),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        Text('$_followerCount'),
                        const Text('Followers'),
                      ],
                    ),
                    Column(
                      children: [
                        Text('$_likesCount'),
                        const Text('Likes'),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: _toggleFollow,
                      child: Text(_isFollowing ? 'Following' : 'Follow'),
                    ),
                    const SizedBox(width: 12),
                    OutlinedButton(
                      onPressed: _toggleLike,
                      child: Text(_isLiked ? 'Liked' : 'Like'),
                    ),
                  ],
                ),
                TextButton(
                  onPressed: _reset,
                  child: const Text('Reset'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}