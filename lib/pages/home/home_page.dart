import 'package:chat_notify/pages/chat/chat_page.dart';
import 'package:flutter/material.dart';
import 'package:chat_notify/services/auth/auth_service.dart';
import 'package:chat_notify/services/chat/chat_service.dart';
import 'package:chat_notify/widgets/home_widgets/my_drawer.dart';
import 'package:chat_notify/widgets/home_widgets/user_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ChatService chatService = ChatService();
  final AuthService authService = AuthService();
  late String currentUserEmail = ""; // Initialize with an empty string

  @override
  void initState() {
    super.initState();
    getCurrentUserEmail(); // Get current user's email on widget initialization
  }

  Future<void> getCurrentUserEmail() async {
    currentUserEmail =
        (await authService.getCurrentUserEmail()) ?? ""; // Handle null case
    setState(() {}); // Refresh UI with current user's email
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text("Home", style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      drawer: const MyDrawer(),
      body: buildUsersList(),
    );
  }

  Widget buildUsersList() {
    return StreamBuilder<List<Map<String, dynamic>>>(
      stream: chatService.getUsersStream(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return const Center(child: Text("Error fetching users"));
        }
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text("No users found"));
        }

        // Filter out current user from the list
        List<Map<String, dynamic>> usersList = snapshot.data!
            .where((user) => user["email"] != currentUserEmail)
            .toList();

        return ListView.builder(
          itemCount: usersList.length,
          itemBuilder: (context, index) {
            final userData = usersList[index];
            return UserTile(
              text: userData["email"],
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChatPage(
                      recieverEmail: userData["email"],
                    ),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
