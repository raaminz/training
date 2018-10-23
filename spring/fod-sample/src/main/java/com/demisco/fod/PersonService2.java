package com.demisco.fod;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

@Service
public class PersonService2 {
    @Autowired
    private JdbcTemplate jdbcTemplate;

    @Transactional(isolation = Isolation.READ_COMMITTED
            , propagation = Propagation.REQUIRED, timeout = 40
            , rollbackFor = Throwable.class)
    public void updatePersonName(long id, String name) throws Exception {
        jdbcTemplate.update("update Persons set first_name = ? " +
                "where person_id = ?", name, id);

    }
}
