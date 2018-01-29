package com.github.hoseinzare67.training.telegram.bot.game.exception;

public class InternalBotException extends Exception {

    public InternalBotException() {
    }

    public InternalBotException(String message) {
        super(message);
    }

    public InternalBotException(String message, Throwable cause) {
        super(message, cause);
    }

    public InternalBotException(Throwable cause) {
        super(cause);
    }
}
