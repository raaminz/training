package com.github.hoseinzare67.training.telegram.bot.game.service.data;

import com.github.hoseinzare67.training.telegram.bot.game.exception.PlayerHistoryReadDataException;
import com.github.hoseinzare67.training.telegram.bot.game.exception.PlayerHistoryStoreDataException;
import com.github.hoseinzare67.training.telegram.bot.game.model.Play;
import com.github.hoseinzare67.training.telegram.bot.game.model.Player;

import java.io.*;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;
import java.util.Objects;

/**
 * @author hosseinzare67
 */
public class FilePlayerHistoryRepository implements PlayerHistoryRepository {

    private File directoryToSave = new File("./data");
    private File dataFile = new File(directoryToSave, "ranks.data");

    public FilePlayerHistoryRepository() throws PlayerHistoryStoreDataException {
        if (!directoryToSave.exists()) {
            boolean couldCreate = directoryToSave.mkdirs();
            if (!couldCreate)
                throw new PlayerHistoryStoreDataException("Could not create directory for storing player history");
        }
        try {
            dataFile.createNewFile();
        } catch (IOException e) {
            throw new PlayerHistoryStoreDataException(e);
        }

    }

    private static String convertPlayToCsv(Play play) {
        Objects.requireNonNull(play);
        return String.format("%s,%d,%d,%d%n", play.getPlayer().getName(), play.getTimeSpend(), play.getCorrectAnswers(), play.getWrongAnswers());
    }

    private static Play convertCsvToPlay(String str) {
        Objects.requireNonNull(str, "String for play is null");
        String[] elements = str.split(",");
        Play play = new Play();
        play.setPlayer(new Player());
        play.getPlayer().setName(elements[0]);
        play.setTimeSpend(Long.valueOf(elements[1]));
        play.setCorrectAnswers(Integer.valueOf(elements[2]));
        play.setWrongAnswers(Integer.valueOf(elements[3]));
        return play;
    }

    @Override
    public void storePlay(Play play) throws PlayerHistoryStoreDataException {
        try (BufferedWriter stream =
                     new BufferedWriter(new FileWriter(dataFile, true))) {
            stream.write(convertPlayToCsv(play));
        } catch (IOException e) {
            throw new PlayerHistoryStoreDataException(e);
        }
    }

    @Override
    public List<Play> getPlayListRanks() throws PlayerHistoryReadDataException {
        List<Play> plays = new ArrayList<>();
        if (dataFile.length() > 0) {

            try (FileReader in = new FileReader(dataFile);
                 BufferedReader inputStream = new BufferedReader(in)) {
                String line;
                while ((line = inputStream.readLine()) != null) {
                    Play play = convertCsvToPlay(line);
                    plays.add(play);
                }
            } catch (IOException e) {
                throw new PlayerHistoryReadDataException(e);
            }
            plays.sort(new RankPlayComparator());
        }
        return plays;
    }

    private static class RankPlayComparator implements Comparator<Play> {
        @Override
        public int compare(Play o1, Play o2) {
            int compareCorrectAnswers = Long.compare(o1.getCorrectAnswers(), o2.getCorrectAnswers());
            if (compareCorrectAnswers == 0) {
                return Long.compare(o1.getTimeSpend(), o2.getTimeSpend());
            } else {
                return compareCorrectAnswers;
            }
        }
    }
}
