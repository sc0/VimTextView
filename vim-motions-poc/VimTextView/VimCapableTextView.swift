//
//  VimCapableTextView.swift
//  vim-motions-poc
//
//  Created by Kacper Debowski on 08/04/2025.
//

import SwiftUI

class VimCapableTextView: NSTextView {
    var mode: VimMode = .Normal
    var keybinds: Keybindings = Keybindings()
    private var shouldDrawBlockCursor = true
    
    override func drawInsertionPoint(in rect: NSRect, color: NSColor, turnedOn flag: Bool) {
        if mode == .Insert {
            super.drawInsertionPoint(in: rect, color: color, turnedOn: flag)
            return
        }
        
        // Create block cursor rect (matches line height)
        let lineHeight = self.layoutManager?.defaultLineHeight(for: self.font ?? .systemFont(ofSize: 13)) ?? rect.height
        var blockRect = rect
        let glyphIndex = self.layoutManager?.glyphIndexForCharacter(at: self.selectedRange.location)
        let glyphRect = self.layoutManager?.boundingRect(forGlyphRange: NSRange(location: glyphIndex ?? 0, length: 1), in: self.textContainer!)
        
        blockRect.size.width = glyphRect!.size.width
        blockRect.size.height = lineHeight
        
        // Draw solid block cursor
        color.setFill()
        NSBezierPath(rect: blockRect).fill()
        
        if selectedRange.location < self.string.count {
            let index = self.string.index(self.string.startIndex, offsetBy: selectedRange.location)
            let character = String(self.string[index])
            
            let attributes: [NSAttributedString.Key: Any] = [
                .foregroundColor: NSColor.white, // Inverted text color
                .font: self.font ?? NSFont.systemFont(ofSize: NSFont.systemFontSize)
            ]
            
            let attributedString = NSAttributedString(string: character, attributes: attributes)
            attributedString.draw(at: NSPoint(x: blockRect.origin.x, y: blockRect.origin.y))
        }
        
    }
    
    // Prevent default cursor blink behavior
    override func updateInsertionPointStateAndRestartTimer(_ restartFlag: Bool) {
        if mode == .Insert {
            super.updateInsertionPointStateAndRestartTimer(restartFlag)
            return
        }
        
        super.updateInsertionPointStateAndRestartTimer(false) // Disable timer
        self.setNeedsDisplay(self.visibleRect)
    }
    
    // Ensure proper redraw when cursor moves
    override func setNeedsDisplay(_ rect: NSRect, avoidAdditionalLayout flag: Bool) {
        if mode == .Insert {
            super.setNeedsDisplay(rect, avoidAdditionalLayout: flag)
            return
        }
        
        var adjustedRect = rect
        
        let glyphIndex = self.layoutManager?.glyphIndexForCharacter(at: self.selectedRange.location)
        let glyphRect = self.layoutManager?.boundingRect(forGlyphRange: NSRange(location: glyphIndex ?? 0, length: 1), in: self.textContainer!)
        
        adjustedRect.size.width += glyphRect?.size.width ?? 0
        super.setNeedsDisplay(adjustedRect, avoidAdditionalLayout: flag)
    }
    
    override func keyDown(with event: NSEvent) {
        var modifiersPressed: UInt8 = 0
        if event.modifierFlags.intersection(.deviceIndependentFlagsMask).contains(.shift) {
            modifiersPressed |= KeyModifiers.shift.rawValue
        }
        if event.modifierFlags.intersection(.deviceIndependentFlagsMask).contains(.control) {
            modifiersPressed |= KeyModifiers.ctrl.rawValue
        }
        if event.modifierFlags.intersection(.deviceIndependentFlagsMask).contains(.option) {
            modifiersPressed |= KeyModifiers.option.rawValue
        }

        if keybinds.simpleKeybinds[mode]?[Keystroke(key: KeyCode(rawValue: event.keyCode)!, modifiers: modifiersPressed)] != nil {
            keybinds.simpleKeybinds[mode]?[Keystroke(key: KeyCode(rawValue: event.keyCode)!, modifiers: modifiersPressed)]!(self)
        }
        else {
            if mode == .Insert {
                super.keyDown(with: event)
            }
        }
    }
}
