package com.github.hoseinzare67.training.telegram.bot.game.model;

import java.io.Serializable;

public class Player implements Serializable {
    private String name ;

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }
}
