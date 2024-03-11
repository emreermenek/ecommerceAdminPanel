import 'package:bestshop_adminpanel/consts/app_consts.dart';
import 'package:bestshop_adminpanel/services/app_functions.dart';
import 'package:bestshop_adminpanel/widgets/image_picker_widget.dart';
import 'package:bestshop_adminpanel/widgets/subtitle_text.dart';
import 'package:bestshop_adminpanel/widgets/title_text.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddNewProductPage extends StatefulWidget {
  static const String rootName = "/addnew_product";
  const AddNewProductPage({super.key});

  @override
  State<AddNewProductPage> createState() => _AddNewProductPageState();
}

class _AddNewProductPageState extends State<AddNewProductPage> {
  late final TextEditingController _titleController,
      _priceController,
      _quantityController,
      _descriptionController;

  late final FocusNode _categoryFocus,
      _titleFocus,
      _priceFocus,
      _quantityFocus,
      _descriptionFocus;

  final _formKey = GlobalKey<FormState>();

  String? _dropdownValue;
  XFile? _pickedImage;
  @override
  void initState() {
    _titleController = TextEditingController();
    _priceController = TextEditingController();
    _quantityController = TextEditingController();
    _descriptionController = TextEditingController();

    _categoryFocus = FocusNode();
    _titleFocus = FocusNode();
    _priceFocus = FocusNode();
    _quantityFocus = FocusNode();
    _descriptionFocus = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _priceController.dispose();
    _quantityController.dispose();
    _descriptionController.dispose();

    _categoryFocus.dispose();
    _titleFocus.dispose();
    _priceFocus.dispose();
    _quantityFocus.dispose();
    _descriptionFocus.dispose();
    super.dispose();
  }

  Future<void> localImagePicker() async {
    final ImagePicker imagePicker = ImagePicker();
    await AppFunctions.imagePickerDialog(
        context: context,
        cameraFunc: () async {
          _pickedImage =
              await imagePicker.pickImage(source: ImageSource.camera);
          setState(() {});
        },
        galleryFunc: () async {
          _pickedImage =
              await imagePicker.pickImage(source: ImageSource.gallery);
          setState(() {});
        },
        removeFunc: () {
          _pickedImage = null;
          setState(() {});
        });
  }

  void clearForm() {
    _titleController.clear();
    _priceController.clear();
    _descriptionController.clear();
    _quantityController.clear();
    _dropdownValue = null;
    removePickedImage();
  }

  void removePickedImage() {
    setState(() {
      _pickedImage = null;
    });
  }

  Future<void> _uploadProduct() async {
    if (_pickedImage == null) {
      AppFunctions.showErrorOrWarningDialog(
          context: context, func: () {}, title: "Please pick an image");
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 40,
        leading: IconButton(
          onPressed: () {
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            }
          },
          icon: const Icon(Icons.arrow_back_ios_new_outlined),
        ),
        centerTitle: true,
        title: const SubtitleTextWidget(label: "Add new product"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  const SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                      height: size.width * 0.4,
                      width: size.width * 0.4,
                      child: ImagePickerWidget(
                          pickedImage: _pickedImage,
                          func: () async {
                            await localImagePicker();
                          })),
                  const SizedBox(
                    height: 25,
                  ),
                  SizedBox(
                    height: size.width * 0.1,
                    width: size.width * 0.6,
                    child: DropdownButtonFormField(
                      focusNode: _categoryFocus,
                      decoration: const InputDecoration(hintText: "Categories"),
                      value: _dropdownValue,
                      alignment: AlignmentDirectional.center,
                      icon: const Icon(Icons.arrow_drop_down),
                      items: AppConstants.categoriesList
                          .map<DropdownMenuItem<String>>((String categorie) {
                        return DropdownMenuItem<String>(
                          value: categorie,
                          child: Text(categorie),
                        );
                      }).toList(),
                      onChanged: (String? categorie) {
                        setState(() {
                          _dropdownValue = categorie!;
                        });
                        FocusScope.of(context).requestFocus(_titleFocus);
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  TextFormField(
                    controller: _titleController,
                    focusNode: _titleFocus,
                    textInputAction: TextInputAction.next,
                    maxLength: 80,
                    decoration: const InputDecoration(hintText: "Title"),
                    onFieldSubmitted: (value) {
                      FocusScope.of(context).requestFocus(_priceFocus);
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      Flexible(
                        child: TextFormField(
                          controller: _priceController,
                          focusNode: _priceFocus,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(hintText: "Price"),
                          onFieldSubmitted: (value) {
                            FocusScope.of(context).requestFocus(_quantityFocus);
                          },
                        ),
                      ),
                      const SizedBox(
                        width: 30,
                      ),
                      Flexible(
                        child: TextFormField(
                          controller: _quantityController,
                          focusNode: _quantityFocus,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                              hintText: "Qty", fillColor: Colors.grey),
                          onFieldSubmitted: (value) {
                            FocusScope.of(context)
                                .requestFocus(_descriptionFocus);
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    controller: _descriptionController,
                    focusNode: _descriptionFocus,
                    textInputAction: TextInputAction.done,
                    maxLength: 1000,
                    maxLines: 4,
                    decoration: const InputDecoration(hintText: "Description"),
                    onFieldSubmitted: (value) {
                      FocusScope.of(context).unfocus();
                    },
                  ),
                  const SizedBox(
                    height: 35,
                  ),
                  Row(
                    children: [
                      Flexible(
                        flex: 3,
                        child: SizedBox(
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            icon: const Icon(
                              Icons.close,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              clearForm();
                            },
                            label: const TitleTextWidget(
                              label: "Clear",
                              fontSize: 16,
                              color: Colors.white,
                            ),
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Flexible(
                        flex: 5,
                        child: SizedBox(
                          width: double.infinity,
                          child: ElevatedButton.icon(
                              icon: const Icon(
                                Icons.upload,
                              ),
                              onPressed: () {},
                              label: const TitleTextWidget(
                                label: "Upload Product",
                                fontSize: 16,
                              )),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
