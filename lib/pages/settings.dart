import 'package:flutter/material.dart';
import 'package:flutter_chat_app/models/item_card.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool isDarkModeEnabled = false;
  String userName = 'Asif Ali'; // Replace with actual user name
  String userEmail = 'asifmailed@gmail.com'; // Replace with actual user email

  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Settings',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: ListView(
        children: <Widget>[
          _buildSectionTitle('Account Information'),
          _buildAccountInfoListView(brightness: brightness),
          SizedBox(height: 20), // Added some space between sections
          _buildSectionTitle('App Settings'),
          Padding(
            padding: const EdgeInsets.only(top: 16), // Customize top padding
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _buildSettingsItem(
                  title: 'Language',
                  subtitle: 'English',
                  icon: Icons.language,
                  callback: () {
                    print('Tap Settings Item 01');
                  },
                  brightness: brightness,
                ),
                _buildDarkModeSwitchItem(
                  title: 'Dark Mode',
                  callback: () {
                    setState(() {
                      isDarkModeEnabled = !isDarkModeEnabled;
                    });
                  },
                  isDarkModeEnabled: isDarkModeEnabled,
                  brightness: brightness,
                ),
                // Add more settings items here
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsItem({
    required String title,
    required String subtitle,
    required IconData icon,
    required Function() callback,
    required Brightness brightness,
  }) {
    return Column(
      children: [
        ListTile(
          leading: Icon(
            icon,
            color: brightness == Brightness.light
                ? Colors.black
                : Colors.white,
          ),
          title: Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          trailing: Text(
            subtitle,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600], // Customize the color here
            ),
          ),
          onTap: callback,
        ),
        Divider(
          color: brightness == Brightness.light
              ? Colors.grey[300]
              : Colors.grey[700],
          height: 1,
        ),
      ],
    );
  }

  Widget _buildDarkModeSwitchItem({
    required String title,
    required Function() callback,
    required bool isDarkModeEnabled,
    required Brightness brightness,
  }) {
    return Column(
      children: [
        ListTile(
          leading: Icon(
            Icons.brightness_6,
            color: brightness == Brightness.light
                ? Colors.black
                : Colors.white,
          ),
          title: Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          trailing: Switch(
            value: isDarkModeEnabled,
            onChanged: (value) {
              setState(() {
                isDarkModeEnabled = value;
              });
              callback();
            },
          ),
        ),
        Divider(
          color: brightness == Brightness.light
              ? Colors.grey[300]
              : Colors.grey[700],
          height: 1,
        ),
      ],
    );
  }

  Widget _buildAccountInfoListView({required Brightness brightness}) {
    return ListView(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      children: <Widget>[
        _buildAccountInfoItem(
          title: 'Name',
          subtitle: userName,
          icon: Icons.person,
          brightness: brightness,
        ),
        _buildAccountInfoItem(
          title: 'Email',
          subtitle: userEmail,
          icon: Icons.email,
          brightness: brightness,
        ),
        // Add more account information items here
      ],
    );
  }

  Widget _buildAccountInfoItem({
    required String title,
    required String subtitle,
    required IconData icon,
    required Brightness brightness,
  }) {
    return Column(
      children: [
        ListTile(
          leading: Icon(
            icon,
            color: brightness == Brightness.light
                ? Colors.black
                : Colors.white,
          ),
          title: Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          trailing: Text(
            subtitle,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600], // Customize the color here
            ),
          ),
          onTap: () {
            // Handle account information item tap
            print('Tap Account Info Item $title');
          },
        ),
        Divider(
          color: brightness == Brightness.light
              ? Colors.grey[300]
              : Colors.grey[700],
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
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}