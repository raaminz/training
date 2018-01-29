package com.github.hoseinzare67.training.telegram.bot.game.exception;

public class PlayerHistoryReadDataException extends InternalBotException {
    public PlayerHistoryReadDataException() {
    }

    public PlayerHistoryReadDataException(String message) {
        super(message);
    }

    public PlayerHistoryReadDataException(String message, Throwable cause) {
        super(message, cause);
    }

    public PlayerHistoryReadDataException(Throwable cause) {
        super(cause);
    }
}
