package com.github.hoseinzare67.training.telegram.bot.game.service;


/**
 * @author hosseinzare67
 */
public interface PlayLogicRepository {

    void storePlayLogic(Long userId, PlayLogic playLogic);

    PlayLogic getPlayLogic(Long userId);

    void removePlayLogicIfAny(Long userId);
}
