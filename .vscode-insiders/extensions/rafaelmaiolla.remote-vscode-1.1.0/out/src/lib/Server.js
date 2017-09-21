"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const net = require("net");
const Session_1 = require("./Session");
const vscode = require("vscode");
const Logger_1 = require("../utils/Logger");
const events_1 = require("events");
const L = Logger_1.default.getLogger('Server');
const DEFAULT_PORT = 52698;
const DEFAULT_HOST = '127.0.0.1';
class Server extends events_1.EventEmitter {
    constructor() {
        super();
        this.online = false;
        this.dontShowPortAlreadyInUseError = false;
        L.trace('constructor');
    }
    start(quiet) {
        L.trace('start', quiet);
        if (this.isOnline()) {
            this.stop();
            L.info("Restarting server");
            vscode.window.setStatusBarMessage("Restarting server", 2000);
            this.emit('restarting');
        }
        else {
            if (!quiet) {
                L.info("Starting server");
                vscode.window.setStatusBarMessage("Starting server", 2000);
            }
            this.emit('starting');
        }
        this.server = net.createServer(this.onServerConnection.bind(this));
        this.server.on('listening', this.onServerListening.bind(this));
        this.server.on('error', this.onServerError.bind(this));
        this.server.on("close", this.onServerClose.bind(this));
        this.server.listen(this.getPort(), this.getHost());
    }
    setPort(port) {
        L.trace('setPort', port);
        this.port = port;
    }
    getPort() {
        L.trace('getPort', +(this.port || DEFAULT_PORT));
        return +(this.port || DEFAULT_PORT);
    }
    setHost(host) {
        L.trace('setHost', host);
        this.host = host;
    }
    getHost() {
        L.trace('getHost', +(this.host || DEFAULT_HOST));
        return (this.host || DEFAULT_HOST);
    }
    setDontShowPortAlreadyInUseError(dontShowPortAlreadyInUseError) {
        L.trace('setDontShowPortAlreadyInUseError', dontShowPortAlreadyInUseError);
        this.dontShowPortAlreadyInUseError = dontShowPortAlreadyInUseError;
    }
    onServerConnection(socket) {
        L.trace('onServerConnection');
        var session = new Session_1.default(socket);
        session.send("VSCode " + 1);
        session.on('connect', () => {
            console.log("connect");
            this.defaultSession = session;
        });
    }
    onServerListening(e) {
        L.trace('onServerListening');
        this.setOnline(true);
        this.emit('ready');
    }
    onServerError(e) {
        L.trace('onServerError', e);
        this.emit('error', e);
        if (e.code == 'EADDRINUSE') {
            if (this.dontShowPortAlreadyInUseError) {
                return;
            }
            else {
                return vscode.window.showErrorMessage(`Failed to start server, port ${e.port} already in use`);
            }
        }
        vscode.window.showErrorMessage(`Failed to start server, will try again in 10 seconds}`);
        setTimeout(() => {
            this.start(true);
        }, 10000);
    }
    onServerClose() {
        L.trace('onServerClose');
    }
    stop() {
        L.trace('stop');
        this.emit('stopped');
        if (this.isOnline()) {
            vscode.window.setStatusBarMessage("Stopping server", 2000);
            this.server.close();
            this.setOnline(false);
        }
    }
    setOnline(online) {
        L.trace('setOnline', online);
        this.online = online;
    }
    isOnline() {
        L.trace('isOnline');
        L.debug('isOnline?', this.online);
        return this.online;
    }
}
exports.default = Server;
//# sourceMappingURL=Server.js.map