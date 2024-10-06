"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const SIKLogLevelProvider_1 = require("../Providers/InteractionConfigurationProvider/SIKLogLevelProvider");
const logger_1 = require("./logger");
const LogLevel_1 = require("./LogLevel");
class NativeLogger {
    constructor(tag, logLevelProvider) {
        this.sikLogLevelProvider = SIKLogLevelProvider_1.default.getInstance();
        this.tag = tag;
        this.logger = (0, logger_1.logWithTag)(tag);
        this.logLevelProvider = logLevelProvider !== null && logLevelProvider !== void 0 ? logLevelProvider : this.sikLogLevelProvider;
        this.logLevelFilter = this.logLevelProvider.logLevel;
        this.logLevelProvider.onLogLevelChanged.add(this.updateLogLevel.bind(this));
    }
    i(message) {
        if (!this.shouldLog(LogLevel_1.LogLevel.Info)) {
            return;
        }
        this.logger(this.tag, message);
    }
    d(message) {
        if (!this.shouldLog(LogLevel_1.LogLevel.Debug)) {
            return;
        }
        this.logger(this.tag, message);
    }
    e(message) {
        if (!this.shouldLog(LogLevel_1.LogLevel.Error)) {
            return;
        }
        this.logger(this.tag, message);
    }
    w(message) {
        if (!this.shouldLog(LogLevel_1.LogLevel.Warning)) {
            return;
        }
        this.logger(this.tag, message);
    }
    v(message) {
        if (!this.shouldLog(LogLevel_1.LogLevel.Verbose)) {
            return;
        }
        this.logger(this.tag, message);
    }
    shouldLog(logLevel) {
        return logLevel <= this.logLevelFilter;
    }
    updateLogLevel(logLevel) {
        this.logLevelFilter = logLevel;
    }
}
exports.default = NativeLogger;
//# sourceMappingURL=NativeLogger.js.map