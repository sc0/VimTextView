//
//  vim_motions_pocTests.swift
//  vim-motions-pocTests
//
//  Created by Kacper Debowski on 08/04/2025.
//

import Testing
@testable import vim_motions_poc

struct vim_motions_pocTests {

    @Test func example() async throws {
        // Write your test here and use APIs like `#expect(...)` to check expected conditions.
    }
    
    @Test func parseKeybinding() async throws {
        let keys = KeyCode.parseFullKeybind("<ESC>abs")
        assert(keys.count == 4)
        assert(keys[0] == .escape)
        assert(keys[1] == .a)
        assert(keys[2] == .b)
        assert(keys[3] == .s)
        
        let keys2 = KeyCode.parseFullKeybind("j")
        assert(keys2.count == 1)
        assert(keys2[0] == .j)

    }

}
