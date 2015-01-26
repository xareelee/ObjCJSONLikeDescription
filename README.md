Unicodifying Descriptions Of NSFoundation Objects (Installable)
=================================================

This source is an aspect patch using [XAspect][]. You can install this via CocoaPods.

	pod 'XAspect-Foundation_UnicodifyingDescriptionsOfObjects'

or dragging files in `AspectFiles/` into your project manually.

Summary
-------

This aspect changes the logs of some foundation objects in Xcode console:

 - Print string values using Unicode in colletion objects.
 - Print out the escape characters in the colletion correctly.
 - Correct the indentation of collection objects for multiple levels.
 - Customizable indentation. Default is a tab.
 - Elements in collection objects are more JSON-like. 
	 * Key-value pairs are separated by colon (`:`), not equal sign (`=`).
	 * Elements are separated by comma (`,`), not semicolon (`;`).
	 * NSNull in collection objects are showing `null`, not `<null>`.

Description
-----------

### Unicodifying and JSON-like

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

### Escape characters embedded in a collection object

Print the `userinfo` of an `NSError` for the response of an HTTP request without **Foundation_UnicodifyingDescriptionsOfObjects**:

```
userinfo: {
    NSErrorFailingURLKey = "http://xxx.xxx.com/xxx.xml";
    NSLocalizedDescription = "Request failed: unauthorized (401)";
    "com.alamofire.serialization.response.error.data" = <>;
    "com.alamofire.serialization.response.error.response" = "<NSHTTPURLResponse: 0x7f8c81731e60> { URL: http://xxx.xxx.com/xxx.xml } { status code: 401, headers {\n    Connection = \"Keep-Alive\";\n    \"Content-Length\" = 0;\n    \"Content-Type\" = \"application/xml\";\n    Date = \"Mon, 26 Jan 2015 03:10:25 GMT\";\n    \"Keep-Alive\" = \"timeout=5, max=99\";\n    Server = \"BW HTTP Server\";\n    \"Www-Authenticate\" = \"Basic realm=\\\"basicRealm\\\"\";\n} }";
}
```

With **Foundation_UnicodifyingDescriptionsOfObjects**, the escape characters will be printed out correctly, more readable:

```
userinfo: {
	"com.alamofire.serialization.response.error.response" : <NSHTTPURLResponse: 0x7fcad53007a0> { URL: http://xsp.your080.com.tw/dms/way/way_profile.xml } { status code: 401, headers {
	"Server" : "BW HTTP Server",
	"Content-Type" : "application/xml",
	"Date" : "Mon, 26 Jan 2015 03:19:05 GMT",
	"Www-Authenticate" : "Basic realm="basicRealm"",
	"Keep-Alive" : "timeout=5, max=99",
	"Content-Length" : "0",
	"Connection" : "Keep-Alive"
} },
	"NSErrorFailingURLKey" : http://xsp.your080.com.tw/dms/way/way_profile.xml,
	"com.alamofire.serialization.response.error.data" : <>,
	"NSLocalizedDescription" : "Request failed: unauthorized (401)"
}
```



<!--Links-->
[XAspect]: https://github.com/xareelee/XAspect
[XAspectPatches]: https://github.com/xareelee/XAspectPatches
