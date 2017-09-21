"use strict";
const fs = require('fs');
const bluebird = require('bluebird');
const writeFile = bluebird.promisify(fs.writeFile);
generateIcons('dark', 'white', 'black')
    .then(() => generateIcons('light', 'black', 'white'))
    .then(() => console.log('done'));
function generateIcons(path, backgroundColor, fontColor) {
    let promises = [];
    const array = new Array(26).fill(null);
    array.forEach((_, i) => {
        const code = String.fromCharCode(97 + i);
        const promise = writeFile(`./images/${path}/${code}.svg`, getSvg(code, backgroundColor, fontColor));
        promises = [...promises, promise];
        array.forEach((_, j) => {
            const code = String.fromCharCode(97 + i) + String.fromCharCode(97 + j);
            const promise = writeFile(`./images/${path}/${code}.svg`, getSvg(code, backgroundColor, fontColor));
            promises = [...promises, promise];
        });
    });
    return bluebird.all(promises);
}
function getSvg(code, backgroundColor, fontColor) {
    const width = code.length * 7;
    return `<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 ${width} 13" height="13" width="${width}"><rect width="${width}" height="13" rx="2" ry="2" style="fill: ${backgroundColor};"></rect><text font-family="Consolas" font-size="11px" fill="${fontColor}" x="1" y="10">${code}</text></svg>`;
}
//# sourceMappingURL=icon-generation.js.map