"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
var chars = '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghiklmnopqrstuvwxyz';
function randomString(length) {
    length = length ? length : 32;
    var string = '';
    for (var i = 0; i < length; i++) {
        var randomNumber = Math.floor(Math.random() * chars.length);
        string += chars.substring(randomNumber, randomNumber + 1);
    }
    return string;
}
exports.default = randomString;
//# sourceMappingURL=randomString.js.map