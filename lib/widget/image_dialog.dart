import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ImageDialog extends StatelessWidget {
  const ImageDialog({Key? key, this.image}) : super(key: key);
  final String? image;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Dialog(
        child: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: Container(
                decoration: BoxDecoration(
                    image: DecorationImage(image: NetworkImage(image!))),
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                  onPressed: () => Get.back(),
                  icon: const Icon(
                    Icons.cancel_outlined,
                    color: Colors.red,
                  )),
            )
          ],
        ),
      ),
    );
  }
}
