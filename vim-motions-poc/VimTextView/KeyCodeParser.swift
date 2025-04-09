//
//  KeyCodeParser.swift
//  vim-motions-poc
//
//  Created by Kacper Debowski on 08/04/2025.
//

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
    
    static func parseFullKeybind(_ input: String) -> [KeyCode] {
        var keynames: [String] = []
        var result: [KeyCode] = []
        
        var idx = 0
        var specialKey = false
        
        for c in input {
            if !specialKey {
                keynames.append(String(c).lowercased())
                if c == "<" {
                    specialKey = true
                }
                else {
                    idx += 1
                }
            }
            else {
                keynames[idx] = keynames[idx] + String(c).lowercased()
                if c == ">" {
                    specialKey = false
                    idx += 1
                }
            }
        }
        
        for keyname in keynames {
            switch keyname.lowercased() {
                // Letters
                case "a": result.append(.a)
                case "b": result.append(.b)
                case "c": result.append(.c)
                case "d": result.append(.d)
                case "e": result.append(.e)
                case "f": result.append(.f)
                case "g": result.append(.g)
                case "h": result.append(.h)
                case "i": result.append(.i)
                case "j": result.append(.j)
                case "k": result.append(.k)
                case "l": result.append(.l)
                case "m": result.append(.m)
                case "n": result.append(.n)
                case "o": result.append(.o)
                case "p": result.append(.p)
                case "q": result.append(.q)
                case "r": result.append(.r)
                case "s": result.append(.s)
                case "t": result.append(.t)
                case "u": result.append(.u)
                case "v": result.append(.v)
                case "w": result.append(.w)
                case "x": result.append(.x)
                case "y": result.append(.y)
                case "z": result.append(.z)
                
                // Numbers
                case "0", "zero": result.append(.zero)
                case "1", "one": result.append(.one)
                case "2", "two": result.append(.two)
                case "3", "three": result.append(.three)
                case "4", "four": result.append(.four)
                case "5", "five": result.append(.five)
                case "6", "six": result.append(.six)
                case "7", "seven": result.append(.seven)
                case "8", "eight": result.append(.eight)
                case "9", "nine": result.append(.nine)
                
                // Symbols
                case "=", "equal": result.append(.equal)
                case "-", "minus": result.append(.minus)
                case "[", "leftbracket": result.append(.leftBracket)
                case "]", "rightbracket": result.append(.rightBracket)
                case "\\", "backslash": result.append(.backslash)
                case ";", "semicolon": result.append(.semicolon)
                case "'", "quote": result.append(.quote)
                case ",", "comma": result.append(.comma)
                case ".", "period": result.append(.period)
                case "/", "slash": result.append(.slash)
                case "`", "grave": result.append(.grave)
                
                // Function keys
                case "f1": result.append(.f1)
                case "f2": result.append(.f2)
                case "f3": result.append(.f3)
                case "f4": result.append(.f4)
                case "f5": result.append(.f5)
                case "f6": result.append(.f6)
                case "f7": result.append(.f7)
                case "f8": result.append(.f8)
                case "f9": result.append(.f9)
                case "f10": result.append(.f10)
                case "f11": result.append(.f11)
                case "f12": result.append(.f12)
                
                // Control keys (vim-compatible)
                case "<cr>", "<return>", "<enter>": result.append(.returnKey)
                case "<tab>": result.append(.tab)
                case "<space>": result.append(.space)
                case "<bs>", "<backspace>": result.append(.delete)
                case "<esc>": result.append(.escape)
                case "<cmd>", "<command>": result.append(.command)
                case "<shift>": result.append(.shift)
                case "<capslock>", "<caps>": result.append(.capsLock)
                case "<opt>", "<option>", "<alt>": result.append(.option)
                case "<ctrl>", "<control>": result.append(.control)
                case "<rshift>", "<rightshift>": result.append(.rightShift)
                case "<ropt>", "<roption>", "<ralt>", "<rightoption>": result.append(.rightOption)
                case "<rctrl>", "<rcontrol>", "<rightcontrol>": result.append(.rightControl)
                
                // Arrow keys
                case "<left>", "<leftarrow>": result.append(.leftArrow)
                case "<right>", "<rightarrow>": result.append(.rightArrow)
                case "<down>", "<downarrow>": result.append(.downArrow)
                case "<up>", "<uparrow>": result.append(.upArrow)
                
                default: fatalError("Failed to parse the key: \(keyname)")
            }
        }
        return result
    }
}
