//ruta /home
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class AboutMePage extends StatelessWidget {
  const AboutMePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: double.infinity,
        child: Container(
          alignment: Alignment.center,
          color: Colors.lightBlue[50],
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  'About me',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16.0),
                SizedBox(
                  height: 200,
                  width: 200,
                  child: CachedNetworkImage(
                    imageUrl:
                        'https://media.licdn.com/dms/image/D4D03AQH01tCVa3MkTw/profile-displayphoto-shrink_800_800/0/1698511621643?e=1706745600&v=beta&t=0tpJna_ISkKqLo2PiN-rtOOdEWcnPkVuwzpJMsxeDuc',
                    imageBuilder: (context, imageProvider) => CircleAvatar(
                      radius: 100.0,
                      backgroundImage: imageProvider,
                    ),
                    placeholder: (context, url) =>
                        const CircularProgressIndicator(),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                ),
                const SizedBox(height: 16.0),
                const Text(
                  'David Pérez Contreras',
                  style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF01579B)),
                ),
                const SizedBox(height: 8.0),
                const Text(
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
