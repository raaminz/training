package com.demisco.fod.service.repository;

import com.demisco.fod.model.AvailableLanguages;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.Date;
import java.util.List;

public interface AvailableLanguagesRepository
        extends JpaRepository<AvailableLanguages, String> {

    List<AvailableLanguages> findByLanguage(String language);

    List<AvailableLanguages> findByCreationDateBetween(Date date1, Date date2);

    @Query("select u from AvailableLanguages u where u.language like %?1 ")
    List<AvailableLanguages> findAllByLanguage(String language);

    @Query(name = "findAllAvailableLanguage")
    List<AvailableLanguages> findAllByNamedQuery();

    @Query(value = "select * from Available_Languages u where u.language like '%'||?1 "
            , nativeQuery = true)
    List<AvailableLanguages> findAllByLanguageNative(String language);

    @Query("select u from AvailableLanguages u where u.language like %:PLanguage ")
    List<AvailableLanguages> findAllByLanguageNamed(@Param("PLanguage") String language);


}
