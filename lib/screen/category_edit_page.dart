import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:market/http/custom_http_request.dart';
import 'package:market/model/category_model.dart';
import 'package:market/widget/text_field.dart';
import 'package:market/widget/widget.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class CategoryEditpage extends StatefulWidget {
  CategoryModel? categoryModel;
  CategoryEditpage({Key? key, this.categoryModel}) : super(key: key);

  @override
  _CategoryEditpageState createState() => _CategoryEditpageState();
}

class _CategoryEditpageState extends State<CategoryEditpage> {
  TextEditingController? titleController;
  bool isLoading = false;
  String? title;
  @override
  void initState() {
    // TODO: implement initState
    titleController = TextEditingController(text: widget.categoryModel!.name);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: ModalProgressHUD(
          inAsyncCall: isLoading == true,
          progressIndicator: spinkit,
          child: Container(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomeTextField(
                  controller: titleController,
                  icon: Icons.title,
                  // initialText: widget.categoryModel!.name,
                  hintText: "Title",
                ),
                Text("Add image :"),
                InkWell(
                  onTap: () {
                    selectImage(context, "image");
                  },
                  child: Container(
                    height: 200,
                    width: 500,
                    child: _image != null
                        ? Image.file(_image!)
                        : Image.network(
                            "https://homechef.antapp.space/category/${widget.categoryModel!.image}",
                            fit: BoxFit.cover,
                          ),
                  ),
                ),
                Text("Add icon :"),
                InkWell(
                  onTap: () {
                    selectImage(context, "icon");
                  },
                  child: Container(
                    height: 200,
                    width: 500,
                    child: _icon != null
                        ? Image.file(_icon!)
                        : Image.network(
                            "https://homechef.antapp.space/category/${widget.categoryModel!.icon}",
                            fit: BoxFit.cover,
                          ),
                  ),
                ),
                Center(
                  child: MaterialButton(
                    onPressed: () {
                      /* if (_image != null && _icon != null) {
                        uploadCategory();
                      } else {
                        showToast("Image and Icon required");
                      }*/

                      updateCategory(widget.categoryModel!.id);
                    },
                    height: 50,
                    minWidth: 100,
                    child: Text("Upload Category"),
                    color: Colors.blue,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future updateCategory(var id) async {
    try {
      setState(() {
        isLoading = true;
      });
      print("start");
      var uri = Uri.parse(
          "https://apihomechef.antapp.space/api/admin/category/$id/update");
      var request = http.MultipartRequest("POST", uri);
      request.headers.addAll(await CustomHttpRequest.getHeaderWithToken());
      print("start");
      request.fields["name"] = titleController!.text.toString();
      if (_image != null) {
        var image = await http.MultipartFile.fromPath("image", _image!.path);
        request.files.add(image);
      }
      if (_icon != null) {
        var icon = await http.MultipartFile.fromPath("icon", _icon!.path);
        request.files.add(icon);
      }
      var responce = await request.send();
      print("responceeeeeeeeeeeeeeeeeeee");
      print("Status code is ${responce.statusCode}");

      if (responce.statusCode == 200) {
        print("Successfully doneeeeeeeeeeeeeeee");

        print("Successfully ");

        showToast("Successfully done");
        Navigator.of(context).pop();
      } else {
        print("Failed to upload");
        showToast("Failed to upload");
      }
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print("something wronggggggggggggggg");
    }
  }

  selectImage(ctx, String source) {
    return showDialog(
        context: ctx,
        builder: (context) {
          return SimpleDialog(
            title: Text("Upload Image"),
            children: [
              SimpleDialogOption(
                onPressed: () {
                  source == "image"
                      ? chooseImageFromCamera()
                      : chooseIconFromCamera();
                },
                child: Text("Choose from Camera"),
              ),
              SimpleDialogOption(
                onPressed: () {
                  source == "image"
                      ? chooseImageFromGallery()
                      : chooseIconFromGallery();
                },
                child: Text("Choose from Gallery"),
              ),
              SimpleDialogOption(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("Cancel"),
              ),
            ],
          );
        });
  }

  File? _image, _icon;
  final ImagePicker picker = ImagePicker();

  Future chooseImageFromCamera() async {
    var Image = await picker.pickImage(source: ImageSource.camera);
    setState(() {
      _image = File(Image!.path);
    });
    Navigator.of(context).pop();
  }

  Future chooseIconFromCamera() async {
    var Image = await picker.pickImage(source: ImageSource.camera);
    setState(() {
      _icon = File(Image!.path);
    });
    Navigator.of(context).pop();
  }

  Future chooseImageFromGallery() async {
    var Image = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = File(Image!.path);
    });
    Navigator.of(context).pop();
  }

  Future chooseIconFromGallery() async {
    var Image = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _icon = File(Image!.path);
    });
    Navigator.of(context).pop();
  }
}
