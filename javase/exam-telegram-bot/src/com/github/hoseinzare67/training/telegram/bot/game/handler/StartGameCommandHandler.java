package com.github.hoseinzare67.training.telegram.bot.game.handler;

import com.github.hoseinzare67.training.telegram.bot.game.GameBot;
import com.github.hoseinzare67.training.telegram.bot.game.exception.InternalBotException;
import com.github.hoseinzare67.training.telegram.bot.game.exception.NoMoreQuestionException;
import com.github.hoseinzare67.training.telegram.bot.game.exception.PlayLogicNotStartedException;
import com.github.hoseinzare67.training.telegram.bot.game.model.Statement;
import com.github.hoseinzare67.training.telegram.bot.game.service.PlayLogic;
import com.github.hoseinzare67.training.telegram.bot.game.service.PlayLogicRepository;
import org.telegram.telegrambots.api.methods.BotApiMethod;
import org.telegram.telegrambots.api.methods.send.SendMessage;
import org.telegram.telegrambots.api.objects.Update;

public class StartGameCommandHandler extends RequestHandler {

    public StartGameCommandHandler(GameBot gameBot, Update update) {
        super(gameBot, update);
    }

    @Override
    @SuppressWarnings("unchecked")
    public BotApiMethod handle() throws InternalBotException {
        String message;
        try {
            PlayLogicRepository playLogicRepository = getGameBot().getPlayLogicRepository();
            playLogicRepository.removePlayLogicIfAny(getChatId());
            PlayLogic playLogic = playLogicRepository.getPlayLogic(getChatId());
            if (playLogic == null) {
                playLogic = new PlayLogic();
                playLogic.startGame();
                playLogicRepository.storePlayLogic(getChatId(), playLogic);
            }
            Statement statement = playLogic.nextStatement();
            message = statement.toQuestionString();
        } catch (NoMoreQuestionException e) {
            message = "No Other Question Yet";
        } catch (PlayLogicNotStartedException e) {
            message = "Please /startGame first";
        }
        return new SendMessage(getChatId(), message);
    }
}
