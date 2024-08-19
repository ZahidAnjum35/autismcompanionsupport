import 'package:flutter/material.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileView();
}

class _ProfileView extends State<ProfileView> {
  late final TextEditingController _name;
  late final TextEditingController _age;
  late final TextEditingController _gender;
  late final TextEditingController _height;
  late final TextEditingController _weight;
  late final TextEditingController _history;
  late final TextEditingController _habits;
  late final TextEditingController _photo;

  @override
  void initState() {
    _name = TextEditingController();
    _age = TextEditingController();
    _gender = TextEditingController();
    _height = TextEditingController();
    _weight = TextEditingController();
    _history = TextEditingController();
    _habits = TextEditingController();
    _photo = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _name.dispose();
    _age.dispose();
    _gender.dispose();
    _height.dispose();
    _weight.dispose();
    _history.dispose();
    _habits.dispose();
    _photo.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Column(
        children: [
          TextField(
            controller: _name,
            decoration: const InputDecoration(
              hintText: 'Enter child name here',
            ),
          ),
          TextField(
            controller: _age,
            autocorrect: false,
            decoration: const InputDecoration(
              hintText: 'Enter child age here',
            ),
          ),
          TextField(
            controller: _gender,
            autocorrect: false,
            decoration: const InputDecoration(
              hintText: 'Enter child gender here',
            ),
          ),
          TextField(
            controller: _height,
            autocorrect: false,
            decoration: const InputDecoration(
              hintText: 'Enter child height here',
            ),
          ),
          TextField(
            controller: _weight,
            autocorrect: false,
            decoration: const InputDecoration(
              hintText: 'Enter child weight here',
            ),
          ),
          TextField(
            controller: _history,
            decoration: const InputDecoration(
              hintText: 'Enter child history here',
            ),
          ),
          TextField(
            controller: _habits,
            decoration: const InputDecoration(
              hintText: 'Enter child habits here',
            ),
          ),
          TextField(
            controller: _photo,
            autocorrect: false,
            decoration: const InputDecoration(
              hintText: 'Attach child profile photo',
            ),
          ),
          TextButton(
            onPressed: () {

            }, child: const Text('Save Profile'),),
        ],
      ),
    );
  }
}