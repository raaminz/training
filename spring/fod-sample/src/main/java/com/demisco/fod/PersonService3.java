package com.demisco.fod;

import com.demisco.fod.model.AvailableLanguages;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.PersistenceContext;
import java.util.List;

@Service
public class PersonService3 {
    @PersistenceContext
    private EntityManager entityManager;

    @Transactional(readOnly = true , rollbackFor = Throwable.class)
    public List<AvailableLanguages> fetchAll() {
        return entityManager.createQuery("from AvailableLanguages").getResultList();
    }

    @Transactional(isolation = Isolation.READ_COMMITTED
            , propagation = Propagation.REQUIRED, timeout = 40
            , rollbackFor = Throwable.class)
    public void update() {
        entityManager.createQuery("update AvailableLanguages set defaultFlag = 'N' where id = 'FR'").executeUpdate();
    }
}
