package com.demisco.fod;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.TransactionDefinition;
import org.springframework.transaction.support.TransactionTemplate;

@Service
public class PersonService {

    private JdbcTemplate jdbcTemplate;
    private TransactionTemplate transactionTemplate;

    @Autowired
    public PersonService(JdbcTemplate jdbcTemplate
            , PlatformTransactionManager transactionTemplate) {
        this.jdbcTemplate = jdbcTemplate;
        this.transactionTemplate = new TransactionTemplate(transactionTemplate);
        this.transactionTemplate.setTimeout(30);
        this.transactionTemplate.setIsolationLevel(
                TransactionDefinition.ISOLATION_READ_COMMITTED);

    }

    public void updatePersonName(long id, String name) {
        transactionTemplate.execute(status ->
                jdbcTemplate.update("update Persons set first_name = ? " +
                        "where person_id = ?", name, id));
    }
}
