import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ContactsScreen extends StatefulWidget {
  const ContactsScreen({Key? key}) : super(key: key);

  @override
  _ContactsScreenState createState() => _ContactsScreenState();
}

class _ContactsScreenState extends State<ContactsScreen> {
  late User? _currentUser;
  List<String> _contacts = [];

  @override
  void initState() {
    super.initState();
    _fetchCurrentUser();
    _fetchContacts();
  }

  void _fetchCurrentUser() {
    _currentUser = FirebaseAuth.instance.currentUser;
  }

  void _fetchContacts() {
    FirebaseFirestore.instance
        .collection('contacts')
        .doc(_currentUser?.uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        Map<String, dynamic> data =
        documentSnapshot.data() as Map<String, dynamic>; // Explicit cast
        setState(() {
          _contacts = List<String>.from(data['contacts']);
        });
      } else {
        print('Document does not exist on the database');
      }
    });
  }

  void _addUser() {
    // Navigate to a screen where users can be searched and added
    Navigator.push(context, MaterialPageRoute(builder: (context) => AddContactScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contacts'),
      ),
      body: _contacts.isEmpty
          ? Center(
        child: Text('No contacts yet!'),
      )
          : ListView.builder(
        itemCount: _contacts.length,
        itemBuilder: (context, index) {
          return _buildContactTile(_contacts[index]);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addUser,
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildContactTile(String contactId) {
    return ListTile(
      title: FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance.collection('users').doc(contactId).get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }

          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          if (snapshot.hasData && snapshot.data != null) {
            Map<String, dynamic> userData =
            snapshot.data!.data() as Map<String, dynamic>;
            return Text(
                userData['email']); // Display the user's email, you can modify this as per your user data structure
          }

          return Text('User data not available');
        },
      ),
    );
  }
}



class AddContactScreen extends StatefulWidget {
  @override
  _AddContactScreenState createState() => _AddContactScreenState();
}

class _AddContactScreenState extends State<AddContactScreen> {
  late TextEditingController _emailController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _addContact(String userId, String contactEmail) async {
    try {
      // Add the contact to the current user's contacts list
      await FirebaseFirestore.instance
          .collection('contacts')
          .doc(userId)
          .set({
        contactEmail: true,
      }, SetOptions(merge: true));

      // Show a success message or navigate to another screen
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Contact added successfully'),
        ),
      );
    } catch (error) {
      // Handle errors
      print('Error adding contact: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error adding contact. Please try again.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Contact'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Enter contact email',
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                String contactEmail = _emailController.text.trim();
                if (contactEmail.isNotEmpty) {
                  String currentUserId =
                      FirebaseAuth.instance.currentUser!.uid;
                  _addContact(currentUserId, contactEmail);
                }
              },
              child: Text('Add Contact'),
            ),
          ],
        ),
      ),
    );
  }
}
