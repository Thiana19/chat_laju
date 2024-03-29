import 'package:flutter/material.dart';
import 'package:flutter_chat_app/models/profile_model.dart';
import 'package:flutter_chat_app/pages/login.dart';
import 'package:flutter_chat_app/services/profile_service.dart';
import 'package:flutter_chat_app/widgets/theme.dart';

class SettingsPage extends StatefulWidget {
  final String token;

  SettingsPage(this.token);
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool isDarkModeEnabled = false;
  String userName = '';
  String userEmail = '';
  // ThemeData _currentTheme = ThemeData.light();
  MaterialTheme materialTheme = MaterialTheme(ThemeData.light().textTheme);



  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    try {
      final UserService userService = UserService(widget.token);
      final UserModel user = await userService.getUserDetails();

      setState(() {
        userName = user.name;
        userEmail = user.email;
      });
    } catch (error) {
      print('Error loading user data: $error');
    }
  }

  void _toggleDarkMode(bool value) {
  print('Dark mode toggled: $value');
  setState(() {
    isDarkModeEnabled = value;
    materialTheme = isDarkModeEnabled
        ? MaterialTheme(ThemeData.dark().textTheme)
        : MaterialTheme(ThemeData.light().textTheme);
  });
}




  @override
  Widget build(BuildContext context) {
    print('Building UI with isDarkModeEnabled: $isDarkModeEnabled');

    var brightness = MediaQuery.of(context).platformBrightness;
    var theme = brightness == Brightness.dark ? materialTheme.dark() : materialTheme.light();
    return Theme(
      data: theme,
      child: Scaffold(
        body: Container(
          child: ListView(
            children: <Widget>[
              const SizedBox(height: 20),
              _buildSectionTitle('Account Information'),
              Card(
                elevation: 5,
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                child: _buildAccountInfoListView(brightness: brightness),
              ),
              const SizedBox(height: 20),
              _buildSectionTitle('App Settings'),
              Card(
                elevation: 5,
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                child: Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      _buildSettingsItem(
                        title: 'Language',
                        subtitle: 'English',
                        icon: Icons.language,
                      ),
                      _buildDarkModeSwitchItem(
                        title: 'Dark Mode',
                        onChanged: _toggleDarkMode,
                        isDarkModeEnabled: isDarkModeEnabled,
                      ),
                      // Add more settings items here
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: Container(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: ElevatedButton.icon(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginPage(),
                  ),
                );
              },
              icon: const Icon(
                Icons.logout,
              ),
              label: const Text(
                'Logout',
                style: TextStyle(
                ),
              ),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSettingsItem({
    required String title,
    required String subtitle,
    required IconData icon,
  }) {
    return Column(
      children: [
        ListTile(
          leading: Icon(
            icon,
          ),
          title: Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          trailing: Text(
            subtitle,
            style: TextStyle(
              fontSize: 14,
            ),
          ),
        ),
        const Divider(
          height: 1,
        ),
      ],
    );
  }

  Widget _buildDarkModeSwitchItem({
    required String title,
    required Function(bool) onChanged,
    required bool isDarkModeEnabled,
  }) {
    return Column(
      children: [
        ListTile(
          leading: const Icon(
            Icons.brightness_6,
          ),
          title: Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          trailing: Switch(
            value: isDarkModeEnabled,
            onChanged: onChanged, 
          ),
        ),
        const Divider(
          height: 1,
        ),
      ],
    );
  }



  Widget _buildAccountInfoListView({required Brightness brightness}) {
    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: <Widget>[
        _buildAccountInfoItem(
          title: 'Name',
          subtitle: userName,
          icon: Icons.person,
        ),
        _buildAccountInfoItem(
          title: 'Email',
          subtitle: userEmail,
          icon: Icons.email,
        ),
        // Add more account information items here
      ],
    );
  }

  Widget _buildAccountInfoItem({
    required String title,
    required String subtitle,
    required IconData icon,
  }) {
    return Column(
      children: [
        ListTile(
          leading: Icon(
            icon,
          ),
          title: Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          trailing: Text(
            subtitle,
            style: TextStyle(
              fontSize: 14,
            ),
          ),
          onTap: () {
            print('Tap Account Info Item $title');
          },
        ),
        const Divider(
          height: 1,
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
