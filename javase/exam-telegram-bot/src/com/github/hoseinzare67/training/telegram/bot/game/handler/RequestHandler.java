package com.github.hoseinzare67.training.telegram.bot.game.handler;

import com.github.hoseinzare67.training.telegram.bot.game.GameBot;
import com.github.hoseinzare67.training.telegram.bot.game.exception.InternalBotException;
import org.telegram.telegrambots.api.methods.BotApiMethod;
import org.telegram.telegrambots.api.objects.Update;

import java.io.Serializable;

/**
 * @author hosseinzare67
 */
public abstract class RequestHandler {
    private GameBot gameBot;
    private Update update;

    public RequestHandler(GameBot gameBot, Update update) {
        this.gameBot = gameBot;
        this.update = update;
    }

    public abstract <T extends Serializable> BotApiMethod<T> handle() throws InternalBotException;

    protected GameBot getGameBot() {
        return gameBot;
    }

    protected Update getUpdate() {
        return update;
    }

    protected Long getChatId() {
        return getUpdate().getMessage().getChatId();
    }
}
