package com.github.hoseinzare67.training.telegram.bot.game.exception;

/**
 * @author hosseinzare67
 */
public class PlayerHistoryStoreDataException extends InternalBotException {
    public PlayerHistoryStoreDataException() {
    }

    public PlayerHistoryStoreDataException(String message) {
        super(message);
    }

    public PlayerHistoryStoreDataException(String message, Throwable cause) {
        super(message, cause);
    }

    public PlayerHistoryStoreDataException(Throwable cause) {
        super(cause);
    }
}
