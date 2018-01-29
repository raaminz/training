package com.github.hoseinzare67.training.telegram.bot.game.handler.factory;

import com.github.hoseinzare67.training.telegram.bot.game.GameBot;
import com.github.hoseinzare67.training.telegram.bot.game.handler.*;
import org.telegram.telegrambots.api.objects.Message;
import org.telegram.telegrambots.api.objects.Update;

public final class RequestHandlerFactory {

    private RequestHandlerFactory() {
    }

    public static RequestHandler getHandler(GameBot gameBot, Update update) {
        Message message = update.getMessage();
        RequestHandler requestHandler = null;
        if (message != null && message.hasText()) {
            switch (message.getText()) {
                case "/start":
                    requestHandler = new StartCommandHandler(gameBot, update);
                    break;
                case "/startGame":
                    requestHandler = new StartGameCommandHandler(gameBot, update);
                    break;
                case "/showGrades":
                    requestHandler = new ShowGradesCommandHandler(gameBot, update);
                    break;
                default:
                    if (message.getText().matches("[+-]?\\d+")) {
                        requestHandler = new AnswerEntryCommandHandler(gameBot, update);
                    } else {
                        requestHandler = new InvalidCommandHandler(gameBot, update);
                    }
                    break;
            }
        }

        return requestHandler;
    }
}
