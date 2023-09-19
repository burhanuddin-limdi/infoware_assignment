import 'package:flutter/material.dart';
import 'package:infoware_assignment/environment/environment.dart';
import 'package:infoware_assignment/pages/movie_detail_page.dart';

class Thumbnail extends StatelessWidget {
  final String? type;
  final dynamic data;
  const Thumbnail({super.key, required this.data, required this.type});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => MovieDetailPage(
            data: data,
            type: type,
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(right: 5, bottom: 10),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.network(
            '${environment['posterUrl']}${data['poster_path'].toString()}',
          ),
        ),
      ),
    );
  }
}
