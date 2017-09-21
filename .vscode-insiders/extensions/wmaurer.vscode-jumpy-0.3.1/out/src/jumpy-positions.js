"use strict";
function jumpyWord(maxDecorations, firstLineNumber, lines, regexp) {
    let positionIndex = 0;
    const positions = [];
    for (let i = 0; i < lines.length && positionIndex < maxDecorations; i++) {
        let lineText = lines[i];
        let word;
        while (!!(word = regexp.exec(lineText)) && positionIndex < maxDecorations) {
            positions.push({ line: i + firstLineNumber, character: word.index, charOffset: 2 });
        }
    }
    return positions;
}
exports.jumpyWord = jumpyWord;
function jumpyLine(maxDecorations, firstLineNumber, lines, regexp) {
    let positionIndex = 0;
    const positions = [];
    for (let i = 0; i < lines.length && positionIndex < maxDecorations; i++) {
        if (!lines[i].match(regexp)) {
            positions.push({ line: i + firstLineNumber, character: 0, charOffset: lines[i].length == 1 ? 1 : 2 });
        }
    }
    return positions;
}
exports.jumpyLine = jumpyLine;
//# sourceMappingURL=jumpy-positions.js.map