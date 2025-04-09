//
//  Keybinds.swift
//  vim-motions-poc
//
//  Created by Kacper Debowski on 08/04/2025.
//
class Keybindings {
    var keybinds: [VimMode: [KeybindingType: [KeyCode: (VimCapableTextView) -> Void]]] = [:]
    
    func add(keybind: Keybinding) {
        let parsedKeybind = KeyCode.parseFullKeybind(keybind.binding)
        let type: KeybindingType = parsedKeybind.count > 1 ? .Complex : .Simple
        
        if type == .Complex {
           fatalError("Unsupported: complex keybinds")
        }
        keybinds[keybind.mode, default: [:]][type, default: [:]][parsedKeybind[0]] = keybind.command
    }
}

func setupDefaultKeybindings(_ keybindings: inout Keybindings) {
    keybindings.add(keybind: Keybinding(mode: VimMode.Insert, binding: "<ESC>", command: vimEnterNormalMode))
    
    keybindings.add(keybind: Keybinding(mode: VimMode.Normal, binding: "i", command: vimEnterInsertMode))
    keybindings.add(keybind: Keybinding(mode: VimMode.Normal, binding: "a", command: vimEnterInsertModeAfterCursor))

    keybindings.add(keybind: Keybinding(mode: VimMode.Normal, binding: "h", command: vimMoveLeft))
    keybindings.add(keybind: Keybinding(mode: VimMode.Normal, binding: "l", command: vimMoveRight))
    keybindings.add(keybind: Keybinding(mode: VimMode.Normal, binding: "j", command: vimMoveDown))
    keybindings.add(keybind: Keybinding(mode: VimMode.Normal, binding: "k", command: vimMoveUp))
    
    keybindings.add(keybind: Keybinding(mode: VimMode.Normal, binding: "w", command: vimJumpToStartOfNextWord))
    keybindings.add(keybind: Keybinding(mode: VimMode.Normal, binding: "b", command: vimJumpToStartOfPrevWord))
}
