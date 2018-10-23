package com.demisco.fod.web.controller;

import com.demisco.fod.exception.EntityNotFound;
import com.demisco.fod.model.AvailableLanguages;
import com.demisco.fod.service.repository.AvailableLanguagesRepository;
import com.fasterxml.jackson.annotation.JsonView;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/lang")
public class AvailableLanguageController {

    private AvailableLanguagesRepository repository;

    @Autowired
    public AvailableLanguageController(AvailableLanguagesRepository repository) {
        this.repository = repository;
    }

    @GetMapping
    @JsonView(AvailableLanguages.GeneralView.class)
    public List<AvailableLanguages> findAll() {
        return repository.findAll();
    }

    @GetMapping("/{id}")
    @JsonView(AvailableLanguages.GeneralView.class)
    public AvailableLanguages findById(@PathVariable String id )
            throws EntityNotFound {
        return repository.findById(id).orElseThrow(() -> new EntityNotFound("Language Not Found"));
    }

    @PostMapping
    public Message save(@RequestBody AvailableLanguages availableLanguages){
        return new Message(false , "Saved Successfully");
    }

    @PutMapping
    public Message update(@RequestBody AvailableLanguages availableLanguages){
        return new Message(false , "Updated Successfully");
    }

    @DeleteMapping("/{id:\\d+}")
    public Message delete(@PathVariable String id){
        return new Message(false , "Deleted Successfully");
    }

    @ExceptionHandler
    @ResponseStatus(HttpStatus.BAD_REQUEST)
    public Message exceptionHandler(EntityNotFound entityNotFound){
        return new Message(true , entityNotFound.getMessage());
    }

    public static class Message{
        private boolean error ;
        private String message;

        public Message(boolean error, String message) {
            this.error = error;
            this.message = message;
        }

        public boolean isError() {
            return error;
        }

        public void setError(boolean error) {
            this.error = error;
        }

        public String getMessage() {
            return message;
        }

        public void setMessage(String message) {
            this.message = message;
        }
    }
}
