"use strict";
const vscode = require('vscode');
const plusMinusLines = 60;
const numCharCodes = 26;
function createCodeArray() {
    const codeArray = new Array(numCharCodes * numCharCodes);
    let codeIndex = 0;
    for (let i = 0; i < numCharCodes; i++) {
        for (let j = 0; j < numCharCodes; j++) {
            codeArray[codeIndex++] = String.fromCharCode(97 + i) + String.fromCharCode(97 + j);
        }
    }
    return codeArray;
}
exports.createCodeArray = createCodeArray;
let darkDataUriCache = {};
let lightDataUriCache = {};
function createDataUriCaches(codeArray) {
    codeArray.forEach(code => darkDataUriCache[code] = getSvgDataUri(code, 'white', 'black'));
    codeArray.forEach(code => lightDataUriCache[code] = getSvgDataUri(code, 'black', 'white'));
}
exports.createDataUriCaches = createDataUriCaches;
function getCodeIndex(code) {
    return (code.charCodeAt(0) - 97) * numCharCodes + code.charCodeAt(1) - 97;
}
exports.getCodeIndex = getCodeIndex;
function getLines(editor) {
    const document = editor.document;
    const activePosition = editor.selection.active;
    const startLine = activePosition.line < plusMinusLines ? 0 : activePosition.line - plusMinusLines;
    const endLine = (document.lineCount - activePosition.line) < plusMinusLines ? document.lineCount : activePosition.line + plusMinusLines;
    const lines = [];
    for (let i = startLine; i < endLine; i++) {
        lines.push(document.lineAt(i).text);
    }
    return {
        firstLineNumber: startLine,
        lines
    };
}
exports.getLines = getLines;
function createTextEditorDecorationType(charsToOffset) {
    return vscode.window.createTextEditorDecorationType({
        after: {
            margin: `0 0 0 ${charsToOffset * -7}px`,
            height: '13px',
            width: '14px'
        }
    });
}
exports.createTextEditorDecorationType = createTextEditorDecorationType;
function createDecorationOptions(line, startCharacter, endCharacter, context, code) {
    return {
        range: new vscode.Range(line, startCharacter, line, endCharacter),
        renderOptions: {
            dark: {
                after: {
                    contentIconPath: darkDataUriCache[code]
                }
            },
            light: {
                after: {
                    contentIconPath: lightDataUriCache[code]
                }
            }
        }
    };
}
exports.createDecorationOptions = createDecorationOptions;
function getSvgDataUri(code, backgroundColor, fontColor) {
    const width = code.length * 7;
    return vscode.Uri.parse(`data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 ${width} 13" height="13" width="${width}"><rect width="${width}" height="13" rx="2" ry="2" style="fill: ${backgroundColor};"></rect><text font-family="Consolas" font-size="11px" fill="${fontColor}" x="1" y="10">${code}</text></svg>`);
}
//# sourceMappingURL=jumpy-vscode.js.map