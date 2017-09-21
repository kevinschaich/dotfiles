"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const vscode = require("vscode");
class StatusBarItem {
    constructor() {
        this.server = null;
        this.item = vscode.window.createStatusBarItem(vscode.StatusBarAlignment.Right);
        this.item.color = new vscode.ThemeColor('statusBar.foreground');
        this.item.text = '$(rss)';
    }
    setServer(server) {
        if (this.server) {
            this.server.removeAllListeners();
        }
        this.server = server;
        this.handleEvents(server);
    }
    handleEvents(server) {
        server.on('restarting', this.onRestarting.bind(this));
        server.on('starting', this.onStarting.bind(this));
        server.on('ready', this.onReady.bind(this));
        server.on('error', this.onError.bind(this));
        server.on('stopped', this.onStopped.bind(this));
    }
    onRestarting() {
        this.item.tooltip = 'Remote: Restarting server...';
        this.item.color = new vscode.ThemeColor('statusBar.foreground');
        this.item.show();
    }
    onStarting() {
        this.item.tooltip = 'Remote: Starting server...';
        this.item.color = new vscode.ThemeColor('statusBar.foreground');
        this.item.show();
    }
    onReady() {
        this.item.tooltip = 'Remote: Server ready.';
        this.item.color = new vscode.ThemeColor('statusBar.foreground');
        this.item.show();
    }
    onError(e) {
        if (e.code == 'EADDRINUSE') {
            this.item.tooltip = 'Remote error: Port already in use.';
        }
        else {
            this.item.tooltip = 'Remote error: Failed to start server.';
        }
        this.item.color = new vscode.ThemeColor('errorForeground');
        this.item.show();
    }
    onStopped() {
        this.item.tooltip = 'Remote: Server stopped.';
        this.item.color = new vscode.ThemeColor('statusBar.foreground');
        this.item.show();
    }
}
module.exports = StatusBarItem;
//# sourceMappingURL=statusbar.js.map