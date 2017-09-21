'use strict';
Object.defineProperty(exports, "__esModule", { value: true });
const vscode = require("vscode");
const Server_1 = require("./lib/Server");
const Logger_1 = require("./utils/Logger");
const StatusBarItem_1 = require("./lib/StatusBarItem");
const L = Logger_1.default.getLogger('extension');
var server;
var changeConfigurationDisposable;
var port;
var host;
var onStartup;
var dontShowPortAlreadyInUseError;
var statusBarItem;
const startServer = () => {
    L.trace('startServer');
    if (!server) {
        server = new Server_1.default();
    }
    if (!statusBarItem) {
        statusBarItem = new StatusBarItem_1.default();
    }
    server.setPort(port);
    server.setHost(host);
    server.setDontShowPortAlreadyInUseError(dontShowPortAlreadyInUseError);
    server.start(false);
    statusBarItem.setServer(server);
};
const stopServer = () => {
    L.trace('stopServer');
    if (server) {
        server.stop();
    }
};
const initialize = () => {
    L.trace('initialize');
    var configuration = getConfiguration();
    onStartup = configuration.onStartup;
    port = configuration.port;
    host = configuration.host;
    dontShowPortAlreadyInUseError = configuration.dontShowPortAlreadyInUseError;
    if (onStartup) {
        startServer();
    }
};
const getConfiguration = () => {
    L.trace('getConfiguration');
    var remoteConfig = vscode.workspace.getConfiguration('remote');
    var configuration = {
        onStartup: remoteConfig.get('onstartup'),
        dontShowPortAlreadyInUseError: remoteConfig.get('dontShowPortAlreadyInUseError'),
        port: remoteConfig.get('port'),
        host: remoteConfig.get('host')
    };
    L.debug("getConfiguration", configuration);
    return configuration;
};
const hasConfigurationChanged = (configuration) => {
    L.trace('hasConfigurationChanged');
    var hasChanged = ((configuration.port !== port) ||
        (configuration.onStartup !== onStartup) ||
        (configuration.host !== host) ||
        (configuration.dontShowPortAlreadyInUseError !== dontShowPortAlreadyInUseError));
    L.debug("hasConfigurationChanged?", hasChanged);
    return hasChanged;
};
const onConfigurationChange = () => {
    L.trace('onConfigurationChange');
    var configuration = getConfiguration();
    if (hasConfigurationChanged(configuration)) {
        initialize();
    }
};
function activate(context) {
    initialize();
    context.subscriptions.push(vscode.commands.registerCommand('extension.startServer', startServer));
    context.subscriptions.push(vscode.commands.registerCommand('extension.stopServer', stopServer));
    changeConfigurationDisposable = vscode.workspace.onDidChangeConfiguration(onConfigurationChange);
}
exports.activate = activate;
function deactivate() {
    stopServer();
    changeConfigurationDisposable.dispose();
}
exports.deactivate = deactivate;
//# sourceMappingURL=extension.js.map