// <XAspect>
// Aspect-Foundation+UnicodifyingDescriptionsOfObjects.m
//
// Copyright (c) 2015 Xaree Lee (Kang-Yu Lee)
// Released under the MIT license (see below)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

// -----------------------------------------------------------------------------
/*
 WARNING
 =======
 This library will change the `description` and `debugDescription` of some
 collection classes to return a JSON-like output. Use this library carefully.
 */
// -----------------------------------------------------------------------------

#import "UnicodifyingDescriptionsOfObjects.h"
#import <XAspect/XAspect.h>


// =============================================================================
#pragma mark Category
// =============================================================================


@implementation NSSet (UnicodifyingDescriptionsOfObjects)

- (NSString *)xl_descriptionWithLocale:(id)locale indent:(NSUInteger)level
{
  return xl_JSON_array_description(self, locale, level);
}

@end


/*
 Force `-debugDescription` to return the same value as `-description`.
 */
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-protocol-method-implementation"
@implementation NSDictionary(DebugDescription)
- (NSString *)debugDescription
{
  return [self description];
}
@end

@implementation NSArray(DebugDescription)
- (NSString *)debugDescription
{
  return [self description];
}
@end

@implementation NSSet(DebugDescription)
- (NSString *)debugDescription
{
  return [self description];
}
@end

@implementation NSOrderedSet(DebugDescription)
- (NSString *)debugDescription
{
  return [self description];
}
@end
#pragma clang diagnostic pop


// =============================================================================
// Start aspect-oriented programming
#define AtAspect Foundation_UnicodifyingDescriptionsOfObjects
// =============================================================================

#define AtAspectOfClass NSDictionary
@classPatchField(NSDictionary)

AspectPatch(-, NSString *, descriptionWithLocale:(id)locale indent:(NSUInteger)level)
{
  return xl_JSON_object_description(self, locale, level);
}

@end
#undef AtAspectOfClass

// -----------------------------------------------------------------------------

#define AtAspectOfClass NSArray
@classPatchField(NSArray)

AspectPatch(-, NSString *, descriptionWithLocale:(id)locale indent:(NSUInteger)level)
{
  return xl_JSON_array_description(self, locale, level);
}

@end
#undef AtAspectOfClass

// -----------------------------------------------------------------------------

#define AtAspectOfClass NSOrderedSet
@classPatchField(NSOrderedSet)

AspectPatch(-, NSString *, descriptionWithLocale:(id)locale indent:(NSUInteger)level)
{
  return xl_JSON_array_description(self, locale, level);
}

@end
#undef AtAspectOfClass


// -----------------------------------------------------------------------------

#define AtAspectOfClass NSSet
@classPatchField(NSSet)

AspectPatch(-, NSString *, descriptionWithLocale:(id)locale)
{
  // Apple's NSSet didn't implement `-descriptionWithLocale:indent:`, why?
  return [self xl_descriptionWithLocale:locale indent:0];
}

@end
#undef AtAspectOfClass


// -----------------------------------------------------------------------------

#undef AtAspect