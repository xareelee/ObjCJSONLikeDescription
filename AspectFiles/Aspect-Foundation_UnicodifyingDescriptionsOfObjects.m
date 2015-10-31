// <XAspect>
// Aspect-Foundation_UnicodifyingDescriptionsOfObjects.m
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

#import <Foundation/Foundation.h>
#import <XAspect/XAspect.h>


// -----------------------------------------------------------------------------
// Macros
// -----------------------------------------------------------------------------
// We use a tabulator for every one identation level by default. If you want to
// change the identation, you should define the keyword `INDT_FOR_DESCRIPTION`
// in your project's .pch file.
#ifdef INDT_FOR_DESCRIPTION
# define INDT INDT_FOR_DESCRIPTION
#else
# define INDT @"\t"
#endif


// -----------------------------------------------------------------------------
// Interface
// -----------------------------------------------------------------------------

// Make NSSet support description with a indent level.
@interface NSSet (UnicodifyingDescriptionsOfObjects)
- (NSString *)xl_descriptionWithLocale:(id)locale indent:(NSUInteger)level;
@end


// -----------------------------------------------------------------------------
// Indentation for levels
// -----------------------------------------------------------------------------
static NSString *_indentationForLevels(NSUInteger level)
{
  switch (level) {
    case  0: return @"";
    case  1: return INDT;
    case  2: return INDT INDT;
    case  3: return INDT INDT INDT;
    case  4: return INDT INDT INDT INDT;
    case  5: return INDT INDT INDT INDT INDT;
    case  6: return INDT INDT INDT INDT INDT INDT;
    case  7: return INDT INDT INDT INDT INDT INDT INDT;
    case  8: return INDT INDT INDT INDT INDT INDT INDT INDT;
    case  9: return INDT INDT INDT INDT INDT INDT INDT INDT INDT;
    case 10: return INDT INDT INDT INDT INDT INDT INDT INDT INDT INDT;
    case 11: return INDT INDT INDT INDT INDT INDT INDT INDT INDT INDT INDT;
    case 12: return INDT INDT INDT INDT INDT INDT INDT INDT INDT INDT INDT INDT;
    case 13: return INDT INDT INDT INDT INDT INDT INDT INDT INDT INDT INDT INDT INDT;
    case 14: return INDT INDT INDT INDT INDT INDT INDT INDT INDT INDT INDT INDT INDT INDT;
    case 15: return INDT INDT INDT INDT INDT INDT INDT INDT INDT INDT INDT INDT INDT INDT INDT;
    case 16: return INDT INDT INDT INDT INDT INDT INDT INDT INDT INDT INDT INDT INDT INDT INDT INDT;
    case 17: return INDT INDT INDT INDT INDT INDT INDT INDT INDT INDT INDT INDT INDT INDT INDT INDT INDT;
    case 18: return INDT INDT INDT INDT INDT INDT INDT INDT INDT INDT INDT INDT INDT INDT INDT INDT INDT INDT;
    case 19: return INDT INDT INDT INDT INDT INDT INDT INDT INDT INDT INDT INDT INDT INDT INDT INDT INDT INDT INDT;
    case 20: return INDT INDT INDT INDT INDT INDT INDT INDT INDT INDT INDT INDT INDT INDT INDT INDT INDT INDT INDT INDT;
    default:
      return [_indentationForLevels(20) stringByAppendingString:_indentationForLevels(level-20)];
  }
}

NSString *xl_descrtionForKey(id obj)
{
  if ([obj isKindOfClass:[NSString class]]) {
    return [NSString stringWithFormat:@"\"%@\"", obj];
  } else if ([obj isKindOfClass:NSClassFromString(@"__NSCFBoolean")]) {
    return ([obj boolValue]) ? @"true" : @"false";
  } else if ([obj isKindOfClass:[NSNumber class]]) {
    return [obj description];
  } else if ([obj isKindOfClass:[NSNull class]]) {
    return @"null";
  }
  return [NSString stringWithFormat:@"<%@: %p>", NSStringFromClass([obj class]), obj];
}

NSString *xl_descrtionForValue(id obj, id locale, NSUInteger level)
{
  if ([obj isKindOfClass:[NSString class]]) {
    return [NSString stringWithFormat:@"\"%@\"", obj];
  } else if ([obj respondsToSelector:@selector(xl_descriptionWithLocale:indent:)]) {
    return [obj xl_descriptionWithLocale:locale indent:level];
  } else if ([obj respondsToSelector:@selector(descriptionWithLocale:indent:)]) {
    return [obj descriptionWithLocale:locale indent:level];
  } else if ([obj isKindOfClass:[NSNull class]]) {
    return @"null"; // JSON null value
  }
  return [obj description];
}

NSString *xl_collectionDescription(id collection, NSString *openCollection, NSString *closeCollection, NSString *separator, NSUInteger level, NSString *(^elementDescriptionMapper)(id collection, id element, NSUInteger elementLevel))
{
  if (![collection respondsToSelector:@selector(count)] ||
      [collection count] == 0) {
    return [NSString stringWithFormat:@"%@%@", openCollection, closeCollection];
  }
  
  NSUInteger elementLevel = level + 1;
  NSString *elementIndentation = _indentationForLevels(elementLevel);
  NSMutableArray *components   = [NSMutableArray arrayWithCapacity:[collection count]];
  for (id element in collection) {
    [components addObject:[NSString stringWithFormat:@"\n%@%@", elementIndentation, elementDescriptionMapper(collection, element, elementLevel)]];
  }
  
  return [NSString stringWithFormat:@"%@%@\n%@%@", openCollection, [components componentsJoinedByString:separator], _indentationForLevels(level), closeCollection];
}

NSString *xl_JSON_array_description(id collection, id locale, NSUInteger level)
{
  NSCAssert([collection conformsToProtocol:@protocol(NSFastEnumeration)], @"Class `%@` should conform to protocol NSFastEnumeration for a list collection.", NSStringFromClass([collection class]));
  return xl_collectionDescription(collection, @"[", @"]", @",", level, ^NSString *(NSArray *array, NSString *element, NSUInteger elementLevel) {
    return xl_descrtionForValue(element, locale, elementLevel);
  });
}

NSString *xl_JSON_object_description(id collection, id locale, NSUInteger level)
{
  NSCAssert([collection conformsToProtocol:@protocol(NSFastEnumeration)], @"Class `%@` should conform to protocol NSFastEnumeration for a list collection.", NSStringFromClass([collection class]));
  NSCAssert([collection respondsToSelector:@selector(objectForKeyedSubscript:)], @"Class `%@` should implement `-objectForKeyedSubscript:` for a key-value collection.", NSStringFromClass([collection class]));
  return xl_collectionDescription(collection, @"{", @"}", @",", level, ^NSString *(id dict, NSString *element, NSUInteger elementLevel) {
    return [NSString stringWithFormat:@"%@ : %@", xl_descrtionForKey(element), xl_descrtionForValue(dict[element], locale, elementLevel)];
  });
}



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