package com.github.hoseinzare67.training.telegram.bot.game.handler;

import com.github.hoseinzare67.training.telegram.bot.game.GameBot;
import com.github.hoseinzare67.training.telegram.bot.game.exception.InternalBotException;
import com.github.hoseinzare67.training.telegram.bot.game.exception.NoMoreQuestionException;
import com.github.hoseinzare67.training.telegram.bot.game.exception.PlayLogicNotStartedException;
import com.github.hoseinzare67.training.telegram.bot.game.model.Play;
import com.github.hoseinzare67.training.telegram.bot.game.model.Statement;
import com.github.hoseinzare67.training.telegram.bot.game.service.PlayLogic;
import com.github.hoseinzare67.training.telegram.bot.game.service.PlayLogicRepository;
import org.telegram.telegrambots.api.methods.BotApiMethod;
import org.telegram.telegrambots.api.methods.send.SendMessage;
import org.telegram.telegrambots.api.objects.Update;

/**
 * @author hosseinzare67
 */
public class AnswerEntryCommandHandler extends RequestHandler {
    public AnswerEntryCommandHandler(GameBot gameBot, Update update) {
        super(gameBot, update);
    }


    @Override
    @SuppressWarnings("unchecked")
    public BotApiMethod handle() throws InternalBotException {
        PlayLogicRepository playLogicRepository = getGameBot().getPlayLogicRepository();
        PlayLogic playLogic = playLogicRepository.getPlayLogic(getChatId());
        String message;
        if (playLogic != null) {
            try {
                playLogic.giveAnswer(Integer.parseInt(getUpdate().getMessage().getText()));
                Statement statement = playLogic.nextStatement();
                return new SendMessage(getChatId(), statement.toQuestionString());
            } catch (NoMoreQuestionException e) {
                Play play = playLogic.givePlayerName(getUpdate().getMessage().getFrom().getUserName());
                playLogicRepository.removePlayLogicIfAny(getChatId());
                message = "The Result is : \n" + play.toString();
            } catch (PlayLogicNotStartedException e) {
                message = "Game Not Started Yet . first /startGame";
            }
        } else {
            message = "First Start A Game with /startGame";
        }
        return new SendMessage(getChatId(), message);
    }
}
