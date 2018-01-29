package com.github.hoseinzare67.training.telegram.bot.game;

import com.github.hoseinzare67.training.telegram.bot.game.exception.InternalBotException;
import com.github.hoseinzare67.training.telegram.bot.game.exception.PlayerHistoryStoreDataException;
import com.github.hoseinzare67.training.telegram.bot.game.handler.RequestHandler;
import com.github.hoseinzare67.training.telegram.bot.game.handler.factory.RequestHandlerFactory;
import com.github.hoseinzare67.training.telegram.bot.game.service.data.FilePlayerHistoryRepository;
import com.github.hoseinzare67.training.telegram.bot.game.service.MemoryPlayLogicRepository;
import com.github.hoseinzare67.training.telegram.bot.game.service.PlayLogicRepository;
import com.github.hoseinzare67.training.telegram.bot.game.service.data.PlayerHistoryRepository;
import org.telegram.telegrambots.api.methods.send.SendMessage;
import org.telegram.telegrambots.api.objects.Update;
import org.telegram.telegrambots.bots.TelegramLongPollingBot;
import org.telegram.telegrambots.exceptions.TelegramApiException;

import java.util.logging.Level;
import java.util.logging.Logger;

public class GameBot extends TelegramLongPollingBot {

    private static final Logger LOGGER = Logger.getLogger(GameBot.class.getName());

    private PlayLogicRepository playLogicRepository;
    private PlayerHistoryRepository playerHistoryRepository;

    public GameBot() throws PlayerHistoryStoreDataException {
        playLogicRepository = new MemoryPlayLogicRepository();
        playerHistoryRepository = new FilePlayerHistoryRepository();

    }

    @Override
    public void onUpdateReceived(Update update) {
        RequestHandler handler = RequestHandlerFactory.getHandler(this, update);
        try {
            sendApiMethod(handler.handle());
        } catch (InternalBotException | TelegramApiException e) {
            LOGGER.log(Level.SEVERE, e.getMessage(), e);
            try {
                sendApiMethod(new SendMessage(update.getMessage().getChatId(), "Sorry an Internal Error occured , please try again"));
            } catch (TelegramApiException e1) {
                LOGGER.log(Level.SEVERE, "Error Sending message to Telegram");
                LOGGER.log(Level.SEVERE, e.getMessage(), e);
            }
        }
    }

    @Override
    public String getBotUsername() {
        return "<bot_user_name>";
    }

    @Override
    public String getBotToken() {
        return "<bot_token>";
    }

    public PlayLogicRepository getPlayLogicRepository() {
        return playLogicRepository;
    }

    public PlayerHistoryRepository getPlayerHistoryRepository() {
        return playerHistoryRepository;
    }
}
