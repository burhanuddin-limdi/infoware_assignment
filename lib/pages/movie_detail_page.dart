import 'package:flutter/material.dart';
import 'package:infoware_assignment/api/api.dart';
import 'package:infoware_assignment/environment/environment.dart';
import 'package:infoware_assignment/widgets/thumbnail.dart';

class MovieDetailPage extends StatelessWidget {
  final dynamic data;
  final String? type;
  const MovieDetailPage({super.key, required this.data, required this.type});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff111827),
      appBar: AppBar(
        backgroundColor: const Color(0xff111827),
        iconTheme: const IconThemeData(color: Colors.white),
        title: Row(
          children: [
            if (type == 'movie')
              Text(
                data['original_title'].toString(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              )
            else
              Text(
                data['name'].toString(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image(
              image: NetworkImage(
                '${environment['posterUrl']}${data['backdrop_path']}',
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
              child: Text(
                data['overview'],
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                'Similar Stuff',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            FutureBuilder(
              future: getSimilar(data, type),
              builder: ((context, snapshot) {
                if (snapshot.hasData) {
                  final data = snapshot.data['results'];
                  return GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                    ),
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(
                      decelerationRate: ScrollDecelerationRate.normal,
                    ),
                    itemCount: data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return SizedBox(
                        height: 150,
                        child: Thumbnail(
                          data: data[index],
                          type: type,
                        ),
                      );
                    },
                  );
                } else {
                  return const CircularProgressIndicator();
                }
              }),
            ),
          ],
        ),
      ),
    );
  }
}
