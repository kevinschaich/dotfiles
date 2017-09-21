"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const log4js = require("log4js");
log4js.configure({
    "appenders": [
        {
            "type": "console",
            "level": "TRACE"
        }
    ]
});
exports.default = log4js;
//# sourceMappingURL=Logger.js.map