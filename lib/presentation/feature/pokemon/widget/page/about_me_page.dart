//ruta /home
import 'package:flutter/material.dart';

class AboutMePage extends StatelessWidget {
  const AboutMePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        child: Container(
          alignment: Alignment.center,
          color: Colors.lightBlue[50],
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'About me',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 16.0),
                CircleAvatar(
                  radius: 100.0,
                  backgroundImage: NetworkImage(
                      'https://media.licdn.com/dms/image/D4D03AQH01tCVa3MkTw/profile-displayphoto-shrink_800_800/0/1698511621643?e=1706745600&v=beta&t=0tpJna_ISkKqLo2PiN-rtOOdEWcnPkVuwzpJMsxeDuc'),
                ),
                SizedBox(height: 16.0),
                Text(
                  'David Pérez Contreras',
                  style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF01579B)),
                ),
                SizedBox(height: 8.0),
                Text(
                  'I’m a Junior Full-Stack Developer with a passion for music and technology. This is not my first Flutter app, still I’m excited to continue exploring and innovating in a technology with that many oportunities.',
                  style: TextStyle(fontSize: 16.0, color: Colors.grey),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
