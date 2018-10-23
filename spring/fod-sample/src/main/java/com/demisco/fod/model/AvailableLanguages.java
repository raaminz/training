package com.demisco.fod.model;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonView;

import javax.persistence.*;
import java.util.Date;

@Table(name = "available_languages")
@Entity
@NamedQuery(name = "findAllAvailableLanguage", query = "from AvailableLanguages")
public class AvailableLanguages {
    @Id
    @JsonView(GeneralView.class)
    private String language;

    @JsonView(GeneralView.class)
    @Column(name = "default_flag")
    private Character defaultFlag;

    @Column(name = "created_by")
    @JsonView(GeneralView.class)
    private String createdBy;
    @Column(name = "last_updated_by")
    private String lastUpdatedBy;
    @Column(name = "creation_date")
    private Date creationDate;
    @Column(name = "last_update_Date")
    private Date lastUpdateDate;
    @Column(name = "object_version_id")
    private Long objectVersionId;

    public String getLanguage() {
        return language;
    }

    public void setLanguage(String language) {
        this.language = language;
    }

    public Character getDefaultFlag() {
        return defaultFlag;
    }

    public void setDefaultFlag(Character defaultFlag) {
        this.defaultFlag = defaultFlag;
    }

    public String getCreatedBy() {
        return createdBy;
    }

    public void setCreatedBy(String createdBy) {
        this.createdBy = createdBy;
    }

    public String getLastUpdatedBy() {
        return lastUpdatedBy;
    }

    public void setLastUpdatedBy(String lastUpdatedBy) {
        this.lastUpdatedBy = lastUpdatedBy;
    }

    public Date getCreationDate() {
        return creationDate;
    }

    public void setCreationDate(Date creationDate) {
        this.creationDate = creationDate;
    }

    public Date getLastUpdateDate() {
        return lastUpdateDate;
    }

    public void setLastUpdateDate(Date lastUpdateDate) {
        this.lastUpdateDate = lastUpdateDate;
    }

    public Long getObjectVersionId() {
        return objectVersionId;
    }

    public void setObjectVersionId(Long objectVersionId) {
        this.objectVersionId = objectVersionId;
    }

    @Override
    public String toString() {
        return "AvailableLanguages{" +
                "language='" + language + '\'' +
                ", defaultFlag=" + defaultFlag +
                ", createdBy='" + createdBy + '\'' +
                ", lastUpdatedBy='" + lastUpdatedBy + '\'' +
                ", creationDate=" + creationDate +
                ", lastUpdateDate=" + lastUpdateDate +
                ", objectVersionId=" + objectVersionId +
                '}';
    }

    public interface GeneralView{

    }
}