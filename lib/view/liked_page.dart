import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:wallpaper_selector/view/auth_page.dart';

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
      Navigator.push(context, MaterialPageRoute(builder: (context)=>const AuthPage(),));
    }
    return Scaffold(
        // backgroundColor: Colors.deepOrangeAccent[200],
      backgroundColor: const Color(0xFFE3FDFD),
        appBar: AppBar(
          centerTitle: true,
          toolbarHeight: 60.0,
          title: const Text("Liked Wallpaper"),
          actions: <Widget>[
            IconButton(onPressed: signUserOut, icon: const Icon(Icons.logout))
          ],
        ),
        body: Container(
          margin: const EdgeInsets.symmetric(vertical: 12),
          child: listViewLayout(context),
        )
    );
  }

  Widget listViewLayout(BuildContext context) {
    return Obx(() => AlignedGridView.count(
      itemCount: ImageController.savedImagesData.length,
      itemBuilder: (context, item){
          return Container(
            margin: const EdgeInsets.all(4),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: GestureDetector(child: CachedNetworkImage(
                height: 275,
                imageUrl: ImageController.savedImagesData.elementAt(item)['link'],
                placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                key: UniqueKey(),
                fit: BoxFit.cover,
              ), onTap: () => {
                Navigator.push(context, MaterialPageRoute(builder: (context) => ImageView(id: ImageController.savedImagesData.elementAt(item)['id'], link: ImageController.savedImagesData.elementAt(item)['link'],))),
              },),
            ),
          );
      }, crossAxisCount: 2,
      crossAxisSpacing: 8,
      mainAxisSpacing: 8,
    ));
  }
}
