//
//  KeyCodeParser.swift
//  vim-motions-poc
//
//  Created by Kacper Debowski on 08/04/2025.
//
import AppKit

enum KeyModifiers: UInt8 {
    case none = 0
    case shift = 1
    case ctrl = 2
    case option = 4
}

struct Keystroke: Hashable {
    var key: KeyCode
    var modifiers: UInt8
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(key)
        hasher.combine(modifiers)
    }
    
    static func == (lhs: Keystroke, rhs: Keystroke) -> Bool {
       lhs.key == rhs.key && lhs.modifiers == rhs.modifiers
    }
    
    static func parse(_ input: String) -> Keystroke {
        var keyname: String = input

        if keyname.count > 1 && (keyname.first != "<" || keyname.last != ">") {
            fatalError("Incorrect keystroke format: \(input)")
        }
        
        var modifier: UInt8 = KeyModifiers.none.rawValue
        
        var split = keyname.split(separator: "-")
        if split.count == 0 {
            keyname = "-"
        }
        if split.count == 1 {
            keyname = input
        }
        if split.count > 1 {
            for i in 0..<(split.count - 1) {
                split[i].removeAll(where: {$0 == "<"})
                switch split[i].lowercased() {
                case "s": modifier |= KeyModifiers.shift.rawValue
                case "c": modifier |= KeyModifiers.ctrl.rawValue
                case "m": modifier |= KeyModifiers.option.rawValue
                default:
                    fatalError("Incorrect modifier: \(split[i]) in keybinding \(keyname)")
                }
            }
            split[split.count - 1].removeLast()
            keyname = split[split.count - 1].count == 0 ? "-" : String(split[split.count - 1])
        }
        
        switch keyname.lowercased() {
            // Letters
        case "a": return Keystroke(key: .a, modifiers: modifier)
        case "b": return Keystroke(key: .b, modifiers: modifier)
        case "c": return Keystroke(key: .c, modifiers: modifier)
        case "d": return Keystroke(key: .d, modifiers: modifier)
        case "e": return Keystroke(key: .e, modifiers: modifier)
        case "f": return Keystroke(key: .f, modifiers: modifier)
        case "g": return Keystroke(key: .g, modifiers: modifier)
        case "h": return Keystroke(key: .h, modifiers: modifier)
        case "i": return Keystroke(key: .i, modifiers: modifier)
        case "j": return Keystroke(key: .j, modifiers: modifier)
        case "k": return Keystroke(key: .k, modifiers: modifier)
        case "l": return Keystroke(key: .l, modifiers: modifier)
        case "m": return Keystroke(key: .m, modifiers: modifier)
        case "n": return Keystroke(key: .n, modifiers: modifier)
        case "o": return Keystroke(key: .o, modifiers: modifier)
        case "p": return Keystroke(key: .p, modifiers: modifier)
        case "q": return Keystroke(key: .q, modifiers: modifier)
        case "r": return Keystroke(key: .r, modifiers: modifier)
        case "s": return Keystroke(key: .s, modifiers: modifier)
        case "t": return Keystroke(key: .t, modifiers: modifier)
        case "u": return Keystroke(key: .u, modifiers: modifier)
        case "v": return Keystroke(key: .v, modifiers: modifier)
        case "w": return Keystroke(key: .w, modifiers: modifier)
        case "x": return Keystroke(key: .x, modifiers: modifier)
        case "y": return Keystroke(key: .y, modifiers: modifier)
        case "z": return Keystroke(key: .z, modifiers: modifier)
            
            // Numbers
        case "0", "zero": return Keystroke(key: .zero, modifiers: modifier)
        case "1", "one": return Keystroke(key: .one, modifiers: modifier)
        case "2", "two": return Keystroke(key: .two, modifiers: modifier)
        case "3", "three": return Keystroke(key: .three, modifiers: modifier)
        case "4", "four": return Keystroke(key: .four, modifiers: modifier)
        case "5", "five": return Keystroke(key: .five, modifiers: modifier)
        case "6", "six": return Keystroke(key: .six, modifiers: modifier)
        case "7", "seven": return Keystroke(key: .seven, modifiers: modifier)
        case "8", "eight": return Keystroke(key: .eight, modifiers: modifier)
        case "9", "nine": return Keystroke(key: .nine, modifiers: modifier)
            
            // Symbols
        case "=", "equal": return Keystroke(key: .equal, modifiers: modifier)
        case "-", "minus": return Keystroke(key: .minus, modifiers: modifier)
        case "[", "leftbracket": return Keystroke(key: .leftBracket, modifiers: modifier)
        case "]", "rightbracket": return Keystroke(key: .rightBracket, modifiers: modifier)
        case "\\", "backslash": return Keystroke(key: .backslash, modifiers: modifier)
        case ";", "semicolon": return Keystroke(key: .semicolon, modifiers: modifier)
        case "'", "quote": return Keystroke(key: .quote, modifiers: modifier)
        case ",", "comma": return Keystroke(key: .comma, modifiers: modifier)
        case ".", "period": return Keystroke(key: .period, modifiers: modifier)
        case "/", "slash": return Keystroke(key: .slash, modifiers: modifier)
        case "`", "grave": return Keystroke(key: .grave, modifiers: modifier)
            
            // Function keys
        case "f1": return Keystroke(key: .f1, modifiers: modifier)
        case "f2": return Keystroke(key: .f2, modifiers: modifier)
        case "f3": return Keystroke(key: .f3, modifiers: modifier)
        case "f4": return Keystroke(key: .f4, modifiers: modifier)
        case "f5": return Keystroke(key: .f5, modifiers: modifier)
        case "f6": return Keystroke(key: .f6, modifiers: modifier)
        case "f7": return Keystroke(key: .f7, modifiers: modifier)
        case "f8": return Keystroke(key: .f8, modifiers: modifier)
        case "f9": return Keystroke(key: .f9, modifiers: modifier)
        case "f10": return Keystroke(key: .f10, modifiers: modifier)
        case "f11": return Keystroke(key: .f11, modifiers: modifier)
        case "f12": return Keystroke(key: .f12, modifiers: modifier)
            
            // Control keys (vim-compatible)
        case "<cr>", "<return>", "<enter>": return Keystroke(key: .returnKey, modifiers: modifier)
        case "<tab>": return Keystroke(key: .tab, modifiers: modifier)
        case "<space>": return Keystroke(key: .space, modifiers: modifier)
        case "<bs>", "<backspace>": return Keystroke(key: .delete, modifiers: modifier)
        case "<esc>": return Keystroke(key: .escape, modifiers: modifier)
        case "<cmd>", "<command>": return Keystroke(key: .command, modifiers: modifier)
        case "<shift>": return Keystroke(key: .shift, modifiers: modifier)
        case "<capslock>", "<caps>": return Keystroke(key: .capsLock, modifiers: modifier)
        case "<opt>", "<option>", "<alt>": return Keystroke(key: .option, modifiers: modifier)
        case "<ctrl>", "<control>": return Keystroke(key: .control, modifiers: modifier)
        case "<rshift>", "<rightshift>": return Keystroke(key: .rightShift, modifiers: modifier)
        case "<ropt>", "<roption>", "<ralt>", "<rightoption>": return Keystroke(key: .rightOption, modifiers: modifier)
        case "<rctrl>", "<rcontrol>", "<rightcontrol>": return Keystroke(key: .rightControl, modifiers: modifier)
            
            // Arrow keys
        case "<left>", "<leftarrow>": return Keystroke(key: .leftArrow, modifiers: modifier)
        case "<right>", "<rightarrow>": return Keystroke(key: .rightArrow, modifiers: modifier)
        case "<down>", "<downarrow>": return Keystroke(key: .downArrow, modifiers: modifier)
        case "<up>", "<uparrow>": return Keystroke(key: .upArrow, modifiers: modifier)

        default: fatalError("Failed to parse the key: \(keyname)")
        }
    }
}

