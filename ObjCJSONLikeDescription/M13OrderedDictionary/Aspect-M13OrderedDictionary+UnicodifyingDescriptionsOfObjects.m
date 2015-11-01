// <XAspect>
// Aspect-M13OrderedDictionary+UnicodifyingDescriptionsOfObjects.m
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
#import "M13OrderedDictionary.h"


// =============================================================================
#pragma mark Category
// =============================================================================

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-protocol-method-implementation"
@implementation M13OrderedDictionary (ObjCJSONLikeDescription)

- (NSString *)debugDescription
{
  // For method swizzling with XAspect. This implementation will not be triggered.
  return [self description];
}

@end
#pragma clang diagnostic pop


// =============================================================================
// Start aspect-oriented programming
#define AtAspect ObjCJSONLikeDescription
// =============================================================================

#define AtAspectOfClass M13OrderedDictionary
@classPatchField(M13OrderedDictionary)


AspectPatch(-, NSString *, debugDescription)
{
  return [self description];
}

AspectPatch(-, NSString *, description)
{
  return [self descriptionWithLocale:[NSLocale systemLocale]];
}

AspectPatch(-, NSString *, descriptionWithLocale:(id)locale)
{
  return [self descriptionWithLocale:locale indent:0];
}

AspectPatch(-, NSString *, descriptionWithLocale:(id)locale indent:(NSUInteger)level)
{
  return xl_JSON_object_description(self, locale, level);
}

@end
#undef AtAspectOfClass

