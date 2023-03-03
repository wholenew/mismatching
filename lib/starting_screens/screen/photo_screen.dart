import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:tinder_clone/starting_screens/controller/user_controller.dart';
import 'package:tinder_clone/widget/customButton.dart';
import 'package:image_picker/image_picker.dart';

class Photo extends ConsumerWidget {
  Photo(
      {super.key, required this.tabController, bool this.fromAccount = false});
  final TabController tabController;
  final bool fromAccount;

  File? image;
  final picker = ImagePicker();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userModel = ref.watch(userProvider);

    return Container(
        alignment: Alignment.center,
        color: Colors.red,
        child: ConstrainedBox(
          constraints:
              BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.8),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            const Expanded(child: SizedBox()),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(
                  Icons.favorite,
                  color: Colors.white,
                  size: 30,
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 5),
                  child: Text("mismatching",
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                      )),
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Text("写真を2枚以上追加してください",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                )),
            const SizedBox(
              height: 30,
            ),
            Container(
              child: GridView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.all(10),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 5,
                    childAspectRatio: 0.7),
                itemCount: 6,
                itemBuilder: (BuildContext context, int index) {
                  return ((userModel.photoUrlList?.length ?? 0) > index)
                      ? GestureDetector(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                      content: Text('写真を削除しますか？'),
                                      actions: [
                                        GestureDetector(
                                            child: Center(
                                              child: Text(
                                                'はい',
                                                style: TextStyle(
                                                  color: Colors.blue,
                                                ),
                                              ),
                                            ),
                                            onTap: () {
                                              ref
                                                  .read(userControllerProvider
                                                      .notifier)
                                                  .deleteUserPhoto(
                                                      index,
                                                      userModel.photoNameList![
                                                          index]);
                                              Navigator.of(context).pop();
                                            })
                                      ],
                                    ));
                          },
                          child: Container(
                            child: ClipRRect(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                              child: Image.network(
                                userModel.photoUrlList![index],
                                fit: BoxFit.fill,
                                errorBuilder: (context, error, stackTrace) =>
                                    Text('data'),
                              ),
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(color: Colors.white),
                            ),
                          ),
                        )
                      : GestureDetector(
                          onTap: () {
                            getImageFromGallery(ref, context);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(color: Colors.white),
                            ),
                            child: Icon(
                              Icons.photo_camera,
                              color: Colors.white,
                            ),
                          ),
                        );
                },
              ),
            ),
            const Expanded(child: SizedBox()),
            CustomButton(
              text: '次へ',
              onTap: () {
                final photoUrlListCount =
                    ref.read(userProvider).photoUrlList?.length ?? 0;
                if (photoUrlListCount > 1) {
                  tabController.animateTo(tabController.index + 1);
                }
              },
            ),
          ]),
        ));
  }

  Future getImageFromGallery(WidgetRef ref, BuildContext context) async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile == null) {
      return;
    }
    File? image = File(pickedFile.path);
    final croppedImage = await cropImage(image: image);
    if (croppedImage == null) return;

    XFile file = XFile(croppedImage.path);

    ref.read(userControllerProvider.notifier).uploadUserPhoto(context, file);
  }

  Future<File?> cropImage({required File image}) async {
    CroppedFile? croppedImage =
        await ImageCropper().cropImage(sourcePath: image.path);
    if (croppedImage == null) return null;
    return File(croppedImage.path);
  }
}
