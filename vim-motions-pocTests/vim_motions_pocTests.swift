//
//  vim_motions_pocTests.swift
//  vim-motions-pocTests
//
//  Created by Kacper Debowski on 08/04/2025.
//

import Testing
@testable import vim_motions_poc

struct vim_motions_pocTests {
    @Test func parseKeystroke() async throws {
        var k = Keystroke.parse("a")
        assert(k.key == .a && k.modifiers == KeyModifiers.none.rawValue, "Single key not parsed correctly")
        
        k = Keystroke.parse("<c-a>")
        assert(k.key == .a && k.modifiers == KeyModifiers.ctrl.rawValue, "<c-a> key not parsed correctly")
        
        k = Keystroke.parse("<c-S-a>")
        assert(k.key == .a && k.modifiers == KeyModifiers.ctrl.rawValue | KeyModifiers.shift.rawValue, "<c-S-a> key not parsed correctly")
        
        k = Keystroke.parse("-")
        assert(k.key == .minus && k.modifiers == KeyModifiers.none.rawValue, "minus key not parsed correctly")
        
        k = Keystroke.parse("<C-->")
        assert(k.key == .minus && k.modifiers == KeyModifiers.ctrl.rawValue, "<C--> key not parsed correctly")
    }

}
