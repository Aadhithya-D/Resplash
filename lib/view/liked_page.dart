import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/image_controller.dart';
import 'image_view.dart';

class LikedPage extends StatelessWidget {
  LikedPage({Key? key}) : super(key: key);
  final ImageController imageController = Get.put(ImageController());

  @override
  Widget build(BuildContext context) {
    void signUserOut(){
      FirebaseAuth.instance.signOut();
      ImageController().clear();
      Navigator.pop(context);
    }
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          toolbarHeight: 60.0,
          title: const Text("Liked Wallpaper"),
          actions: <Widget>[
            IconButton(onPressed: signUserOut, icon: Icon(Icons.logout))
          ],
        ),
        body: Container(
          margin: const EdgeInsets.all(2),
          child: listViewLayout(context),
        )
    );
  }

  Widget listViewLayout(BuildContext context) {
    return Obx(() => ListView.builder(
      itemCount: ImageController.savedImagesData.length,
      itemBuilder: (context, item){
          return Container(
            margin: const EdgeInsets.all(4),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: GestureDetector(child: CachedNetworkImage(
                imageUrl: ImageController.savedImagesData.elementAt(item)['link'],
                placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                key: UniqueKey(),
                fit: BoxFit.cover,
              ), onTap: () => {
                Navigator.push(context, MaterialPageRoute(builder: (context) => ImageView(id: ImageController.savedImagesData.elementAt(item)['id'], link: ImageController.savedImagesData.elementAt(item)['link'],))),
              },),
            ),
          );
      },
    ));
  }
}
