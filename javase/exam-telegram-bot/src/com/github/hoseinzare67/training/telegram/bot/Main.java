package com.github.hoseinzare67.training.telegram.bot;

import com.github.hoseinzare67.training.telegram.bot.game.GameBot;
import com.github.hoseinzare67.training.telegram.bot.game.exception.PlayerHistoryStoreDataException;
import org.telegram.telegrambots.ApiContextInitializer;
import org.telegram.telegrambots.TelegramBotsApi;
import org.telegram.telegrambots.exceptions.TelegramApiException;

import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * @author hosseinzare67
 */
public class Main {

    private static final Logger LOGGER = Logger.getLogger(Main.class.getName());

    public static void main(String[] args) {
        ApiContextInitializer.init();
        TelegramBotsApi telegramBotsApi = new TelegramBotsApi();
        try {
            telegramBotsApi.registerBot(new GameBot());
        } catch (TelegramApiException | PlayerHistoryStoreDataException e) {
            LOGGER.log(Level.SEVERE, e.getMessage(), e);
            System.exit(-1);
        }
    }
}
