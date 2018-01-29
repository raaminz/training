package com.github.hoseinzare67.training.telegram.bot.game.handler;

import com.github.hoseinzare67.training.telegram.bot.game.GameBot;
import com.github.hoseinzare67.training.telegram.bot.game.exception.InternalBotException;
import com.github.hoseinzare67.training.telegram.bot.game.model.Play;
import org.telegram.telegrambots.api.methods.BotApiMethod;
import org.telegram.telegrambots.api.methods.send.SendMessage;
import org.telegram.telegrambots.api.objects.Update;

import java.util.List;

public class ShowGradesCommandHandler extends RequestHandler {
    public ShowGradesCommandHandler(GameBot gameBot, Update update) {
        super(gameBot, update);
    }

    @Override
    @SuppressWarnings("unchecked")
    public BotApiMethod handle() throws InternalBotException {
        getGameBot().getPlayLogicRepository().removePlayLogicIfAny(getChatId());
        List<Play> playListRanks = getGameBot().getPlayerHistoryRepository().getPlayListRanks();
        StringBuilder playerRanksMessage = new StringBuilder();
        for (Play play :
                playListRanks) {
            playerRanksMessage.append(play.toString()).append("\n");
        }
        return new SendMessage(getChatId(), playerRanksMessage.toString());
    }
}
