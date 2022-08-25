## 1.1.0+2
* Add pub.dev link to Readme for repo

## 1.1.0+1
* Fix Readme in pub.dev

## 1.1.0
* Don't insert `SizedBox` around `Spacer` widget

## 1.0.1
* Fix **'BoxConstraints has negative minimum width (or height)'** error when using smaller values than `height`/`width` in `start` and `end` parameter 

## 1.0.0

* Add `SizedBox` between every widget in a `List<Widget>`
* Also add at the start and end of the List
* Adjust the `height` or `width` for any inserted `SizedBox` with `AdjustSpace`
* Don't insert `SizedBox` with `NoSpace`
