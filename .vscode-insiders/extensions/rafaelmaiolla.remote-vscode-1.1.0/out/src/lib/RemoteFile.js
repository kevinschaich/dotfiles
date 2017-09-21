"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const fs = require("fs");
const fse = require("fs-extra");
const os = require("os");
const path = require("path");
const randomString_1 = require("../utils/randomString");
const Logger_1 = require("../utils/Logger");
const L = Logger_1.default.getLogger('RemoteFile');
class RemoteFile {
    constructor() {
        this.writtenDataSize = 0;
        L.trace('constructor');
    }
    setToken(token) {
        this.token = token;
    }
    getToken() {
        L.trace('getRemoteBaseName');
        return this.token;
    }
    setDisplayName(displayName) {
        var displayNameSplit = displayName.split(':');
        if (displayNameSplit.length === 1) {
            this.remoteHost = "";
        }
        else {
            this.remoteHost = displayNameSplit.shift();
        }
        this.remoteBaseName = displayNameSplit.join(":");
    }
    getHost() {
        L.trace('getHost', this.remoteHost);
        return this.remoteHost;
    }
    getRemoteBaseName() {
        L.trace('getRemoteBaseName');
        return this.remoteBaseName;
    }
    createLocalFilePath() {
        L.trace('createLocalFilePath');
        this.localFilePath = path.join(os.tmpdir(), randomString_1.default(10), this.getRemoteBaseName());
    }
    getLocalDirectoryName() {
        L.trace('getLocalDirectoryName', path.dirname(this.localFilePath || ""));
        if (!this.localFilePath) {
            return;
        }
        return path.dirname(this.localFilePath);
    }
    createLocalDir() {
        L.trace('createLocalDir');
        fse.mkdirsSync(this.getLocalDirectoryName());
    }
    getLocalFilePath() {
        L.trace('getLocalFilePath', this.localFilePath);
        return this.localFilePath;
    }
    openSync() {
        L.trace('openSync');
        this.fd = fs.openSync(this.getLocalFilePath(), 'w');
    }
    closeSync() {
        L.trace('closeSync');
        fs.closeSync(this.fd);
        this.fd = null;
    }
    initialize() {
        L.trace('initialize');
        this.createLocalFilePath();
        this.createLocalDir();
        this.openSync();
    }
    writeSync(buffer, offset, length) {
        L.trace('writeSync');
        if (this.fd) {
            L.debug('writing data');
            fs.writeSync(this.fd, buffer, offset, length, undefined);
        }
    }
    readFileSync() {
        L.trace('readFileSync');
        return fs.readFileSync(this.localFilePath);
    }
    appendData(buffer) {
        L.trace('appendData', buffer.length);
        var length = buffer.length;
        if (this.writtenDataSize + length > this.dataSize) {
            length = this.dataSize - this.writtenDataSize;
        }
        this.writtenDataSize += length;
        L.debug("writtenDataSize", this.writtenDataSize);
        this.writeSync(buffer, 0, length);
    }
    setDataSize(dataSize) {
        L.trace('setDataSize', dataSize);
        this.dataSize = dataSize;
    }
    getDataSize() {
        L.trace('getDataSize');
        L.debug('getDataSize', this.dataSize);
        return this.dataSize;
    }
    isEmpty() {
        L.trace('isEmpty');
        L.debug('isEmpty?', this.dataSize == null);
        return this.dataSize == null;
    }
    isReady() {
        L.trace('isReady');
        L.debug('isReady?', this.writtenDataSize == this.dataSize);
        return this.writtenDataSize == this.dataSize;
    }
}
exports.default = RemoteFile;
//# sourceMappingURL=RemoteFile.js.map