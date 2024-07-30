//
//  CompleteDictionary_tests.swift
//  
//
//  Created by Jeremy Bannister on 3/27/23.
//

///
@_exported import CompleteDictionary_module
@_exported import FoundationTestToolkit


///
final class CompleteDictionary_tests: XCTestCase {
    
    
}

///
extension CompleteDictionary_tests {
    
    ///
    func test_init_dictionaryLiteral() throws {
        
        ///
        enum Options: CaseIterable, Hashable {
            case a
            case b
            case c
        }
        
        ///
        let dict: CompleteDictionary<Options, Int> =
            [
                .a: 1,
                .b: 7,
                .c: 10
            ]
        
        ///
        try dict.assert(\.[.a], equals: 1)
        try dict.assert(\.[.b], equals: 7)
        try dict.assert(\.[.c], equals: 10)
    }
}
