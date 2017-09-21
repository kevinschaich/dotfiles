'use strict';
// import {commands, ExtensionContext, Position, Selection, TextEditor, TextEditorEdit, window} from 'vscode';
var vscode = require('vscode');
// Helper functions
// ================
function getNext(position, document) {
    var endOfLine = document.lineAt(position.line).range.end.character;
    if (position.character != endOfLine) {
        return new vscode.Position(position.line, position.character + 1);
    }
    if (position.line == (document.lineCount - 1)) {
        return null;
    }
    return new vscode.Position(position.line + 1, 0);
}
function getPrev(position, document) {
    if (position.character != 0) {
        return new vscode.Position(position.line, position.character - 1);
    }
    if (position.line == 0) {
        return null;
    }
    var endOfPrevLine = document.lineAt(position.line - 1).range.end.character;
    return new vscode.Position(position.line - 1, endOfPrevLine);
}
/** Returns the range deleted, if successful */
function joinLineWithNext(line, edit, document) {
    if (line >= document.lineCount - 1)
        return null;
    var matchWhitespaceAtEnd = document.lineAt(line).text.match(/\s*$/);
    var range = new vscode.Range(line, document.lineAt(line).range.end.character - matchWhitespaceAtEnd[0].length, line + 1, document.lineAt(line + 1).firstNonWhitespaceCharacterIndex);
    edit.replace(range, ' ');
    return range;
}
// Commands
// ========
function transposeCharacters(textEditor, edit) {
    var document = textEditor.document;
    textEditor.selections.forEach(function (selection) {
        var p = new vscode.Position(selection.active.line, selection.active.character);
        var nextPosition = getNext(p, document);
        if (nextPosition == null) {
            nextPosition = p;
            p = getPrev(p, document);
        }
        var prevPosition = getPrev(p, document);
        if (prevPosition == null) {
            return;
        }
        var nextSelection = new vscode.Selection(p, nextPosition);
        var nextChar = textEditor.document.getText(nextSelection);
        edit.delete(nextSelection);
        edit.insert(prevPosition, nextChar);
    });
}
function transposeSelections(textEditor, edit) {
    var selectionText = textEditor.selections.map(function (selection) {
        return textEditor.document.getText(selection);
    });
    // Transpose
    selectionText.unshift(selectionText.pop());
    for (var i = 0; i < selectionText.length; i++) {
        edit.replace(textEditor.selections[i], selectionText[i]);
    }
}
function transpose(textEditor, edit) {
    if (textEditor.selections.every(function (s) { return s.isEmpty; })) {
        transposeCharacters(textEditor, edit);
    }
    else {
        transposeSelections(textEditor, edit);
    }
}
function splitIntoLines(textEditor, edit) {
    var newSelections = [];
    for (var _i = 0, _a = textEditor.selections; _i < _a.length; _i++) {
        var selection = _a[_i];
        if (selection.isSingleLine) {
            newSelections.push(selection);
            continue;
        }
        var line = textEditor.document.lineAt(selection.start);
        newSelections.push(new vscode.Selection(selection.start, line.range.end));
        for (var lineNum = selection.start.line + 1; lineNum < selection.end.line; lineNum++) {
            line = textEditor.document.lineAt(lineNum);
            newSelections.push(new vscode.Selection(line.range.start, line.range.end));
        }
        if (selection.end.character > 0) {
            newSelections.push(new vscode.Selection(selection.end.with(undefined, 0), selection.end));
        }
    }
    textEditor.selections = newSelections;
}
function expandToLine(textEditor, edit) {
    var newSelections = [];
    for (var _i = 0, _a = textEditor.selections; _i < _a.length; _i++) {
        var selection = _a[_i];
        newSelections.push(new vscode.Selection(selection.start.with(undefined, 0), selection.end.with(selection.end.line + 1, 0)));
    }
    textEditor.selections = newSelections;
}
function joinLines(textEditor, edit) {
    var document = textEditor.document;
    var newSelections = [];
    for (var _i = 0, _a = textEditor.selections; _i < _a.length; _i++) {
        var selection = _a[_i];
        if (selection.isEmpty) {
            var range = joinLineWithNext(selection.start.line, edit, document);
            if (range) {
                newSelections.push(new vscode.Selection(range.end, range.end));
            }
            else {
                newSelections.push(selection);
            }
        }
        else {
            for (var lineNum = selection.start.line; lineNum <= selection.end.line; lineNum++) {
                joinLineWithNext(lineNum, edit, document);
            }
            newSelections.push(selection);
        }
    }
    textEditor.selections = newSelections;
}
// Activate
// ========
function activate(context) {
    var disposable = vscode.commands.registerTextEditorCommand('extension.transpose', transpose);
    context.subscriptions.push(disposable);
    var disposable2 = vscode.commands.registerTextEditorCommand('extension.splitIntoLines', splitIntoLines);
    context.subscriptions.push(disposable2);
    var disposable3 = vscode.commands.registerTextEditorCommand('extension.expandToLine', expandToLine);
    context.subscriptions.push(disposable3);
    var disposable4 = vscode.commands.registerTextEditorCommand('extension.joinLines', joinLines);
    context.subscriptions.push(disposable4);
}
exports.activate = activate;
//# sourceMappingURL=transpose.js.map