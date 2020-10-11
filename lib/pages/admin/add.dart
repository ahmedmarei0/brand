import 'package:brand/classes/product.dart';
import 'package:brand/constant/constant_element.dart';
import 'package:brand/helper_function/adminMainNavbar.dart';
import 'package:brand/helper_function/customField.dart';
import 'package:brand/helper_function/custom_drawer.dart';
import 'package:brand/language/constants_word.dart';
import 'package:brand/localization/localization_constant.dart';
import 'package:brand/provider/change_color.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:brand/firebase/firebase_action.dart';
import 'package:provider/provider.dart';

class AddProduct extends StatefulWidget {
  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final GlobalKey<FormState> _globalKey = new GlobalKey<FormState>();
  File _image;
  final picker = ImagePicker();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  String _prodctName,
      _productPrice,
      _productDescription,
      _productCategory,
      _productImage;
  @override
  Widget build(BuildContext context) {
    MainColorApp mainColorApp = Provider.of<MainColorApp>(context);
    return Stack(
      children: [
        Scaffold(
          key: _scaffoldKey,
          drawer: CustomDrawer(),
          backgroundColor: mainColorApp.color,
          body: Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Form(
              key: _globalKey,
              child: ListView(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .08,
                  ),
                  CustomTextField(
                    hint: trans(context, KProductHintName),
                    icon: Icons.indeterminate_check_box,
                    onClick: (val) {
                      _prodctName = val;
                    },
                    value: _prodctName,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  CustomTextField(
                    hint: trans(context, KProductHintPrice),
                    icon: Icons.money_off,
                    onClick: (val) {
                      _productPrice = val;
                    },
                    value: _productPrice,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  CustomTextField(
                    hint: trans(context, KProductHintDecription),
                    icon: Icons.book,
                    onClick: (val) {
                      _productDescription = val;
                    },
                    value: _productDescription,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  CustomTextField(
                    hint: trans(context, KProductHintCategory),
                    icon: Icons.group_work,
                    onClick: (val) {
                      _productCategory = val;
                    },
                    value: _productCategory,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: 15, left: 20, right: 20, bottom: 5),
                    child: Text(
                      trans(context, KProductHintImage),
                      style: TextStyle(color: KWhite, fontSize: 18),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                    child: LimitedBox(
                      maxWidth: 150,
                      maxHeight: _image == null ? 0 : 150,
                      child: _image == null
                          ? Text('No image selected.')
                          : Image.file(
                              _image,
                              fit: BoxFit.fill,
                            ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      FlatButton(
                        onPressed: () {
                          getImageFromPhone();
                        },
                        child: Column(
                          children: [
                            Icon(
                              Icons.camera,
                              color: KWhite,
                            ),
                            Text(
                              trans(context, KOpenCamera),
                              style: TextStyle(color: KWhite),
                            )
                          ],
                        ),
                      ),
                      FlatButton(
                        onPressed: () {
                          getImageFromGallery();
                        },
                        child: Column(
                          children: [
                            Icon(
                              Icons.image,
                              color: KWhite,
                            ),
                            Text(
                              trans(context, KOpenGallery),
                              style: TextStyle(color: KWhite),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: Builder(
                      builder: (context) => RaisedButton(
                        onPressed: () {
                          if (_globalKey.currentState.validate() &&
                              _image != null) {
                            _globalKey.currentState.save();
                            addNewProduct(context);
                          } else if (_image == null) {
                            Scaffold.of(context).showSnackBar(SnackBar(
                              content: Text('Please Pick Image'),
                            ));
                          }
                        },
                        padding: EdgeInsets.all(7),
                        child: Text(
                          trans(context, KAddProduct),
                          style: TextStyle(
                              color: mainColorApp.color,
                              fontFamily: KLateef,
                              fontSize: 24,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        CustomNavBar(
          scaffoldKey: _scaffoldKey,
          title: KAddProduct,
        ),
      ],
    );
  }

  Future getImageFromPhone() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        // print('No image selected.');
      }
    });
  }

  Future getImageFromGallery() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        // print('No image selected.');
      }
    });
  }

  addNewProduct(context) async {
    try {
      if (_image == null) {
        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text('Please Pick Image'),
        ));
        return;
      }
      FirebaseStorage storage =
          FirebaseStorage(storageBucket: 'gs://mareitest.appspot.com');
      StorageReference ref = storage.ref().child(path.basename(_image.path));
      StorageUploadTask storageUploadTask = ref.putFile(_image);
      StorageTaskSnapshot taskSnapshot = await storageUploadTask.onComplete;
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text('Success Upload'),
      ));
      String url = await taskSnapshot.ref.getDownloadURL();
      _productImage = url;

      Product p = new Product(
        pname: _prodctName,
        pprice: _productPrice,
        pdescription: _productDescription,
        pcategory: _productCategory,
        plocation: _productImage,
      );

      Store store = new Store();
      store.addProduct(p);

      Scaffold.of(context).showSnackBar(SnackBar(
        backgroundColor: KWhite,
        content: Container(
          color: KWhite.withOpacity(0.75),
          child: Text(
            trans(context, KSuccessfullyAdd),
            style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontFamily: KLateef,
                fontWeight: FontWeight.bold),
          ),
        ),
      ));
      Future.delayed(Duration(milliseconds: 1250), () {
        Navigator.pop(context);
      });
    } on PlatformException catch (e) {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text(e.message),
      ));
    }
  }
}
