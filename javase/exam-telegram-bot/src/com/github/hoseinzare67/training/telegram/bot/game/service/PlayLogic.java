package com.github.hoseinzare67.training.telegram.bot.game.service;

import com.github.hoseinzare67.training.telegram.bot.game.exception.NoMoreQuestionException;
import com.github.hoseinzare67.training.telegram.bot.game.exception.PlayLogicNotStartedException;
import com.github.hoseinzare67.training.telegram.bot.game.exception.PlayerHistoryStoreDataException;
import com.github.hoseinzare67.training.telegram.bot.game.model.Play;
import com.github.hoseinzare67.training.telegram.bot.game.model.Player;
import com.github.hoseinzare67.training.telegram.bot.game.model.Statement;
import com.github.hoseinzare67.training.telegram.bot.game.service.data.FilePlayerHistoryRepository;
import com.github.hoseinzare67.training.telegram.bot.game.service.data.PlayerHistoryRepository;

import java.util.Random;

/**
 * @author hosseinzare67
 */
public final class PlayLogic {
    private static final int MAX_STATEMENTS = 2;

    private GameStatus gameStatus = GameStatus.READY;
    private long startTime;
    private long endTime;
    private Play play;

    private PlayerHistoryRepository playerHistoryRepository;

    private Statement currentStatement;
    private int currentStatementIndex = -1;

    public PlayLogic() throws PlayerHistoryStoreDataException {
        play = new Play();
        play.setStatements(generateStatements());
        play.setPlayer(new Player());
        playerHistoryRepository = new FilePlayerHistoryRepository();
    }

    private Statement[] generateStatements() {
        Statement[] statements = new Statement[MAX_STATEMENTS];
        Random random = new Random();
        for (int i = 0; i < MAX_STATEMENTS; i++) {
            char operand = (random.nextBoolean()) ? '+' : '-';
            int lValue = random.nextInt(49) + 1;
            int rValue = random.nextInt(49) + 1;
            int result;
            if (operand == '+') {
                result = lValue + rValue;
            } else {
                result = lValue - rValue;
            }
            statements[i] =
                    new Statement
                            (lValue, rValue, operand, result);
        }
        return statements;
    }

    public void startGame() {
        if (gameStatus != GameStatus.READY) {
            return;
        }
        gameStatus = GameStatus.PLAYING;
        startTime = System.currentTimeMillis();
    }

    public Play givePlayerName(String name) throws PlayerHistoryStoreDataException {
        play.getPlayer().setName(name);
        play.setTimeSpend(endTime - startTime);

        analyzeAnswers();

        playerHistoryRepository.storePlay(play);

        return play;
    }

    private void analyzeAnswers() {
        int correctTime = 0;
        int wrongTime = 0;
        for (Statement statement : play.getStatements()) {
            if (statement.getAnswer() == statement.getResult()) {
                correctTime++;
            } else {
                wrongTime++;
            }
        }
        play.setCorrectAnswers(correctTime);
        play.setWrongAnswers(wrongTime);
    }

    public int getQuestionCount() {
        return play.getStatements().length;
    }

    public Statement nextStatement() throws PlayLogicNotStartedException, NoMoreQuestionException {
        if (gameStatus != GameStatus.PLAYING) {
            throw new PlayLogicNotStartedException();
        }
        Statement result = null;
        int maxStatementsIndex = play.getStatements().length - 1;
        if (++currentStatementIndex <= maxStatementsIndex) {
            currentStatement = play.getStatements()[currentStatementIndex];
            result = currentStatement;
        }
        if (result == null) {
            endTime = System.currentTimeMillis();
            throw new NoMoreQuestionException();
        }

        return result;
    }

    public void giveAnswer(int answer) throws NoMoreQuestionException {
        if (gameStatus == GameStatus.PLAYING) {
            currentStatement.setAnswer(answer);
        } else {
            throw new NoMoreQuestionException();
        }
        if (play.getStatements().length == currentStatementIndex - 1) {
            gameStatus = GameStatus.FINISHED;
        }
    }

    public enum GameStatus {
        READY, PLAYING, FINISHED
    }
}


