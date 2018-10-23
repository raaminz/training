package com.demisco.fod;

import com.ibm.icu.text.SimpleDateFormat;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Component;

import java.text.ParseException;
import java.util.Date;

@Component
public class Class1 implements IClass{

    private SimpleDateFormat dateFormat;


    @Autowired
    @Qualifier("persianDateFormat")
    public void setDateFormat(SimpleDateFormat dateFormat) {
        this.dateFormat = dateFormat;
    }

    public Date convert(String date) {
        try {
            return dateFormat.parse(date);
        } catch (ParseException e) {
            throw new IllegalArgumentException(e);
        }
    }


    @Log
    public String helloAspect(){
        System.out.println("Hello Aspect");
        return "Hi";
    }

}