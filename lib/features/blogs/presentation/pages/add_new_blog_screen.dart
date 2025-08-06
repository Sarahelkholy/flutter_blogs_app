import 'dart:io';

import 'package:blog_app/core/theme/app_pallete.dart';
import 'package:blog_app/core/utils/pick_image.dart';
import 'package:blog_app/features/blogs/presentation/widgets/blog_editor.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class AddNewBlogScreen extends StatefulWidget {
  static route() =>
      MaterialPageRoute(builder: (context) => const AddNewBlogScreen());
  const AddNewBlogScreen({super.key});

  @override
  State<AddNewBlogScreen> createState() => _AddNewBlogScreenState();
}

class _AddNewBlogScreenState extends State<AddNewBlogScreen> {
  final titleController = TextEditingController();
  final contentController = TextEditingController();
  List<String> selectedTopics = [];
  File? image;

  void selectImage() async {
    final pickedImage = await pickImage();
    if (pickedImage != null) {
      setState(() {
        image = pickedImage;
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    titleController.dispose();
    contentController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.done_rounded,
                size: 26,
              ))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              image != null
                  ? GestureDetector(
                      onTap: selectImage,
                      child: SizedBox(
                        height: 170,
                        width: double.infinity,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.file(
                            image!,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    )
                  : GestureDetector(
                      onTap: () {
                        selectImage();
                      },
                      child: DottedBorder(
                        color: AppPallete.borderColor,
                        borderType: BorderType.RRect,
                        dashPattern: const [10, 4],
                        radius: const Radius.circular(10),
                        strokeCap: StrokeCap.round,
                        child: Container(
                          height: 170,
                          width: double.infinity,
                          child: const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.folder_open,
                                size: 40,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                'Select your image',
                                style: TextStyle(fontSize: 15),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
              const SizedBox(
                height: 15,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children:
                      ['Technology', 'Business', 'Programming', 'Entertainment']
                          .map(
                            (e) => Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: GestureDetector(
                                onTap: () {
                                  if (selectedTopics.contains(e)) {
                                    selectedTopics.remove(e);
                                  } else {
                                    selectedTopics.add(e);
                                  }
                                  setState(() {});
                                },
                                child: Chip(
                                  padding: const EdgeInsets.all(10),
                                  label: Text(
                                    e,
                                    style: const TextStyle(
                                        color: AppPallete.whiteColor),
                                  ),
                                  color: selectedTopics.contains(e)
                                      ? const WidgetStatePropertyAll(
                                          AppPallete.gradient1)
                                      : null,
                                  side: selectedTopics.contains(e)
                                      ? null
                                      : const BorderSide(
                                          color: AppPallete.borderColor),
                                ),
                              ),
                            ),
                          )
                          .toList(),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              BlogEditor(controller: titleController, hintText: 'Blog title'),
              const SizedBox(
                height: 15,
              ),
              BlogEditor(
                  controller: contentController, hintText: 'Blog content'),
            ],
          ),
        ),
      ),
    );
  }
}
