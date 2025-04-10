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

func _getLinesMapping(_ vimTextView: VimCapableTextView) -> LineMappings {
    var lineStarts: [Int] = [0]
    let textLines = vimTextView.string.split(separator: "\n", omittingEmptySubsequences: false)

    for (index, char) in vimTextView.string.enumerated() {
        if char == "\n" {
            lineStarts.append(index+1)
        }
    }
    
    let position = _getCursorPosition(vimTextView)
    let lineIdx = (lineStarts.firstIndex(where: { $0 > position }) ?? lineStarts.count) - 1
    let positionFromStart = position - lineStarts[lineIdx]

    return LineMappings(lines: textLines.map({String($0)}), lineStarts: lineStarts, globalPosition: position, localPosition: positionFromStart, lineIdx: lineIdx)
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
    let mapping = _getLinesMapping(vimTextView)
    
    if mapping.lineIdx - 1 >= 0 {
        if mapping.lines[mapping.lineIdx-1].count > mapping.localPosition {
            _setCursorPosition(vimTextView, position: mapping.lineStarts[mapping.lineIdx - 1] + mapping.localPosition)
        } else {
            _setCursorPosition(vimTextView, position: mapping.lineStarts[mapping.lineIdx - 1] + mapping.lines[mapping.lineIdx - 1].count)
        }
    }
}

func vimMoveDown(_ vimTextView: VimCapableTextView) -> Void {
    let mapping = _getLinesMapping(vimTextView)
    
    if mapping.lineIdx + 1 < mapping.lines.count {
        if mapping.lines[mapping.lineIdx+1].count > mapping.localPosition {
            _setCursorPosition(vimTextView, position: mapping.lineStarts[mapping.lineIdx + 1] + mapping.localPosition)
        } else {
            _setCursorPosition(vimTextView, position: mapping.lineStarts[mapping.lineIdx + 1] + mapping.lines[mapping.lineIdx - 1].count)
        }
    }
}

func vimJumpToStartOfNextWord(_ vimTextView: VimCapableTextView) -> Void {
    let mapping = _getLinesMapping(vimTextView)
    let line = mapping.currentLine()
    let idx = line.index(line.startIndex, offsetBy: mapping.localPosition)
    let startOfNextWord = line[idx...].firstIndex(of: " ")
    
    var targetPosition = mapping.lineStarts[mapping.lineIdx]
    if startOfNextWord != nil {
        targetPosition += line.distance(from: line.startIndex, to: startOfNextWord!) + 1
    } else {
        if mapping.lineIdx + 1 >= mapping.lines.count {
            return
        }
        targetPosition = mapping.lineStarts[mapping.lineIdx + 1]
    }
    
    _setCursorPosition(vimTextView, position: targetPosition)
}

func vimJumpToStartOfPrevWord(_ vimTextView: VimCapableTextView) -> Void {
    let mapping = _getLinesMapping(vimTextView)
    let line = mapping.currentLine()
    
    if mapping.localPosition - 2 < 0 {
        if mapping.localPosition == 0 {
            if mapping.lineIdx - 1 >= 0 {
                let lastWordPrevLine = mapping.lines[mapping.lineIdx - 1].lastIndex(of: " ")
                if lastWordPrevLine == nil {
                    _setCursorPosition(vimTextView, position: mapping.lineStarts[mapping.lineIdx - 1])
                    return
                }
                let targetPosition = mapping.lineStarts[mapping.lineIdx - 1] + mapping.lines[mapping.lineIdx - 1].distance(from: mapping.lines[mapping.lineIdx - 1].startIndex, to: lastWordPrevLine!) + 1
                _setCursorPosition(vimTextView, position: targetPosition)
            }
            return
        } else {
            _setCursorPosition(vimTextView, position: mapping.lineStarts[mapping.lineIdx])
            return
        }
    }
    
    let idx = line.index(line.startIndex, offsetBy: mapping.localPosition-2)
    let startOfPrevWord = line[line.startIndex...idx].lastIndex(of: " ")
    
    var targetPosition = mapping.lineStarts[mapping.lineIdx]
    if startOfPrevWord != nil {
        targetPosition += line.distance(from: line.startIndex, to: startOfPrevWord!) + 1
    } else {
        if _getCursorPosition(vimTextView) > mapping.lineStarts[mapping.lineIdx] {
            targetPosition = mapping.lineStarts[mapping.lineIdx]
        }
        else if mapping.lineIdx - 1 >= 0 {
            targetPosition = mapping.lineStarts[mapping.lineIdx - 1]
        } else {
            return
        }
    }
    _setCursorPosition(vimTextView, position: targetPosition)
}

func vimShiftV(_ vimTextView: VimCapableTextView) {
   print("Shift V")
}

func vimCtrlV(_ vimTextView: VimCapableTextView) {
    print("Ctrl V")
}
