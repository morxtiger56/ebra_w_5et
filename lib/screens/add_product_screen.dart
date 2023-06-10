import 'dart:io';

import 'package:WomenIncome/ui/form_filed_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:image_picker/image_picker.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({super.key});
  static const routeName = "/add-product";

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  var colors = [];

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  File? tempImage;
  final sizes = ["Xs", "Sm", "Md", "Lg", "Xl", "2Xl", "3Xl"];
  var selectedSizes = [];
  Future _selectImage(ImageSource src) async {
    final image = await ImagePicker().pickImage(source: src);
    if (image == null) return;
    final fileImage = File(image.path);
    setState(() {
      tempImage = fileImage;
    });
  }

  _pickImage() async {
    showModalBottomSheet(
        context: context,
        builder: (_) => Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton.icon(
                  onPressed: () async => _selectImage(ImageSource.camera),
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      vertical: 30,
                      horizontal: 5,
                    ),
                  ),
                  icon: const Icon(
                    Icons.camera_alt,
                  ),
                  label: const Text("Camera"),
                ),
                TextButton.icon(
                  onPressed: () async => _selectImage(ImageSource.gallery),
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      vertical: 30,
                      horizontal: 5,
                    ),
                  ),
                  icon: const Icon(
                    Icons.camera,
                  ),
                  label: const Text("Gallery"),
                ),
              ],
            ));
  }

  String _modifySizes(String size) {
    if (selectedSizes.contains(size)) {
      selectedSizes.remove(size);
      return "remove";
    } else {
      selectedSizes.add(size);
      return "add";
    }
  }

  String _modifyColors(Color color, String op) {
    switch (op) {
      case "add":
        var found = false;

        for (var element in colors) {
          if (element == "#${color.value.toRadixString(16).substring(2)}") {
            found = true;
            continue;
          }
        }

        if (colors.isNotEmpty && found) {
          return "Found";
        }
        colors.add("#${color.value.toRadixString(16).substring(2)}");

        return "added";
      case "Remove":
        print(colors);

        colors.removeWhere(
          (e) => e == "#${color.value.toRadixString(16).substring(2)}",
        );
        print(colors);

        return "removed";
      default:
        return "Missing OP";
    }
  }

  Future<void> _addProduct() async {
    if (_formKey.currentState == null) {
      return;
    }
    _formKey.currentState!.save();
    if (!_formKey.currentState!.validate()) {
      return;
    }

    print(
      {
        "text": _nameController.value.text,
        "price": _priceController.value.text,
        "desc": _descController.value.text,
        "colors": colors,
        "sizes": selectedSizes,
      }.toString(),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    if (_formKey.currentState != null) {
      _formKey.currentState!.dispose();
    }
    _nameController.dispose();
    _descController.dispose();
    _priceController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Product"),
        automaticallyImplyLeading: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 30,
            horizontal: 20,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  "Please complete the form in arabic",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(
                  height: 20,
                ),
                FormFieldWidget(
                  label: "Product Name",
                  controller: _nameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Name Cannot Be Empty";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                FormFieldWidget(
                  label: "Product Price",
                  controller: _priceController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Price Cannot Be Empty";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: "Product Description",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(
                          5,
                        ),
                      ),
                    ),
                  ),
                  minLines: 5,
                  maxLines: null,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: _descController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Description Cannot Be Empty";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 30,
                ),
                if (tempImage != null)
                  Image.file(
                    tempImage!,
                    height: 400,
                    width: 400,
                  ),
                TextButton.icon(
                  onPressed: _pickImage,
                  icon: const Icon(Icons.add_a_photo),
                  label: const Text("Add Product Image"),
                ),
                const SizedBox(
                  height: 10,
                ),
                // Image.asset("name"),
                const SizedBox(
                  height: 30,
                ),
                const Text("Product Colors"),
                const SizedBox(
                  height: 20,
                ),
                ColorSelector(changeColorFunction: _modifyColors),
                const SizedBox(
                  height: 30,
                ),
                const Text("Product Sizes"),
                const SizedBox(
                  height: 20,
                ),
                SizeSelector(
                  sizes: sizes,
                  changeValue: _modifySizes,
                ),
                const SizedBox(
                  height: 30,
                ),
                FilledButton.icon(
                  onPressed: _addProduct,
                  icon: const Icon(Icons.upload),
                  label: const Text("Add Product"),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SizeSelector extends StatefulWidget {
  const SizeSelector(
      {super.key, required this.sizes, required this.changeValue});

  final List<String> sizes;
  final Function changeValue;

  @override
  State<SizeSelector> createState() => _SizeSelectorState();
}

class _SizeSelectorState extends State<SizeSelector> {
  List<String> selectedSizes = [];

  @override
  Widget build(BuildContext context) {
    return Row(
      children: widget.sizes
          .map(
            (e) => Row(
              children: [
                InkWell(
                  borderRadius: BorderRadius.circular(20),
                  onTap: () {
                    final res = widget.changeValue(e);
                    setState(() {
                      if (res == "add") {
                        selectedSizes.add(e);
                      } else {
                        selectedSizes.remove(e);
                      }
                    });
                  },
                  child: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: selectedSizes.contains(e)
                            ? Theme.of(context).colorScheme.primary
                            : Colors.black,
                        width: 2,
                      ),
                    ),
                    child: Center(
                      child: Text(e),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 5,
                )
              ],
            ),
          )
          .toList(),
    );
  }
}

class ColorSelector extends StatefulWidget {
  const ColorSelector({super.key, required this.changeColorFunction});
  final Function(Color, String) changeColorFunction;
  @override
  State<ColorSelector> createState() => _ColorSelectorState();
}

class _ColorSelectorState extends State<ColorSelector> {
  List<Color> colors = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: colors
                .map(
                  (e) => Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(20),
                      onTap: () {
                        widget.changeColorFunction(e, "Remove");
                        setState(() {
                          colors.remove(e);
                        });
                      },
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: Colors.black,
                            width: 2,
                          ),
                          color: e,
                        ),
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        MaterialPicker(
          pickerColor: Colors.white,
          onColorChanged: (Color value) {
            var res = widget.changeColorFunction(value, "add");
            if (res != "Found") {
              setState(
                () => {
                  colors.add(value),
                },
              );
            }
          },
        ),
      ],
    );
  }
}
