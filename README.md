Unicodifying Descriptions Of NSFoundation Objects (Installable)
=================================================

This source is an aspect patch using [XAspect][]. You can install this via CocoaPods.

	pod 'XAspect-Foundation_UnicodifyingDescriptionsOfObjects'

or dragging files in `AspectFiles/` into your project manually.

Summary
-------

This aspect changes the logs of some foundation objects in Xcode console:

 - Print string values using Unicode in colletion objects.
 - Correct the indentation of collection objects for multiple levels.
 - Customizable indentation. Default is a tab.
 - Elements in collection objects are more JSON-like. 
	 * Key-value pairs are separated by colon (`:`), not equal sign (`=`).
	 * Elements are separated by comma (`,`), not semicolon (`;`).
	 * NSNull in collection objects are showing `null`, not `<null>`.

Description
-----------

There is a problem if you log collection objects in Xcode console. For example, if your dictionary containing Unicode strings:

```objc
NSDictionary *dict = @{@"你好":@"Hello",
                       @"再見":@"Bye"};
NSLog(@"dict: %@", dict);
```

the results in the Xcode console would be:

```
{
    "\U4f60\U597d" = Hello;
    "\U518d\U898b" = Bye;
}
```

The output isn't encoded by Unicode. With this aspect patch, the string objects will be embraced by `""` and be printed using Unicode:

```
{
    "你好" : "Hello",
    "再見" : "Bye"
}
```


<!--Links-->
[XAspect]: https://github.com/xareelee/XAspect
[XAspectPatches]: https://github.com/xareelee/XAspectPatches
