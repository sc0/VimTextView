//
//  VimTypes.swift
//  vim-motions-poc
//
//  Created by Kacper Debowski on 08/04/2025.
//

enum VimMode: String {
    case Normal = "Normal"
    case Insert = "Insert"
    case Visual = "Visual"
}

enum KeybindingType {
    case Simple
    case Complex
}

struct Keybinding {
    var mode: VimMode
    var binding: String
    var command: (VimCapableTextView) -> Void
}

struct LineMappings {
    var lines: [String]
    var lineStarts: [Int]
    var globalPosition: Int
    var localPosition: Int
    var lineIdx: Int
    
    func currentLine() -> String {
        return lines[lineIdx]
    }
}
