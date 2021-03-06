// UNSUPPORTED: CPU=i386 && OS=ios
// UNSUPPORTED: CPU=armv7 && OS=ios
// UNSUPPORTED: CPU=armv7s && OS=ios
// UNSUPPORTED: CPU=armv7k && OS=ios
// Exclude iOS-based 32-bit platforms because the Foundation overlays introduce
// an extra dependency on _KeyValueCodingAndObservingPublishing only for 64-bit
// platforms.
// REQUIRES: objc_interop

// RUN: %empty-directory(%t)
// RUN: %{python} %S/../gen-output-file-map.py -o %t %S
// RUN: cd %t && %target-swiftc_driver -typecheck -output-file-map %t/output.json -incremental -module-name main -enable-direct-intramodule-dependencies -verify-incremental-dependencies %s

import Foundation

// expected-provides {{LookupFactory}}
// expected-provides {{NSObject}}
// expected-private-superclass {{ObjectiveC.NSObject}}
// expected-private-conformance {{ObjectiveC.NSObjectProtocol}}
// expected-private-conformance {{Foundation._KeyValueCodingAndObserving}}
// expected-private-conformance {{Foundation._KeyValueCodingAndObservingPublishing}}
// expected-private-conformance {{Swift.Hashable}}
// expected-private-conformance {{Swift.Equatable}}
// expected-private-conformance {{Swift.CustomDebugStringConvertible}}
// expected-private-conformance {{Swift.CVarArg}}
// expected-private-conformance {{Swift.CustomStringConvertible}}
// expected-private-member {{Swift._ExpressibleByBuiltinIntegerLiteral.init}}
// expected-private-superclass {{main.LookupFactory}}
@objc private class LookupFactory: NSObject {
  // expected-provides {{AssignmentPrecedence}}
  // expected-provides {{IntegerLiteralType}}
  // expected-provides {{FloatLiteralType}}
  // expected-provides {{Int}}
  // expected-private-member {{ObjectiveC.NSObject.someMember}}
  // expected-private-member {{ObjectiveC.NSObject.Int}}
  // expected-private-member {{ObjectiveC.NSObjectProtocol.someMember}}
  // expected-private-member {{ObjectiveC.NSObjectProtocol.Int}}
  // expected-private-member {{main.LookupFactory.Int}}
  @objc var someMember: Int = 0
  // expected-private-member {{ObjectiveC.NSObject.someMethod}}
  // expected-private-member {{ObjectiveC.NSObjectProtocol.someMethod}}
  @objc func someMethod() {}

  // expected-private-member {{ObjectiveC.NSObject.init}}
  // expected-private-member {{ObjectiveC.NSObjectProtocol.init}}
  // expected-private-member {{main.LookupFactory.init}}
  // expected-private-member {{main.LookupFactory.deinit}}
  // expected-private-member {{main.LookupFactory.someMember}}
  // expected-private-member {{main.LookupFactory.someMethod}}
}

// expected-private-member {{Swift.ExpressibleByNilLiteral.callAsFunction}}
// expected-private-member {{Swift.CustomReflectable.callAsFunction}}
// expected-private-member {{Swift._ObjectiveCBridgeable.callAsFunction}}
// expected-private-member {{Swift.Optional<Wrapped>.callAsFunction}}
// expected-private-member {{Swift.CustomDebugStringConvertible.callAsFunction}}
// expected-private-member {{Swift.Equatable.callAsFunction}}
// expected-private-member {{Swift.Hashable.callAsFunction}}
// expected-private-member {{Swift.Encodable.callAsFunction}}
// expected-private-member {{Swift.Decodable.callAsFunction}}
// expected-private-member {{Foundation._OptionalForKVO.callAsFunction}}

// expected-provides {{AnyObject}}
func lookupOnAnyObject(object: AnyObject) { // expected-provides {{lookupOnAnyObject}}
  _ = object.someMember // expected-private-dynamic-member {{someMember}}
  object.someMethod() // expected-private-dynamic-member {{someMethod}}
}

// expected-private-member {{Swift.Hashable.someMethod}}
// expected-private-member {{Foundation._KeyValueCodingAndObserving.someMethod}}
// expected-private-member {{Foundation._KeyValueCodingAndObservingPublishing.someMethod}}
// expected-private-member {{Swift.Equatable.someMethod}}
// expected-private-member {{Swift.CVarArg.someMethod}}
// expected-private-member {{Swift.CustomStringConvertible.someMethod}}
// expected-private-member {{Swift.CustomDebugStringConvertible.someMethod}}
