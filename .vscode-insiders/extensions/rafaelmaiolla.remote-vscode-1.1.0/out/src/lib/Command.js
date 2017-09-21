"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const Logger_1 = require("../utils/Logger");
const L = Logger_1.default.getLogger('Command');
class Command {
    constructor(name) {
        L.trace('constructor', name);
        this.variables = new Map();
        this.setName(name);
    }
    setName(name) {
        L.trace('setName', name);
        this.name = name;
    }
    getName() {
        L.trace('getName');
        return this.name;
    }
    addVariable(key, value) {
        L.trace('addVariable', key, value);
        this.variables.set(key, value);
    }
    getVariable(key) {
        L.trace('getVariable', key);
        return this.variables.get(key);
    }
}
exports.default = Command;
//# sourceMappingURL=Command.js.map