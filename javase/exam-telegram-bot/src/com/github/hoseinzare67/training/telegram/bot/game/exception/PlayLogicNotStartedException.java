package com.github.hoseinzare67.training.telegram.bot.game.exception;

/**
 * @author hosseinzare67
 */
public class PlayLogicNotStartedException extends Exception {
    public PlayLogicNotStartedException() {
    }

    public PlayLogicNotStartedException(String message) {
        super(message);
    }

    public PlayLogicNotStartedException(String message, Throwable cause) {
        super(message, cause);
    }

    public PlayLogicNotStartedException(Throwable cause) {
        super(cause);
    }
}