enum KeyCode: UInt16 {
    case a = 0
    case s = 1
    case d = 2
    case f = 3
    case h = 4
    case g = 5
    case z = 6
    case x = 7
    case c = 8
    case v = 9
    // Add other keys as needed
    case b = 11
    case q = 12
    case w = 13
    case e = 14
    case r = 15
    case y = 16
    case t = 17
    case one = 18
    case two = 19
    case three = 20
    case four = 21
    case six = 22
    case five = 23
    case equal = 24
    case nine = 25
    case seven = 26
    case minus = 27
    case eight = 28
    case zero = 29
    case rightBracket = 30
    case o = 31
    case u = 32
    case leftBracket = 33
    case i = 34
    case p = 35
    case l = 37
    case j = 38
    case quote = 39
    case k = 40
    case semicolon = 41
    case backslash = 42
    case comma = 43
    case slash = 44
    case n = 45
    case m = 46
    case period = 47
    case grave = 50
    // Function keys
    case f1 = 122
    case f2 = 120
    case f3 = 99
    case f4 = 118
    case f5 = 96
    case f6 = 97
    case f7 = 98
    case f8 = 100
    case f9 = 101
    case f10 = 109
    case f11 = 103
    case f12 = 111
    // Control keys
    case returnKey = 36
    case tab = 48
    case space = 49
    case delete = 51
    case escape = 53
    case command = 55
    case shift = 56
    case capsLock = 57
    case option = 58
    case control = 59
    case rightShift = 60
    case rightOption = 61
    case rightControl = 62
    // Arrow keys
    case leftArrow = 123
    case rightArrow = 124
    case downArrow = 125
    case upArrow = 126
    
}
