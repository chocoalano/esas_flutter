import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../absensi/controllers/photo_controller.dart';

class PhotoScreen extends StatelessWidget {
  const PhotoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Menggunakan Get.find untuk mendapatkan instance controller yang sudah ada
    final PhotoController controller = Get.find<PhotoController>();

    return Scaffold(
      backgroundColor: Colors.black,
      body: Obx(() {
        if (!controller.isCameraInitialized.value) {
          return const Center(child: CircularProgressIndicator());
        } else if (controller.cameraController == null) {
          return const Center(child: Text('Camera not available'));
        } else {
          return Transform.scale(
            scaleX: -1,
            child: Stack(
              children: [
                Center(
                  child: AspectRatio(
                    aspectRatio:
                        controller.cameraController!.value.aspectRatio /
                            3, // Maintain camera's aspect ratio
                    child: CameraPreview(controller.cameraController!),
                  ),
                ),
                Positioned(
                  bottom: 30,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Obx(() => controller.isLoadingApi.isTrue
                        ? const CircularProgressIndicator(
                            color: Colors.white,
                          )
                        : GestureDetector(
                            onTap: () async {
                              await controller.capturePhoto();
                            },
                            child: Container(
                              width: 70,
                              height: 70,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white.withOpacity(0.8),
                              ),
                              child: const Icon(
                                Icons.camera_alt,
                                color: Colors.black,
                                size: 30,
                              ),
                            ),
                          )),
                  ),
                ),
              ],
            ),
          );
        }
      }),
    );
  }
}
