package com.github.hoseinzare67.training.telegram.bot.game.model;

public class Statement {
    private int lValue ;
    private int rValue ;
    private char operator ;
    private int result ;
    private Integer answer ;

    public Statement() {
    }

    public Statement(int lValue, int rValue, char operator, int result) {
        this.lValue = lValue;
        this.rValue = rValue;
        this.operator = operator;
        this.result = result;
    }

    public int getlValue() {
        return lValue;
    }

    public void setlValue(int lValue) {
        this.lValue = lValue;
    }

    public int getrValue() {
        return rValue;
    }

    public void setrValue(int rValue) {
        this.rValue = rValue;
    }

    public char getOperator() {
        return operator;
    }

    public void setOperator(char operator) {
        this.operator = operator;
    }

    public int getResult() {
        return result;
    }

    public void setResult(int result) {
        this.result = result;
    }

    public Integer getAnswer() {
        return answer;
    }

    public void setAnswer(Integer answer) {
        this.answer = answer;
    }

    public String toQuestionString(){
        return String.format("%d %s %d = ?" , lValue , operator , rValue);

    }

    @Override
    public String toString() {
        return String.format("%d %s %d = %d" , lValue , operator , rValue, result);
    }
}
