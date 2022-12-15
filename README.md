# Form Lock Sample

A sample code to lock form items when relevant image form item's image was uploaded.

## Getting Started

The key here is how to structure models. Here, I let `ImageFormItem` to include `relatedFormItemIds`, which are the list of `id`s of `FormItem` it is related to. Using this info, when an image is uploaded for `ImageFormItem`, you can lock related `FormItem`s.

## Demo

https://user-images.githubusercontent.com/879725/207986124-21b25c45-2997-422f-93de-5547aa072621.mov

