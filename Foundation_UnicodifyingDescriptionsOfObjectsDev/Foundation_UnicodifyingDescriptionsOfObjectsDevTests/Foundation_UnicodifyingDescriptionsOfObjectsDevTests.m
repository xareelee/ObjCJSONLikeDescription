//
//  Foundation_UnicodifyingDescriptionsOfObjectsDevTests.m
//  Foundation_UnicodifyingDescriptionsOfObjectsDevTests
//
//  Created by Xaree on 12/15/14.
//  Copyright (c) 2014 Xaree Lee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import <XAspect/XAspect.h>

@interface Foundation_UnicodifyingDescriptionsOfObjectsDevTests : XCTestCase

@end

@implementation Foundation_UnicodifyingDescriptionsOfObjectsDevTests

- (void)testDescription {
	// This is an example of a functional test case.
  NSArray *array =
  @[@"如果你不愛我",
    @"我會讓你走",
    @"如果你真心愛我",
    @"我會讓你擁有全世界",
    @{@"真的嗎？":@"真的"}
    ];
	
	NSString *descriptionOfArray = @"[\n\t\"如果你不愛我\",\n\t\"我會讓你走\",\n\t\"如果你真心愛我\",\n\t\"我會讓你擁有全世界\",\n\t{\n\t\t\"真的嗎？\" : \"真的\"\n\t}\n]" ;
	
	// Foundation_UnicodifyingDescriptionsOfObjects should generate duplicated
	// aspect patches for the same target
	XCTAssert([[array description] isEqualToString:descriptionOfArray],
			  @"The string should be equal via aspect 'Foundation_UnicodifyingDescriptionsOfObjects'.");
}

@end
