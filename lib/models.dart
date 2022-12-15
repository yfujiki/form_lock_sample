import 'dart:io';

// Data for manual entry form
class Form {
  final List<FormItem> items;

  Form(this.items);
}

class FormItem {
  final String id;
  final String title;
  // ...
  bool locked = false;

  FormItem(this.id, this.title);
}

// Data for image entry form
class ImageForm {
  final List<ImageFormItem> items;

  ImageForm(this.items);
}

class ImageFormItem {
  final String id;
  final String title;
  File? image;
  // ...
  final List<String> relatedFormItemIds; // This is the key
  bool imageLoaded = false;

  ImageFormItem(this.id, this.title, this.image, this.relatedFormItemIds);
}
