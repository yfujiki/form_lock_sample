import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_lock_sample/models.dart';
import 'dart:io';

class ImageFormStateNotifier extends StateNotifier<ImageForm> {
  ImageFormStateNotifier(super.state);

  void loadImageForItemId(String id, File image) {
    final item = state.items.firstWhere((element) => element.id == id);
    item.image = image;
    item.imageLoaded = true;

    final updatedItems = state.items.map((e) {
      if (e.id == id) {
        return item;
      }
      return e;
    }).toList();

    state = ImageForm(updatedItems);
  }
}

class FormStateNotifier extends StateNotifier<Form> {
  FormStateNotifier(super.state);
}

final imageFormStateProvider =
    StateNotifierProvider<ImageFormStateNotifier, ImageForm>((ref) {
  return ImageFormStateNotifier(ImageForm([
    ImageFormItem("1", "Image Form Q1, locks Form Q2", null, ["2"]),
    ImageFormItem("2", "Image Form Q2, locks Form Q3", null, ["3"]),
    ImageFormItem("3", "Image Form Q3, locks Form Q1,2", null, ["1", "2"]),
  ]));
});

final formStateProvider = StateNotifierProvider<FormStateNotifier, Form>((ref) {
  return FormStateNotifier(Form([
    FormItem("1", "Form Q1"),
    FormItem("2", "Form Q2"),
    FormItem("3", "Form Q3"),
  ]));
});

final lockedFormStateProvider = Provider<Form>((ref) {
  final imageForm = ref.watch(imageFormStateProvider);
  final form = ref.watch(formStateProvider);

  final lockedFormItemIds =
      imageForm.items.fold(<String>{}, (previousValue, element) {
    if (element.imageLoaded) {
      previousValue.addAll(element.relatedFormItemIds);
    }
    return previousValue;
  });

  final updatedFormItems = form.items.map((e) {
    if (lockedFormItemIds.contains(e.id)) {
      e.locked = true;
    }
    return e;
  }).toList();

  return Form(updatedFormItems);
});
