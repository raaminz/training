package com.github.hoseinzare67.training.telegram.bot.game.exception;

public class NoMoreQuestionException extends Exception {
    public NoMoreQuestionException() {
    }

    public NoMoreQuestionException(String message) {
        super(message);
    }

    public NoMoreQuestionException(String message, Throwable cause) {
        super(message, cause);
    }

    public NoMoreQuestionException(Throwable cause) {
        super(cause);
    }
}
