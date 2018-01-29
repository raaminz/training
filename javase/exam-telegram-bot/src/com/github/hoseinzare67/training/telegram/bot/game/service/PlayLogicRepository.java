package com.github.hoseinzare67.training.telegram.bot.game.service;

import com.github.hoseinzare67.training.telegram.bot.game.service.PlayLogic;

import java.util.Map;

public interface PlayLogicRepository {

    void storePlayLogic(Long userId, PlayLogic playLogic);

    PlayLogic getPlayLogic(Long userId);

    void removePlayLogicIfAny(Long userId);
}
