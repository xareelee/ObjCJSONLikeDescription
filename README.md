Unicodifying Descriptions Of NSFoundation Objects (Installable)
=================================================

This source is an aspect patch using [XAspect][]. You can install this via CocoaPods.

	pod 'XAspect-Foundation_UnicodifyingDescriptionsOfObjects'

or dragging files in `AspectFiles/` into your project manually.

Summary
-------

This aspect change the descriptions of some foundation objects to print correctly in ASL (Apple System Logger):

 - Print unicodified string values.
 - Correct the indentation of collection objects for multiple levels.
 - Customizable indentation. Default is a tab.
 - Elements in collection objects are more JSON-like. 
	 * Key-value pairs are separated by colon (`:`), not equal sign (`=`).
	 * Elements are separated by comma (`,`), not semicolon (`;`).
	 * NSNull in collection objects are showing `null`, not `<null>`.

Description
-----------

There is a problem if you want to log some NSFoundation objects in ASL (Apple System Logger). For example, if your dictionary containing Unicode strings:

```objc
NSDictionary *dict = @{@"如果你不愛我":@"我會讓你走",
					   @"如果你真心愛我":@"我會讓你擁有全世界"};
NSLog(@"dict: %@", dict);
```

the results in the Xcode console would be:

```
{
    "\U5982\U679c\U4f60\U4e0d\U611b\U6211" = "\U6211\U6703\U8b93\U4f60\U8d70";
    "\U5982\U679c\U4f60\U771f\U5fc3\U611b\U6211" = "\U6211\U6703\U8b93\U4f60\U64c1\U6709\U5168\U4e16\U754c";
}
```

With this aspect patch, the string objects will be embraced by `""` and be printed correctly using Unicode:

```
{
	"如果你真心愛我" : "我會讓你擁有全世界",
	"如果你不愛我" : "我會讓你走"
}
```


<!--Links-->
[XAspect]: https://github.com/xareelee/XAspect
[XAspectPatches]: https://github.com/xareelee/XAspectPatches