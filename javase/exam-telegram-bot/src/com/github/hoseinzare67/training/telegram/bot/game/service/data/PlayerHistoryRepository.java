package com.github.hoseinzare67.training.telegram.bot.game.service.data;

import com.github.hoseinzare67.training.telegram.bot.game.exception.PlayerHistoryReadDataException;
import com.github.hoseinzare67.training.telegram.bot.game.exception.PlayerHistoryStoreDataException;
import com.github.hoseinzare67.training.telegram.bot.game.model.Play;

import java.util.List;

/**
 * @author hosseinzare67
 */
public interface PlayerHistoryRepository {
    void storePlay(Play play) throws PlayerHistoryStoreDataException;

    List<Play> getPlayListRanks() throws PlayerHistoryReadDataException;

}
