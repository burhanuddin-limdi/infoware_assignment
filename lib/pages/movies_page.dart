import 'package:flutter/material.dart';
import 'package:infoware_assignment/api/api.dart';
import 'package:infoware_assignment/widgets/thumbnail.dart';

class MoviesPage extends StatelessWidget {
  const MoviesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      physics: const AlwaysScrollableScrollPhysics(),
      itemCount: categories.length,
      itemBuilder: (BuildContext context, int index) {
        final category = categories[index];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                category['name'].toString(),
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w700),
              ),
            ),
            FutureBuilder(
              future: getData(category),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final data = snapshot.data['results'];
                  return SizedBox(
                    height: 150,
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: data?.length,
                      itemBuilder: (context, index) {
                        return Thumbnail(
                          data: data[index],
                          type: category['type'],
                        );
                      },
                    ),
                  );
                } else {
                  return const CircularProgressIndicator();
                }
              },
            ),
          ],
        );
      },
    );
  }
}
