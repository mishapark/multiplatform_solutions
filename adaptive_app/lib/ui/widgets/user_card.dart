import 'package:flutter/material.dart';

class UserCard extends StatelessWidget {
  final String firstname;
  final String lastname;
  final String email;
  final String pic;
  final VoidCallback onTap;

  const UserCard({
    super.key,
    required this.firstname,
    required this.lastname,
    required this.email,
    required this.pic,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.blue,
      child: GestureDetector(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                minRadius: 30,
                backgroundImage: AssetImage(pic),
              ),
              const SizedBox(
                width: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '$firstname $lastname',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(email),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
