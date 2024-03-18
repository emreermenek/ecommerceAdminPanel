import 'package:bestshop_adminpanel/consts/app_consts.dart';
import 'package:bestshop_adminpanel/consts/validators.dart';
import 'package:bestshop_adminpanel/providers/theme_provider.dart';
import 'package:bestshop_adminpanel/services/app_functions.dart';
import 'package:bestshop_adminpanel/widgets/image_picker_widget.dart';
import 'package:bestshop_adminpanel/widgets/subtitle_text.dart';
import 'package:bestshop_adminpanel/widgets/title_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../models/product_model.dart';
import '../widgets/material_button_widget.dart';

class EditOrUploadProductPage extends StatefulWidget {
  static const String rootName = "/edit_upload_product";
  const EditOrUploadProductPage({super.key, this.productModel});
  final ProductModel? productModel;

  @override
  State<EditOrUploadProductPage> createState() => _AddNewProductPageState();
}

class _AddNewProductPageState extends State<EditOrUploadProductPage> {
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
  bool isEditing = false;
  String? networkImage;

  @override
  void initState() {
    if (widget.productModel != null) {
      isEditing = true;
      networkImage = widget.productModel!.productImage;
      _dropdownValue = widget.productModel!.productCategory;
    }
    _titleController = TextEditingController(
        text: widget.productModel
            ?.productTitle); // ? means if productModel == null then return ""
    _priceController =
        TextEditingController(text: widget.productModel?.productPrice);
    _quantityController =
        TextEditingController(text: widget.productModel?.productQuantity);
    _descriptionController =
        TextEditingController(text: widget.productModel?.productDescription);

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
          networkImage = null;
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
      networkImage = null;
    });
  }

  Future<void> _uploadProduct() async {
    if (_pickedImage == null) {
      AppFunctions.showErrorOrWarningDialog(
          context: context, func: () {}, title: "Please pick an image");
      return;
    }
    final isValid = _formKey.currentState!.validate();
    if (isValid) {}
  }

  Future<void> _editProduct() async {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (_pickedImage == null && networkImage == null) {
      AppFunctions.showErrorOrWarningDialog(
          context: context, func: () {}, title: "Please pick an image");
      return;
    }
    if (isValid) {}
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final size = MediaQuery.of(context).size;
    return Scaffold(
      bottomSheet: SizedBox(
        height: kBottomNavigationBarHeight + 10,
        child: Material(
          color: Theme.of(context).scaffoldBackgroundColor,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 4, right: 2, left: 2),
            child: Row(
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
                      style:
                          ElevatedButton.styleFrom(backgroundColor: Colors.red),
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
                        onPressed: () {
                          if (isEditing) {
                            _editProduct();
                          } else {
                            _uploadProduct();
                          }
                        },
                        label: TitleTextWidget(
                          label: isEditing ? "Edit Product" : "Upload Product",
                          fontSize: 16,
                        )),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
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
        title: SubtitleTextWidget(
            label: isEditing ? "Edit Product" : "Add new product"),
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
                  if (isEditing && networkImage != null) ...[
                    SizedBox(
                      height: size.width * 0.4,
                      width: size.width * 0.4,
                      child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(25),
                            child: Container(
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                    fit: BoxFit.fill,
                                    image: NetworkImage(
                                      networkImage!,
                                    ),
                                  ),
                                  border: Border.all(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onBackground),
                                  borderRadius: BorderRadius.circular(25)),
                            ),
                          ),
                          Positioned(
                            right: 0,
                            top: 0,
                            child: MaterialButtonWidget(
                              size: 20,
                              padding: 5.5,
                              color: Colors.lightBlue.shade300,
                              borderRadius: 25,
                              icon: Icons.edit,
                              func: () async {
                                await localImagePicker();
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  ] else ...[
                    SizedBox(
                        height: size.width * 0.4,
                        width: size.width * 0.4,
                        child: ImagePickerWidget(
                            pickedImage: _pickedImage,
                            func: () async {
                              await localImagePicker();
                            })),
                  ],
                  const SizedBox(
                    height: 25,
                  ),
                  SizedBox(
                    height: size.width * 0.1,
                    width: size.width * 0.6,
                    child: DropdownButtonFormField(
                      focusNode: _categoryFocus,
                      decoration: InputDecoration(
                        hintText: "Categories",
                        filled: true,
                        fillColor: themeProvider.getIsDarkTheme
                            ? Colors.blueGrey.shade800.withOpacity(0.5)
                            : Colors.blueGrey.shade100.withOpacity(0.2),
                      ),
                      value: _dropdownValue,
                      alignment: AlignmentDirectional.center,
                      icon: const Icon(Icons.arrow_drop_down),
                      items: AppConstants.dropdownValues,
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
                    minLines: 1,
                    maxLines: 2,
                    textInputAction: TextInputAction.newline,
                    keyboardType: TextInputType.multiline,
                    maxLength: 80,
                    decoration: InputDecoration(
                      hintText: "Title",
                      filled: true,
                      fillColor: themeProvider.getIsDarkTheme
                          ? Colors.blueGrey.shade800.withOpacity(0.5)
                          : Colors.blueGrey.shade100.withOpacity(0.2),
                    ),
                    validator: (value) {
                      Validators.uploadProductTexts(
                          value: value,
                          toBeReturnedString: "Please enter a valid title");
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
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(
                                RegExp(r"^([0-9]{0,2}((.)[0-9]{0,2}))$"))
                          ],
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: themeProvider.getIsDarkTheme
                                  ? Colors.blueGrey.shade800.withOpacity(0.5)
                                  : Colors.blueGrey.shade100.withOpacity(0.2),
                              hintText: "Price",
                              prefix: const SubtitleTextWidget(
                                label: "\$",
                                color: Colors.blue,
                              )),
                          onFieldSubmitted: (value) {
                            FocusScope.of(context).requestFocus(_quantityFocus);
                          },
                          validator: (value) {
                            return Validators.uploadProductTexts(
                                value: value,
                                toBeReturnedString: "Price is missing");
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
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: themeProvider.getIsDarkTheme
                                  ? Colors.blueGrey.shade800.withOpacity(0.5)
                                  : Colors.blueGrey.shade100.withOpacity(0.2),
                              hintText: "Qty"),
                          onFieldSubmitted: (value) {
                            FocusScope.of(context)
                                .requestFocus(_descriptionFocus);
                          },
                          validator: (value) {
                            return Validators.uploadProductTexts(
                                value: value,
                                toBeReturnedString: "Quantity is missing");
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
                    textCapitalization: TextCapitalization.sentences,
                    maxLength: 1000,
                    maxLines: 4,
                    decoration: InputDecoration(
                      hintText: "Description",
                      filled: true,
                      fillColor: themeProvider.getIsDarkTheme
                          ? Colors.blueGrey.shade800.withOpacity(0.5)
                          : Colors.blueGrey.shade100.withOpacity(0.2),
                    ),
                    onFieldSubmitted: (value) {
                      FocusScope.of(context).unfocus();
                    },
                    validator: (value) {
                      return Validators.uploadProductTexts(
                          value: value,
                          toBeReturnedString: "Missing description");
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
