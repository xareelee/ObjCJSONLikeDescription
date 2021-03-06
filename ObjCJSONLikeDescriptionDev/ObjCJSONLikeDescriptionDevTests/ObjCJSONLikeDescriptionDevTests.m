//
//  ObjCJSONLikeDescriptionDevTests.m
//  ObjCJSONLikeDescriptionDevTests
//
//  Created by Xaree on 11/1/15.
//  Copyright © 2015 Xaree Lee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <XCTest/XCTest.h>

@interface ObjCJSONLikeDescriptionDevTests : XCTestCase

@end

@implementation ObjCJSONLikeDescriptionDevTests

- (void)testDescription {
  // This is an example of a functional test case.
  NSArray *array =
  @[@"如果你不愛我",
    @"我會讓你走",
    @"如果你真心愛我",
    @"我會讓你擁有全世界",
    @{@"真的嗎？":@"真的"}
    ];
  
  NSString *descriptionOfArray = @"[\n\t\"如果你不愛我\",\n\t\"我會讓你走\",\n\t\"如果你真心愛我\",\n\t\"我會讓你擁有全世界\",\n\t{\n\t\t\"真的嗎？\": \"真的\"\n\t}\n]" ;
  
  XCTAssert([[array description] isEqualToString:descriptionOfArray],
            @"The description from ObjCJSONLikeDescription should be a JSON-like format.");
}

@end
