"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const events_1 = require("events");
const vscode = require("vscode");
const Logger_1 = require("../utils/Logger");
const Command_1 = require("./Command");
const RemoteFile_1 = require("./RemoteFile");
const L = Logger_1.default.getLogger('Session');
class Session extends events_1.EventEmitter {
    constructor(socket) {
        super();
        this.subscriptions = [];
        this.attempts = 0;
        L.trace('constructor');
        this.socket = socket;
        this.online = true;
        this.socket.on('data', this.onSocketData.bind(this));
        this.socket.on('close', this.onSocketClose.bind(this));
    }
    onSocketData(chunk) {
        L.trace('onSocketData', chunk);
        if (chunk) {
            this.parseChunk(chunk);
        }
    }
    onSocketClose() {
        L.trace('onSocketClose');
        this.online = false;
    }
    parseChunk(buffer) {
        L.trace('parseChunk', buffer);
        if (this.command && this.remoteFile.isReady()) {
            return;
        }
        var chunk = buffer.toString("utf8");
        var lines = chunk.split("\n");
        if (!this.command) {
            this.command = new Command_1.default(lines.shift());
            this.remoteFile = new RemoteFile_1.default();
        }
        if (this.remoteFile.isEmpty()) {
            while (lines.length) {
                var line = lines.shift().trim();
                if (!line) {
                    break;
                }
                var s = line.split(':');
                var name = s.shift().trim();
                var value = s.join(":").trim();
                if (name == 'data') {
                    this.remoteFile.setDataSize(parseInt(value, 10));
                    this.remoteFile.setToken(this.command.getVariable('token'));
                    this.remoteFile.setDisplayName(this.command.getVariable('display-name'));
                    this.remoteFile.initialize();
                    this.remoteFile.appendData(buffer.slice(buffer.indexOf(line) + Buffer.byteLength(`${line}\n`)));
                    break;
                }
                else {
                    this.command.addVariable(name, value);
                }
            }
        }
        else {
            this.remoteFile.appendData(buffer);
        }
        if (this.remoteFile.isReady()) {
            this.remoteFile.closeSync();
            this.handleCommand(this.command);
        }
    }
    handleCommand(command) {
        L.trace('handleCommand', command.getName());
        switch (command.getName()) {
            case 'open':
                this.handleOpen(command);
                break;
            case 'list':
                this.handleList(command);
                this.emit('list');
                break;
            case 'connect':
                this.handleConnect(command);
                this.emit('connect');
                break;
        }
    }
    openInEditor() {
        L.trace('openInEditor');
        vscode.workspace.openTextDocument(this.remoteFile.getLocalFilePath()).then((textDocument) => {
            if (!textDocument && this.attempts < 3) {
                L.warn("Failed to open the text document, will try again");
                setTimeout(() => {
                    this.attempts++;
                    this.openInEditor();
                }, 100);
                return;
            }
            else if (!textDocument) {
                L.error("Could NOT open the file", this.remoteFile.getLocalFilePath());
                vscode.window.showErrorMessage(`Failed to open file ${this.remoteFile.getRemoteBaseName()}`);
                return;
            }
            vscode.window.showTextDocument(textDocument).then((textEditor) => {
                this.handleChanges(textDocument);
                L.info(`Opening ${this.remoteFile.getRemoteBaseName()} from ${this.remoteFile.getHost()}`);
                vscode.window.setStatusBarMessage(`Opening ${this.remoteFile.getRemoteBaseName()} from ${this.remoteFile.getHost()}`, 2000);
                this.showSelectedLine(textEditor);
            });
        });
    }
    handleChanges(textDocument) {
        L.trace('handleChanges', textDocument.fileName);
        this.subscriptions.push(vscode.workspace.onDidSaveTextDocument((savedTextDocument) => {
            if (savedTextDocument == textDocument) {
                this.save();
            }
        }));
        this.subscriptions.push(vscode.workspace.onDidCloseTextDocument((closedTextDocument) => {
            if (closedTextDocument == textDocument) {
                this.closeTimeout && clearTimeout(this.closeTimeout);
                // If you change the textDocument language, it will close and re-open the same textDocument, so we add
                // a timeout to make sure it is really being closed before close the socket.
                this.closeTimeout = setTimeout(() => {
                    this.close();
                }, 2);
            }
        }));
        this.subscriptions.push(vscode.workspace.onDidOpenTextDocument((openedTextDocument) => {
            if (openedTextDocument == textDocument) {
                this.closeTimeout && clearTimeout(this.closeTimeout);
            }
        }));
    }
    showSelectedLine(textEditor) {
        var selection = +(this.command.getVariable('selection'));
        if (selection) {
            textEditor.revealRange(new vscode.Range(selection, 0, selection + 1, 1));
        }
    }
    handleOpen(command) {
        L.trace('handleOpen', command.getName());
        this.openInEditor();
    }
    handleConnect(command) {
        L.trace('handleConnect', command.getName());
    }
    handleList(command) {
        L.trace('handleList', command.getName());
    }
    send(cmd) {
        L.trace('send', cmd);
        if (this.isOnline()) {
            this.socket.write(cmd + "\n");
        }
    }
    open(filePath) {
        L.trace('filePath', filePath);
        this.send("open");
        this.send(`path: ${filePath}`);
        this.send("");
    }
    list(dirPath) {
        L.trace('list', dirPath);
        this.send("list");
        this.send(`path: ${dirPath}`);
        this.send("");
    }
    save() {
        L.trace('save');
        if (!this.isOnline()) {
            L.error("NOT online");
            vscode.window.showErrorMessage(`Error saving ${this.remoteFile.getRemoteBaseName()} to ${this.remoteFile.getHost()}`);
            return;
        }
        vscode.window.setStatusBarMessage(`Saving ${this.remoteFile.getRemoteBaseName()} to ${this.remoteFile.getHost()}`, 2000);
        var buffer = this.remoteFile.readFileSync();
        this.send("save");
        this.send(`token: ${this.remoteFile.getToken()}`);
        this.send("data: " + buffer.length);
        this.socket.write(buffer);
        this.send("");
    }
    close() {
        L.trace('close');
        if (this.isOnline()) {
            this.online = false;
            this.send("close");
            this.send("");
            this.socket.end();
        }
        this.subscriptions.forEach((disposable) => disposable.dispose());
    }
    isOnline() {
        L.trace('isOnline');
        L.debug('isOnline?', this.online);
        return this.online;
    }
}
exports.default = Session;
//# sourceMappingURL=Session.js.map