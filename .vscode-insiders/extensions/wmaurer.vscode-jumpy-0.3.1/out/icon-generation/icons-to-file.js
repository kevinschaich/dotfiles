"use strict";
const fs = require('fs');
const bluebird = require('bluebird');
const readFile = bluebird.promisify(fs.readFile);
const writeFile = bluebird.promisify(fs.writeFile);
readFile('./icon-generation/icons.json')
    .then(data => {
    const iconsSource = JSON.parse(data.toString());
    const strip = s => s.replace(/^data:image\/jpeg;base64,/, '');
    const darkPromises = iconsSource.dark.map(x => writeFile(`./icon-generation/dark/${x.code}.jpg`, strip(x.jpegEncoded), 'base64'));
    const lightPromises = iconsSource.light.map(x => writeFile(`./icon-generation/light/${x.code}.jpg`, strip(x.jpegEncoded), 'base64'));
    return Promise.all([...darkPromises, ...lightPromises]);
})
    .then(() => {
    console.log('done');
});
//# sourceMappingURL=icons-to-file.js.map