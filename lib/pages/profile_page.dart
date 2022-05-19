import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthy/pages/confirm_password_page.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Profile')),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                SizedBox(height: 14),
                Center(
                  child: Stack(
                    children: [
                      Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          shape: BoxShape.circle,
                        ),
                      ),
                      Positioned(
                        child: IconButton(
                          icon: Card(
                            child: Padding(
                              child: Icon(Icons.edit),
                              padding: EdgeInsets.all(3),
                            ),
                            shape: CircleBorder(),
                          ),
                          onPressed: () {},
                        ),
                        bottom: -10,
                        right: -10,
                      ),
                    ],
                    clipBehavior: Clip.none,
                  ),
                ),
                SizedBox(height: 50),
                TextField(
                  controller: TextEditingController(text: 'Name'),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text('Name'),
                  ),
                ),
                SizedBox(height: 16),
                TextField(
                  controller: TextEditingController(text: 'Date Of Birth'),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text('Date Of Birth'),
                  ),
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  child: Text('Change Password'),
                  onPressed: () => Get.to(() => ConfirmPasswordPage()),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                      Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                ),
              ],
              padding: EdgeInsets.all(16),
            ),
          ),
          Padding(
            child: ElevatedButton(
              child: Text('Save Changes'),
              onPressed: () {},
            ),
            padding: EdgeInsets.all(16),
          ),
        ],
        crossAxisAlignment: CrossAxisAlignment.stretch,
      ),
    );
  }
}
