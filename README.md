# JSON-like description for Objective-C collection objects (ObjCJSONLikeDescription)


This library makes **Objective-C collection objects** (e.g. `NSDictionary`, `NSArray`, `NSSet`, and `NSOrderSet`) return a **JSON-like** and **Unicode** string. It would be helpful when using `NSLog()` or interacting with LLDB or GDB in Xcode console to print collection objects.


There is a problem if you log collection objects in Xcode console. For example, if a dictionary containing Unicode strings and multiple-level collection:

```objc
id collection =
@[
  @YES,
  @NO,
  @0,
  @1,
  @[
    @(YES),
    @(NO),
    @(0),
    @(1),
    ],
  @{
    @"你好": @"Hello",
    @"再見": @"Bye"
    }
  ];
NSLog(@"collection: %@", collection);
```

Results in Xcode console **WITHOUT** this library:

```
(
    1,
    0,
    0,
    1,
        (
        1,
        0,
        0,
        1
    ),
        {
        "\U4f60\U597d" = Hello;
        "\U518d\U898b" = Bye;
    }
)
```

Results in Xcode console **WITH** this library:

```
[
	true,
	false,
	0,
	1,
	[
		true,
		false,
		0,
		1
	],
	{
		"你好": "Hello",
		"再見": "Bye"
	}
]
```


Summary
-------
This library changes `description` and `debugDescription` of collection objects:

- Elements in collection objects are more JSON-like:.
    * String values are always unicodified and embraced by double quotes (`"`).
    * Value collection objects (`NSArray`, `NSSet`, and `NSOrderedSet`) are embraced by square brackets (`[]`), not parentheses (`()`).
    * Key-value pairs are separated by colon (`:`), not equal sign (`=`).
    * Elements are separated by comma (`,`), not semicolon (`;`).
    * `NSNull` in collection objects are showing `null`, not `<null>`.
    * Boolean object (`@YES`/`@NO`) are showing `true`/`false`, not `1`/`0`.
    * Other objects are also embraced by double quotes (`"`) as a string.
- Correct the indentation of collection objects for multiple levels.
- Customizable indentation (using tabulators by default) by defining `INDT_FOR_DESCRIPTION` in the .pch file.


How to use
----------
Just include the library in your project. No extra code is required.


Warning
-------
This library will change the `description` and `debugDescription` of some collection classes to return a JSON-like output. Use this library carefully.


Installation
------------
You could install this library via CocoaPods

    pod 'ObjCJSONLikeDescription'

or dragging files in `ObjCJSONLikeDescription/` into your project manually.

**NOTE: This source is an aspect patch using [XAspect][]. You should also include this library in your project too.**


Support other classes with subspec
----------------------------------

#### [M13OrderedDictionary](https://github.com/Marxon13/M13OrderedDictionary) 

    pod 'ObjCJSONLikeDescription/M13OrderedDictionary'


About
-----

### Author

Xaree Lee (李岡諭, Kang-Yu Lee), an iOS developer from Taiwan.

* <xareelee@gmail.com>


### License

This library is released under the MIT license. See the LICENSE file for more info.





<!--Links-->
[XAspect]: https://github.com/xareelee/XAspect
[XAspectPatches]: https://github.com/xareelee/XAspectPatches



