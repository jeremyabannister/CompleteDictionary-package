//
//  CompleteDictionary.swift
//  
//
//  Created by Jeremy Bannister on 3/27/23.
//

/// You use CompleteDictionary with an enum as the Key, and any type you want as the value. The point of CompleteDictionary is that it guarantees that there is a value for every possible key, and therefore it returns non-optional values when subscripted.
public struct CompleteDictionary<
    Key: CaseIterable & Hashable,
    Value
>:
    ExpressionErgonomic {
    
    ///
    public private(set) var storage: [Key: Value]
    
    ///
    public init(
        initialValueGenerator: (Key)->Value
    ) {
        
        ///
        self.storage =
            Key
                .allCases
                .makeDictionary(
                    initialValueGenerator
                )
    }
    
    ///
    public init?(_ dict: [Key: Value]) {
        
        ///
        let dictContainsAllKeys = Key.allCases.allSatisfy { dict.keys.contains($0) }
        
        ///
        guard dictContainsAllKeys else { return nil }
        
        ///
        self.storage = dict
    }
}

///
extension CompleteDictionary: ExpressibleByDictionaryLiteral {
    
    ///
    public init(
        dictionaryLiteral elements: (Key, Value)...
    ) {
        
        ///
        self.init(
            elements
                .makeDictionary(key: \.0, value: \.1)
        )!
    }
}

///
extension CompleteDictionary {
    
    ///
    public subscript(key: Key) -> Value {
        get { storage[key]! }
        set { storage[key] = newValue }
    }
    
    ///
    public var keys: Dictionary<Key, Value>.Keys {
        storage.keys
    }
    
    ///
    public var values: Dictionary<Key, Value>.Values {
        storage.values
    }
    
    ///
    public func map<
        Element
    >(
        _ transform: ((key: Key, value: Value))throws->Element
    ) rethrows -> [Element] {
        
        ///
        try storage.map(transform)
    }
    
    ///
    public func forEach(
        _ body: ((key: Key, value: Value))throws->()
    ) rethrows {
        
        ///
        try storage.forEach(body)
    }
    
    ///
    public func reduce<
        Result
    >(
        into initialResult: Result,
        _ updateAccumulatingResult: (inout Result, (key: Key, value: Value))throws->()
    ) rethrows -> Result {
        
        ///
        try storage.reduce(into: initialResult, updateAccumulatingResult)
    }
}

///
extension CompleteDictionary: Codable
    where Key: Codable,
          Value: Codable {
    
    ///
    public func encode(to encoder: Encoder) throws {
        try storage.encode(to: encoder)
    }
    
    ///
    public init(from decoder: Decoder) throws {
        
        ///
        let decodedDict: [Key: Value] =
            try .init(from: decoder)
        
        ///
        let missingKeys =
            Key
                .allCases
                .asSet()
                .subtracting(
                    decodedDict
                        .keys
                        .asSet()
                )
        
        ///
        guard missingKeys.isEmpty else {
            throw "The decoded dictionary was missing values for some keys: \(missingKeys)".asErrorMessage()
        }
        
        ///
        self.storage = decodedDict
    }
}

///
extension CompleteDictionary: Hashable
    where Value: Hashable {
    
    ///
    public func hash(into hasher: inout Hasher) {
        hasher.combine(storage)
    }
}

///
extension CompleteDictionary: Equatable
    where Value: Equatable {
    
    ///
    public static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.storage == rhs.storage
    }
}
