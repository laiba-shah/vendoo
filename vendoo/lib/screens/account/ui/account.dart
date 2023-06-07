import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../api/apis.dart';
import '../../../models/chat_user.dart';
import 'package:vendoo/screens/home/ui/homepage.dart';

class AccountPage extends StatefulWidget {
  late ChatUser user;
  //final FirebaseAuth auth = FirebaseAuth.instance;
  AccountPage({required this.user});

  @override
  AccountPageState createState() => AccountPageState();
}

class AccountPageState extends State<AccountPage> {
  final formkey = GlobalKey<FormState>();
  bool isEditing = false;
  bool showSaveButton = false;
  late TextEditingController nameController;
  late TextEditingController bioController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.user.name);
    bioController = TextEditingController(text: widget.user.about);
  }

  @override
  void dispose() {
    nameController.dispose();
    bioController.dispose();
    super.dispose();
  }

  void toggleEditing() {
    setState(() {
      isEditing = !isEditing;
      showSaveButton = !showSaveButton;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Form(
      key: formkey,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          title: const Text('Manage Account'),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                'assets/images/ventooV.png',
                width: 30,
                height: 30,
              ),
            ),
          ],
        ),
        body: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            const CircleAvatar(
              radius: 80,
              backgroundImage: AssetImage('images/profile_picture.jpg'),// TODO: add proper image path here
              child: Icon(Icons.account_circle, size: 150),
            ),
            const SizedBox(height: 16.0),
            isEditing
                ? TextFormField(
                    onSaved: (value) => APIs.me.name = value ?? '',
                    validator: (value) => value != null && value.isNotEmpty
                        ? null
                        : 'Required Field',
                    controller: nameController,
                    decoration: InputDecoration(
                      labelText: 'Name',
                    ),
                  )
                : ListTile(
                    leading: Icon(Icons.person),
                    title: Text('${widget.user.name}'),
                  ),
            isEditing
                ? TextFormField(
                    onSaved: (value) => APIs.me.about = value ?? '',
                    validator: (value) => value != null && value.isNotEmpty
                        ? null
                        : 'Required Field',
                    controller: bioController,
                    decoration: InputDecoration(
                      labelText: 'About',
                    ),
                  )
                : ListTile(
                    leading: Icon(Icons.info),
                    title: Text('${widget.user.about}'),
                    onTap: toggleEditing,
                  ),
            ListTile(
              leading: Icon(Icons.email),
              title: Text('${widget.user.email}'),
            ),
            ListTile(
              leading: Icon(Icons.edit),
              title: Text('Edit Profile'),
              onTap: toggleEditing,
            ),
            ListTile(
            leading: Icon(Icons.logout),
            title: Text('Sign Out'),
            onTap: () {
              signOut();
              Navigator.push(context,
                MaterialPageRoute(builder: (context) =>  HomePage(key: const ValueKey('myHomePage'))));
            },
            )
          ],
        ),
        bottomNavigationBar: showSaveButton
            ? ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: theme
                      .primaryColor, // Use app's primary color as button background
                ),
                onPressed: () {
                  final snackBar =
                      SnackBar(content: Text('Profile Updated Successfully'));
                  if (formkey.currentState!.validate()) {
                    print('inside validator');
                    formkey.currentState!.save();
                    APIs.updateUserInfo().then((value) {
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    });
                    toggleEditing();
                  }
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 12.0),
                  child: Text(
                    'Save',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              )
            : null,
      ),
    );
  }
}

void signOut() async {
  try {
    await APIs.auth.signOut();
  } catch (e) {
    print('Error signing out: $e');
  }
}
