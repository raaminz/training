package com.github.hoseinzare67.training.telegram.bot.game.model;

import java.io.Serializable;
import java.util.concurrent.TimeUnit;

/**
 * @author hosseinzare67
 */
public class Play implements Serializable{

    private static final long serialVersionUID = 22414L;

    private Player player;
    private int correctAnswers;
    private int wrongAnswers;
    private long timeSpend;
    private transient Statement[] statements;

    public Player getPlayer() {
        return player;
    }

    public void setPlayer(Player player) {
        this.player = player;
    }

    public int getCorrectAnswers() {
        return correctAnswers;
    }

    public void setCorrectAnswers(int correctAnswers) {
        this.correctAnswers = correctAnswers;
    }

    public int getWrongAnswers() {
        return wrongAnswers;
    }

    public void setWrongAnswers(int wrongAnswers) {
        this.wrongAnswers = wrongAnswers;
    }

    public long getTimeSpend() {
        return timeSpend;
    }

    public void setTimeSpend(long timeSpend) {
        this.timeSpend = timeSpend;
    }

    public Statement[] getStatements() {
        return statements;
    }

    public void setStatements(Statement[] statements) {
        this.statements = statements;
    }

    @Override
    public String toString() {
        String timeSpendWithFormat = TimeUnit.MILLISECONDS.toMinutes(timeSpend) +
                ":" + TimeUnit.MILLISECONDS.toSeconds(timeSpend);
        return String.format("%s - time spend %s , correct times : %d , wrong times : %d"
                , player.getName(), timeSpendWithFormat, correctAnswers, wrongAnswers);
    }
}
