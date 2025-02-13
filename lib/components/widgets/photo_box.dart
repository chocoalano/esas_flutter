import 'package:flutter/material.dart';

class PhotoBox extends StatelessWidget {
  final String photoUrl;

  const PhotoBox({super.key, required this.photoUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      height: 120,
      decoration: BoxDecoration(
        color: Colors.grey.shade200, // Background color for image box
        borderRadius: BorderRadius.circular(8),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: photoUrl.isNotEmpty
            ? Image.network(
                photoUrl, // Full image URL
                fit: BoxFit
                    .cover, // Ensures the image fits properly within the box
                errorBuilder: (context, error, stackTrace) {
                  return _placeholderImage(); // Placeholder when image fails to load
                },
              )
            : _placeholderImage(), // Placeholder when URL is empty
      ),
    );
  }

  // Placeholder widget if image URL is empty or invalid
  Widget _placeholderImage() {
    return Container(
      color: Colors.grey.shade300, // Background color for the placeholder
      child: const Icon(
        Icons.image, // Icon to indicate missing image
        size: 50,
        color: Colors.grey,
      ),
    );
  }
}
