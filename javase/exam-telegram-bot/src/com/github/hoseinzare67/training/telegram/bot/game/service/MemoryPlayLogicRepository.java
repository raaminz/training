package com.github.hoseinzare67.training.telegram.bot.game.service;

import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

public class MemoryPlayLogicRepository implements PlayLogicRepository {


    private static final Map<Long, PlayLogic> CACHED_PLAYS =
            new ConcurrentHashMap<>();

    @Override
    public void storePlayLogic(Long userId, PlayLogic playLogic) {
        CACHED_PLAYS.put(userId, playLogic);
    }

    @Override
    public PlayLogic getPlayLogic(Long userId) {
        return CACHED_PLAYS.get(userId);
    }

    @Override
    public void removePlayLogicIfAny(Long userId) {
        CACHED_PLAYS.remove(userId);
    }
}
