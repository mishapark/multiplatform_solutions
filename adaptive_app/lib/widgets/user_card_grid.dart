import 'package:flutter/material.dart';

class UserCardGrid extends StatelessWidget {
  final String firstname;
  final String lastname;
  final String email;
  final String pic;
  final VoidCallback onTap;

  const UserCardGrid({
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
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      color: Colors.blue,
      child: GestureDetector(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                minRadius: MediaQuery.of(context).size.width * 0.05,
                backgroundImage: AssetImage(pic),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                '$firstname $lastname',
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                email,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
