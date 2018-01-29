package com.github.hoseinzare67.training.telegram.bot.game.handler;

import com.github.hoseinzare67.training.telegram.bot.game.GameBot;
import org.telegram.telegrambots.api.methods.BotApiMethod;
import org.telegram.telegrambots.api.methods.send.SendMessage;
import org.telegram.telegrambots.api.objects.Update;

public class StartCommandHandler extends RequestHandler {
    public StartCommandHandler(GameBot gameBot, Update update) {
        super(gameBot, update);
    }

    @Override
    @SuppressWarnings("unchecked")
    public BotApiMethod handle() {
       return new SendMessage(getChatId(), "Welcome . Enter /startGame to Start");
    }
}
