package com.github.hoseinzare67.training.telegram.bot;

import com.github.hoseinzare67.training.telegram.bot.game.GameBot;
import com.github.hoseinzare67.training.telegram.bot.game.exception.PlayerHistoryStoreDataException;
import org.telegram.telegrambots.ApiContextInitializer;
import org.telegram.telegrambots.TelegramBotsApi;
import org.telegram.telegrambots.exceptions.TelegramApiException;

public class Main {
    public static void main(String[] args) {
        ApiContextInitializer.init();
        TelegramBotsApi telegramBotsApi = new TelegramBotsApi();
        try {
            telegramBotsApi.registerBot(new GameBot());
        } catch (TelegramApiException e) {
            e.printStackTrace();
        } catch (PlayerHistoryStoreDataException e) {
            System.out.println("Trouble Initializing data");
            System.exit(-1);
        }
    }
}
