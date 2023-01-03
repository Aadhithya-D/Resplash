import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:wallpaper_selector/controller/image_controller.dart';
import 'package:wallpaper_selector/view/image_view.dart';
import 'package:wallpaper_selector/view/liked_page.dart';


class HomePage extends StatelessWidget{
  final ImageController imageController = Get.put(ImageController());
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          toolbarHeight: 60.0,
          title: const Text("Wallpaper Selector"),
          actions: <Widget>[
            IconButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => LikedPage()));
            }, icon: Icon(Icons.list))
          ],
        ),
        // backgroundColor: Colors.deepOrangeAccent[100],
        body: Container(
          margin: EdgeInsets.all(12),
          child: alignedLayout(context),
        ));
  }

  Widget alignedLayout(BuildContext context) {

    return Obx(() => AlignedGridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        itemCount: imageController.imageList.length,
        itemBuilder: (context, index){
          // if(index>=imageController.imageList.length){
          //   imageController.fetchImages(((index+10)/10).round());
          //   print("yes");
          // }
          return ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: GestureDetector(child: CachedNetworkImage(
              imageUrl: imageController.imageList[index].urls.small,
              placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
              key: UniqueKey(),
              fit: BoxFit.cover,
            ), onTap: () => {
              Navigator.push(context, MaterialPageRoute(builder: (context) => ImageView(id: imageController.imageList[index].id, link: imageController.imageList[index].urls.regular,))),
            },),
          );
        },
    ),
      );
  }
  
  

}