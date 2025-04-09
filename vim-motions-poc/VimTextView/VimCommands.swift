//
//  VimCommands.swift
//  vim-motions-poc
//
//  Created by Kacper Debowski on 08/04/2025.
//
import AppKit

func _getCursorPosition(_ vimTextView: VimCapableTextView) -> Int {
    let range = vimTextView.selectedRange()
    return range.location
}

func _setCursorPosition(_ vimTextView: VimCapableTextView, position: Int) {
    let range = NSRange(location: position, length: 0)
    vimTextView.setSelectedRange(range)
}


func vimEnterNormalMode(_ vimTextView: VimCapableTextView) -> Void {
    vimTextView.mode = .Normal
    vimTextView.delegate?.textDidChange?(Notification(name: NSNotification.Name("enterNormalMode"), object: vimTextView))
}

func vimEnterInsertMode(_ vimTextView: VimCapableTextView) -> Void {
    vimTextView.mode = .Insert
    vimTextView.delegate?.textDidChange?(Notification(name: NSNotification.Name("enterInsertMode"), object: vimTextView))
}

func vimEnterInsertModeAfterCursor(_ vimTextView: VimCapableTextView) -> Void {
    vimMoveRight(vimTextView)
    vimEnterInsertMode(vimTextView)
}

func vimMoveLeft(_ vimTextView: VimCapableTextView) -> Void {
    let position = _getCursorPosition(vimTextView)
    if position > 0 {
        _setCursorPosition(vimTextView, position: position - 1)
    }
}

func vimMoveRight(_ vimTextView: VimCapableTextView) -> Void {
    let position = _getCursorPosition(vimTextView)
    if position < vimTextView.string.count - 1 {
        _setCursorPosition(vimTextView, position: position + 1)
    }
}

func vimMoveUp(_ vimTextView: VimCapableTextView) -> Void {
    var lineStarts: [Int] = [0]
    let textLines = vimTextView.string.split(separator: "\n", omittingEmptySubsequences: false)

    for (index, char) in vimTextView.string.enumerated() {
        if char == "\n" {
            lineStarts.append(index+1)
        }
    }
    let position = _getCursorPosition(vimTextView)
    let lineIdx = (lineStarts.firstIndex(where: { $0 > position }) ?? lineStarts.count) - 1

    print("Current line: \(lineIdx) (\(textLines[lineIdx]))")
    
    let positionFromStart = position - lineStarts[lineIdx]
    if lineIdx - 1 >= 0 {
        if textLines[lineIdx-1].count > positionFromStart {
            _setCursorPosition(vimTextView, position: lineStarts[lineIdx - 1] + positionFromStart)
        } else {
            _setCursorPosition(vimTextView, position: lineStarts[lineIdx - 1] + textLines[lineIdx - 1].count)
        }
    }
}

func vimMoveDown(_ vimTextView: VimCapableTextView) -> Void {
    var lineStarts: [Int] = [0]
    let textLines = vimTextView.string.split(separator: "\n", omittingEmptySubsequences: false)

    for (index, char) in vimTextView.string.enumerated() {
        if char == "\n" {
            lineStarts.append(index+1)
        }
    }
    let position = _getCursorPosition(vimTextView)
    let lineIdx = (lineStarts.firstIndex(where: { $0 > position }) ?? lineStarts.count) - 1

    print("Current line: \(lineIdx) (\(textLines[lineIdx]))")
    
    let positionFromStart = position - lineStarts[lineIdx]
    if lineIdx + 1 < textLines.count {
        if textLines[lineIdx+1].count > positionFromStart {
            _setCursorPosition(vimTextView, position: lineStarts[lineIdx + 1] + positionFromStart)
        } else {
            _setCursorPosition(vimTextView, position: lineStarts[lineIdx + 1] + textLines[lineIdx + 1].count)
        }
    }
}
