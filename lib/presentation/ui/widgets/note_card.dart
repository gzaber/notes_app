import 'package:flutter/material.dart';
import 'package:notes_app/domain/entities/note.dart';

class NoteCard extends StatelessWidget {
  final Note note;
  final Color color;
  final Function() onTap;
  const NoteCard({
    required this.note,
    required this.color,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            borderRadius: const BorderRadius.all(Radius.circular(5.0)),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    note.title,
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(color: Colors.black, fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(height: 10.0),
                  Text(
                    note.date,
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.black54),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
