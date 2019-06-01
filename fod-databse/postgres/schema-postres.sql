create table ADDRESSES (   address_id        NUMERIC(15) not null,   address1          VARCHAR(40) not null,   address2          VARCHAR(40),   city              VARCHAR(40) not null,   postal_code       VARCHAR(12),   state_province    VARCHAR(40) not null,   country_id        CHAR(2) not null,   longitude         NUMERIC,   latitude          NUMERIC,created_by        VARCHAR(60) not null,   creation_date     DATE not null,   last_updated_by   VARCHAR(60) not null,   last_update_date  DATE not null,   object_version_id NUMERIC(15) not null );

comment on table ADDRESSES  is 'The shared address table that is used to hold customer addresses, shipping addresses, warehouse addresses and so on. ';

comment on column ADDRESSES.address_id  is 'Unique identifier for an address';

comment on column ADDRESSES.address1  is 'First Line of the Address e.g. Street / Apartment number';

comment on column ADDRESSES.address2  is 'Second line of adress if required';

comment on column ADDRESSES.city  is 'Postal city or town';

comment on column ADDRESSES.state_province  is 'If in the  US, this will be restricted to the US States, otherwise this will be free form.';

comment on column ADDRESSES.country_id  is 'ISO country code. See the COUNTRY_CODES table';

comment on column ADDRESSES.longitude  is 'Grid reference information for use in map mashups';

comment on column ADDRESSES.latitude  is 'Grid reference information for use in map mashups';

comment on column ADDRESSES.created_by  is 'History column';

comment on column ADDRESSES.creation_date  is 'History column';

comment on column ADDRESSES.last_updated_by  is 'History column';

comment on column ADDRESSES.last_update_date  is 'History column';

comment on column ADDRESSES.object_version_id  is 'History column';

alter table ADDRESSES   add constraint ADDRESSES_PK primary key (ADDRESS_ID);

create table SUPPLIERS (   supplier_id       NUMERIC(15) not null,   supplier_name     VARCHAR(120) not null,   supplier_status   VARCHAR(30) not null,   phone_number      VARCHAR(20),   email             VARCHAR(255),   ui_skin           VARCHAR(60),created_by        VARCHAR(60) not null,   creation_date     DATE not null,   last_updated_by   VARCHAR(60) not null,   last_update_date  DATE not null,   object_version_id NUMERIC(15) not null ) ;

comment on table SUPPLIERS  is 'This table holds a list of product suppliers';

comment on column SUPPLIERS.supplier_id  is 'Unique identifier for a supplier';

comment on column SUPPLIERS.supplier_name  is 'Supplier Name';

comment on column SUPPLIERS.created_by  is 'History column';

comment on column SUPPLIERS.creation_date  is 'History column';

comment on column SUPPLIERS.last_updated_by  is 'History column';

comment on column SUPPLIERS.last_update_date  is 'History column';

comment on column SUPPLIERS.object_version_id  is 'History column';

alter table SUPPLIERS  add constraint SUPPLIERS_PK primary key (SUPPLIER_ID);

create table MEMBERSHIPS_BASE (   membership_id        NUMERIC(15) not null,   membership_type_code VARCHAR(30) not null,   contact_id           NUMERIC(15) not null,created_by           VARCHAR(60) not null,   creation_date        DATE not null,   last_updated_by      VARCHAR(60) not null,   last_update_date     DATE not null,   object_version_id    NUMERIC(15) not null ) ;

comment on table MEMBERSHIPS_BASE  is 'The memberships table holds information about corporate and group membership programs. Particular discounts (see ELIGIBLE_DISCOUNTS) are associated with a membership.  Memberships may be personal,  group, coroprate or partner Note that this table is not translated.';

comment on column MEMBERSHIPS_BASE.membership_id  is 'Unique Id for a memberships';

comment on column MEMBERSHIPS_BASE.membership_type_code  is 'Type of membership, references LOOKUP_CODES; domain: MEMBERSHIP_TYPE_CODE';

comment on column MEMBERSHIPS_BASE.contact_id  is 'Link to the customer who is the named contact for this particular membership. This is mainly of interest to Group, Corporate and Partner memberships where many users will be associated with the same membership number';

comment on column MEMBERSHIPS_BASE.created_by  is 'History column';

comment on column MEMBERSHIPS_BASE.creation_date  is 'History column';

comment on column MEMBERSHIPS_BASE.last_updated_by  is 'History column';

comment on column MEMBERSHIPS_BASE.last_update_date  is 'History column';

comment on column MEMBERSHIPS_BASE.object_version_id  is 'History column';

alter table MEMBERSHIPS_BASE  add constraint MEMBERSHIPS_BASE_PK primary key (MEMBERSHIP_ID);

create table PERSONS (   person_id                   NUMERIC(15) not null,   principal_name              VARCHAR(60) not null,   title                       VARCHAR(12),   first_name                  VARCHAR(30),   last_name                   VARCHAR(30),   person_type_code            VARCHAR(30) not null,   supplier_id                 NUMERIC(15),   provisioned_flag            VARCHAR(1) default 'N',   primary_address_id          NUMERIC(15),   registered_date             DATE,   membership_id               NUMERIC(15),   email                       VARCHAR(25) not null,   confirmed_email             VARCHAR(25),   phone_number                VARCHAR(20),   mobile_phone_number         VARCHAR(20),   credit_limit                NUMERIC(9,2),   date_of_birth               DATE,   marital_status_code         VARCHAR(30) not null,   gender                      VARCHAR(1) not null,   children_under_18           NUMERIC(2),   approximate_income          NUMERIC(15),   contact_method_code         VARCHAR(30),   contactable_flag            VARCHAR(1) default 'Y' not null,   contact_by_affilliates_flag VARCHAR(1) default 'Y' not null,created_by                  VARCHAR(60) not null,   creation_date               DATE not null,   last_updated_by             VARCHAR(60) not null,   last_update_date            DATE not null,   object_version_id           NUMERIC(15) not null ) ;

comment on table PERSONS  is 'The core person information table';

comment on column PERSONS.person_id  is 'Unique Identifier for a Person';

comment on column PERSONS.principal_name  is 'Associates this person record with a security username (principle name) from LDAP or whatever security credential store is in use. ';

comment on column PERSONS.person_type_code  is 'Descriminator column: Customer or Staff. References LOOKUP_CODES, domain PERSON_TYPE_CODE';

comment on column PERSONS.provisioned_flag  is 'Boolean (Y/N) flag used to indicate if a person has been provisioned (created) in the security repository';

comment on column PERSONS.primary_address_id  is 'Main address of the person. This will be used as the default for filling in forms etc.';

comment on column PERSONS.registered_date  is 'The date that this person was registered on the system - note that this may not match the CREATION_DATE if the customer delays in confirming the registration.  The CREATION_DATE records when the record wascreated in the table, the REGISTERED_DATE records when the registration was finally confirmed. Implicitly a record with no REGISTRATION_DATE is a person who has begun, but not completed the registration process';

comment on column PERSONS.membership_id  is 'Customers may enroll in the membership program either using an ID unique to them or a shared Partner or Corporate ID';

comment on column PERSONS.email  is 'Contact email for the person. If this needs to be updated once the record iscreated then the user will either have to call customer support, or if they use the UI then they will have to confirm the email address change from the old email address (CONFIRMED_EMAIL) before it is finalised. Once the new address is confirmed both EMAIL and CONFIRMED_EMAIL will be set to the same value.';

comment on column PERSONS.confirmed_email  is 'The confirmed email column holds the last known good email address for the user. This will be set during the confirmation (identity verification) stage of the registration and as part of the final step of an email change operation';

comment on column PERSONS.phone_number  is 'Primary contact number';

comment on column PERSONS.credit_limit  is 'Calculated credit limit for this person used by the various rules within the shipping process';

comment on column PERSONS.marital_status_code  is 'Link to the LOOKUP_CODES table, MARITAL_STATUS_DOMAIN';

comment on column PERSONS.gender  is 'Three way flag M - Male, F - Female, D - Decline to Answer';

comment on column PERSONS.approximate_income  is 'Income  rounded - no precision needed';

comment on column PERSONS.contact_method_code  is 'Link to the LOOKUP_CODES table, domain: CONTACT_METHOD_CODE';

comment on column PERSONS.contactable_flag  is 'Can the person be contacted with great offers by us? ';

comment on column PERSONS.contact_by_affilliates_flag  is 'Can the person be contacted with great offers by our carefully chosen partners? ';

comment on column PERSONS.created_by  is 'History column';

comment on column PERSONS.creation_date  is 'History column';

comment on column PERSONS.last_updated_by  is 'History column';

comment on column PERSONS.last_update_date  is 'History column';

comment on column PERSONS.object_version_id is 'History column';

alter table PERSONS  add constraint PERSONS_PK primary key (PERSON_ID);

alter table PERSONS  add constraint PERSONS_AFF_CONTACT_CHK  check (CONTACT_BY_AFFILLIATES_FLAG in ('Y','N'));

alter table PERSONS  add constraint PERSONS_CONTACT_CHK  check (CONTACTABLE_FLAG in ('Y','N'));

alter table PERSONS  add constraint PERSONS_GENDER_CHK  check (GENDER in ('M','F','D'));

alter table PERSONS  add constraint PERSONS_PROVISIONED_CHK  check (PROVISIONED_FLAG in ('Y','N'));

create table ADDRESS_USAGES (   address_usages_id   NUMERIC not null,   associated_owner_id NUMERIC(15) not null,   owner_type_code     VARCHAR(30) not null,   address_id          NUMERIC(15) not null,   usage_type_code     VARCHAR(30) not null,   expired_flag        VARCHAR(1) default 'N' not null,created_by          VARCHAR(60) not null,   creation_date       DATE not null,   last_updated_by     VARCHAR(60) not null,   last_update_date    DATE not null,   object_version_id   NUMERIC(15) not null ) ;

comment on table ADDRESS_USAGES  is 'Intersection entity that maps addresses to customers, suppliers etc. Any entity that can have multiple addresses will map them through this table. Certain address references such as a Customer''s primary address are also de-normalised into the relevant table. Where a consumer has one and only one address it will have a direct reference to the address table and will not have an entry here (for example Warehouse)';

comment on column ADDRESS_USAGES.associated_owner_id  is 'The ID of the associated Customer or Supplier';

comment on column ADDRESS_USAGES.owner_type_code  is 'Links the address usage to either a Customer or a Supplier. References LOOKUP_CODES with the domain OWNER_TYPE_CODE';

comment on column ADDRESS_USAGES.address_id  is 'Unique Id of the mapped address';

comment on column ADDRESS_USAGES.usage_type_code  is 'Distinguish between shipping, postal and invoice addresses.References LOOKUP_CODES with the domain USAGE_TYPE_CODE';

comment on column ADDRESS_USAGES.expired_flag  is 'Boolean to indicate if this address mapping is still valid';

comment on column ADDRESS_USAGES.created_by  is 'History column';

comment on column ADDRESS_USAGES.creation_date  is 'History column';

comment on column ADDRESS_USAGES.last_updated_by  is 'History column';

comment on column ADDRESS_USAGES.last_update_date  is 'History column';

comment on column ADDRESS_USAGES.object_version_id  is 'History column';

alter table ADDRESS_USAGES  add constraint ADDRESS_USAGES_PK primary key (ADDRESS_USAGES_ID);

alter table ADDRESS_USAGES  add constraint ADDRESS_USAGES_CHK_EXPIRED  check (EXPIRED_FLAG in ('Y','N'));

create table AVAILABLE_LANGUAGES (   language          VARCHAR(30) not null,   default_flag      VARCHAR(1) default 'N' not null,created_by        VARCHAR(60) not null,   creation_date     DATE not null,   last_updated_by   VARCHAR(60) not null,   last_update_date  DATE not null,   object_version_id NUMERIC(15) not null ) ;

comment on table AVAILABLE_LANGUAGES  is 'AVAILABLE_LANGUAGES lists all of the translations that are available in the system. Any translation table will be fully populated with one instance per available language. The entry itself may not yet be translated, in which case, the SOURCE_LANGUAGE column in the translation table will hold the language that the entry is currently in. When a value has been translated SOURCE_LANGUAGE and LANGUAGE will be the same. Only one row in this table will have the DEFAULT_FLAG set to Y ';

comment on column AVAILABLE_LANGUAGES.language  is 'The supported language';

comment on column AVAILABLE_LANGUAGES.default_flag  is 'Is this the system base language? Boolean Flag Y or N';

comment on column AVAILABLE_LANGUAGES.created_by  is 'History column';

comment on column AVAILABLE_LANGUAGES.creation_date  is 'History column';

comment on column AVAILABLE_LANGUAGES.last_updated_by  is 'History column';

comment on column AVAILABLE_LANGUAGES.last_update_date  is 'History column';

comment on column AVAILABLE_LANGUAGES.object_version_id  is 'History column';

alter table AVAILABLE_LANGUAGES  add constraint AVAILABLE_LANGUAGES_PK primary key (LANGUAGE);

alter table AVAILABLE_LANGUAGES  add constraint AVAILABLE_LANGUAGES_DEFLT_CHK  check (DEFAULT_FLAG in ('Y','N'));

create table PRODUCT_CATEGORIES_BASE (   category_id               NUMERIC(15) not null,   parent_category_id        NUMERIC(15),   category_locked_flag      VARCHAR(1) default 'N' not null,   representative_product_id NUMERIC(15),created_by                VARCHAR(60) not null,   creation_date             DATE not null,   last_updated_by           VARCHAR(60) not null,   last_update_date          DATE not null,   object_version_id         NUMERIC(15) not null );

create table PRODUCTS_BASE (   product_id             NUMERIC(15) not null,   supplier_id            NUMERIC(15) not null,   parent_category_id     NUMERIC(15),   category_id            NUMERIC(15),   product_name           VARCHAR(50) not null,   product_status         VARCHAR(30) not null,   cost_price             NUMERIC(8,2),   list_price             NUMERIC(8,2) not null,   min_price              NUMERIC(8,2) not null,   warranty_period_months NUMERIC(2),   shipping_class_code    VARCHAR(30) not null,   external_url           VARCHAR(200),   attribute_category     VARCHAR(30),   attribute1             VARCHAR(150),   attribute2             VARCHAR(150),   attribute3             VARCHAR(150),   attribute4             VARCHAR(150),   attribute5             VARCHAR(150),   attribute6             VARCHAR(150),   attribute7             VARCHAR(150),   attribute8             VARCHAR(150),   attribute9             VARCHAR(150),   attribute10            VARCHAR(150),   attribute11            VARCHAR(150),   attribute12            VARCHAR(150),   attribute13            VARCHAR(150),   attribute14            VARCHAR(150),   attribute15            VARCHAR(150),created_by             VARCHAR(60) not null,   creation_date          DATE not null,   last_updated_by        VARCHAR(60) not null,   last_update_date       DATE not null,   object_version_id      NUMERIC(15) not null ) ;

comment on table PRODUCT_CATEGORIES_BASE  is 'The classification hierachy for a particular product. Categories can be nested and then a product is assigned to a particular category.  The actual names and descriptions for the categories are held in the separate CATEGORY_TRANSLATIONS table.';

comment on column PRODUCT_CATEGORIES_BASE.category_id  is 'Unique Id for the category';

comment on column PRODUCT_CATEGORIES_BASE.parent_category_id  is 'The parent of this category in the hierachy';

comment on column PRODUCT_CATEGORIES_BASE.category_locked_flag  is 'Boolean fag to define if new products may be assigned to this category or not ';

comment on column PRODUCT_CATEGORIES_BASE.representative_product_id  is 'Links to a product which will be used to provide the sample image to illustrate the whole category.';

comment on column PRODUCT_CATEGORIES_BASE.created_by  is 'History column';

comment on column PRODUCT_CATEGORIES_BASE.creation_date  is 'History column';

comment on column PRODUCT_CATEGORIES_BASE.last_updated_by  is 'History column';

comment on column PRODUCT_CATEGORIES_BASE.last_update_date  is 'History column';

comment on column PRODUCT_CATEGORIES_BASE.object_version_id  is 'History column';

alter table PRODUCT_CATEGORIES_BASE  add constraint PRODUCT_TAGS_PK primary key (CATEGORY_ID);

alter table PRODUCT_CATEGORIES_BASE  add constraint PRODUCT_CATEGORIES_LOCKED_CHK  check (CATEGORY_LOCKED_FLAG in ('Y','N'));

comment on table PRODUCTS_BASE  is 'The products that are sold';

comment on column PRODUCTS_BASE.product_id is 'The unique identifier for this product';

comment on column PRODUCTS_BASE.supplier_id  is 'The unique ID of the supplier of this product';

comment on column PRODUCTS_BASE.category_id  is 'The category to which this product beNUMBER(15)s. This category us used to help in searching for and organizing the products in the Storefront.';

comment on column PRODUCTS_BASE.product_name  is 'A descriptive name for this product.';

comment on column PRODUCTS_BASE.cost_price  is 'The amount paid to the supplier for this product';

comment on column PRODUCTS_BASE.list_price  is 'The suggested list price for the product';

comment on column PRODUCTS_BASE.min_price  is 'The agreed minimum price (after discounts) for this product';

comment on column PRODUCTS_BASE.warranty_period_months  is 'How NUMERIC(15) is the warantee for this product';

comment on column PRODUCTS_BASE.shipping_class_code  is 'Defines the weight class for this particular product. This is then used to calculate the shipping cost. Code is a lookup to the LOOKUP_CODES table with a domain of SHIPPING_CLASS_CODE';

comment on column PRODUCTS_BASE.external_url  is 'Link back to the supplier website ';

comment on column PRODUCTS_BASE.attribute_category  is 'Reserved for Applications use as Descriptive Flexfield';

comment on column PRODUCTS_BASE.attribute1  is 'Reserved for Applications use as Descriptive Flexfield';

comment on column PRODUCTS_BASE.attribute2  is 'Reserved for Applications use as Descriptive Flexfield';

comment on column PRODUCTS_BASE.attribute3  is 'Reserved for Applications use as Descriptive Flexfield';

comment on column PRODUCTS_BASE.attribute4  is 'Reserved for Applications use as Descriptive Flexfield';

comment on column PRODUCTS_BASE.attribute5  is 'Reserved for Applications use as Descriptive Flexfield';

comment on column PRODUCTS_BASE.attribute6  is 'Reserved for Applications use as Descriptive Flexfield';

comment on column PRODUCTS_BASE.attribute7  is 'Reserved for Applications use as Descriptive Flexfield';

comment on column PRODUCTS_BASE.attribute8  is 'Reserved for Applications use as Descriptive Flexfield';

comment on column PRODUCTS_BASE.attribute9  is 'Reserved for Applications use as Descriptive Flexfield';

comment on column PRODUCTS_BASE.attribute10 is 'Reserved for Applications use as Descriptive Flexfield';

comment on column PRODUCTS_BASE.attribute11 is 'Reserved for Applications use as Descriptive Flexfield';

comment on column PRODUCTS_BASE.attribute12 is 'Reserved for Applications use as Descriptive Flexfield';

comment on column PRODUCTS_BASE.attribute13 is 'Reserved for Applications use as Descriptive Flexfield';

comment on column PRODUCTS_BASE.attribute14 is 'Reserved for Applications use as Descriptive Flexfield';

comment on column PRODUCTS_BASE.created_by  is 'History column';

comment on column PRODUCTS_BASE.creation_date is 'History column';

comment on column PRODUCTS_BASE.last_updated_by  is 'History column';

comment on column PRODUCTS_BASE.last_update_date  is 'History column';

comment on column PRODUCTS_BASE.object_version_id  is 'History column';

alter table PRODUCTS_BASE  add constraint PRODUCTS_PK primary key (PRODUCT_ID);

create table CATEGORY_TRANSLATIONS (   category_id          NUMERIC(15) not null,   category_name        VARCHAR(50) not null,   category_description VARCHAR(1000),   language             VARCHAR(30) not null,   source_lang          VARCHAR(30),created_by           VARCHAR(60) not null,   creation_date        DATE not null,   last_updated_by      VARCHAR(60) not null,   last_update_date     DATE not null,   object_version_id    NUMERIC(15) not null ) ;

comment on table CATEGORY_TRANSLATIONS  is 'Holds one translation for the  category text for each lanuage supported by the system.';

comment on column CATEGORY_TRANSLATIONS.category_id  is 'Link to the category table';

comment on column CATEGORY_TRANSLATIONS.category_name  is 'Name of the category in the relevant language';

comment on column CATEGORY_TRANSLATIONS.category_description  is 'Description of the category in the relevant language';

comment on column CATEGORY_TRANSLATIONS.language  is 'Language assigned for this entry ';

comment on column CATEGORY_TRANSLATIONS.source_lang  is 'Actual language that the values are currently in. The value may not actually be translated, if LANGUAGE and SOURCE_LANG are the same then the row has been translated';

comment on column CATEGORY_TRANSLATIONS.created_by  is 'History column';

comment on column CATEGORY_TRANSLATIONS.creation_date  is 'History column';

comment on column CATEGORY_TRANSLATIONS.last_updated_by  is 'History column';

comment on column CATEGORY_TRANSLATIONS.last_update_date  is 'History column';

comment on column CATEGORY_TRANSLATIONS.object_version_id  is 'History column';

alter table CATEGORY_TRANSLATIONS  add constraint CATEGORY_TRANSLATIONS_PK primary key (CATEGORY_ID, LANGUAGE);

create table COUNTRY_CODES (   iso_country_code  VARCHAR(2) not null,   country_name      VARCHAR(100),   language          VARCHAR(30) not null,   source_lang       VARCHAR(30),created_by        VARCHAR(60) not null,   creation_date     DATE not null,   last_updated_by   VARCHAR(60) not null,   last_update_date  DATE not null,   object_version_id NUMERIC(15) not null ) ;

comment on table COUNTRY_CODES  is 'List of ISO Country codes and the name of the relevant country. This contains the translations for each country name as well. So each country code will be repeated for each supported language';

comment on column COUNTRY_CODES.iso_country_code  is 'The actual country code';

comment on column COUNTRY_CODES.country_name  is 'Translated country name';

comment on column COUNTRY_CODES.language  is 'Language that this row represents';

comment on column COUNTRY_CODES.source_lang  is 'Actual language that this row is currently in. May not necessarily match the LANGUGE value if the entry has yet to be translated';

comment on column COUNTRY_CODES.created_by  is 'History column';

comment on column COUNTRY_CODES.creation_date  is 'History column';

comment on column COUNTRY_CODES.last_updated_by  is 'History column';

comment on column COUNTRY_CODES.last_update_date  is 'History column';

comment on column COUNTRY_CODES.object_version_id  is 'History column';

alter table COUNTRY_CODES  add constraint COUNTRY_CODES_PK primary key (ISO_COUNTRY_CODE, LANGUAGE);

create table DISCOUNTS_BASE (   discount_id              NUMERIC(15) not null,   discount_type_code       VARCHAR(30) not null,   discount_amount          NUMERIC not null,   apply_as_percentage_flag VARCHAR(1) default 'N' not null,   easy_code                VARCHAR(20),   add_free_shipping_flag   VARCHAR(1) default 'N' not null,   onetime_discount_flag    VARCHAR(1) default 'Y' not null,created_by               VARCHAR(60) not null,   creation_date            DATE not null,   last_updated_by          VARCHAR(60) not null,   last_update_date         DATE not null,   object_version_id        NUMERIC(15) not null ) ;

comment on table DISCOUNTS_BASE  is 'DISCOUNTS provides modifiers to an order. A particular order may have up to two discounts applied. The base discount resulting from customer membership  enrollment and a coupon discount for one-time savings';

comment on column DISCOUNTS_BASE.discount_id  is 'Unique identifier for the discount';

comment on column DISCOUNTS_BASE.discount_type_code  is 'Type of discount referencing a lookup to the LOOKUP_TYPES table, domain DISCOUNT_TYPE_CODE';

comment on column DISCOUNTS_BASE.discount_amount  is 'The value of the discount either as a dollar amount or as a percentage (see APPLY_AS_PERCENTAGE_FLAG) ';

comment on column DISCOUNTS_BASE.apply_as_percentage_flag  is 'Boolean flag (Y/N) to define if the DISCOUNT_AMOUNT is a percentage or an absolute value';

comment on column DISCOUNTS_BASE.easy_code  is 'Short Code for use in marketing promos and email shots';

comment on column DISCOUNTS_BASE.add_free_shipping_flag  is 'Boolean Y/N: deduct shipping cost when this flag set to Y';

comment on column DISCOUNTS_BASE.onetime_discount_flag  is 'Boolean Y/N value. Can this discount only be applied once per customer?';

comment on column DISCOUNTS_BASE.created_by  is 'History column';

comment on column DISCOUNTS_BASE.creation_date  is 'History column';

comment on column DISCOUNTS_BASE.last_updated_by  is 'History column';

comment on column DISCOUNTS_BASE.last_update_date  is 'History column';

comment on column DISCOUNTS_BASE.object_version_id  is 'History column';

alter table DISCOUNTS_BASE  add constraint DISCOUNTS_PK primary key (DISCOUNT_ID);

alter table DISCOUNTS_BASE  add constraint DISCOUNTS_FREE_SHIPPING_CHK  check (ADD_FREE_SHIPPING_FLAG in ('Y','N'));

alter table DISCOUNTS_BASE  add constraint DISCOUNTS_ONETIME_CHK  check (ONETIME_DISCOUNT_FLAG in ('Y','N'));

alter table DISCOUNTS_BASE  add constraint DISCOUNT_AS_PERCENTAGE_CHK  check (APPLY_AS_PERCENTAGE_FLAG in ('Y','N'));

create table PAYMENT_OPTIONS (   payment_option_id  NUMERIC(16) not null,   customer_id        NUMERIC(15) not null,   payment_type_code  VARCHAR(30) not null,   billing_address_id INTEGER,   account_number     NUMERIC(19) not null,   card_type_code     VARCHAR(30),   expire_date        DATE,   check_digits       NUMERIC(4),   routing_identifier VARCHAR(15),   institution_name   VARCHAR(120),   valid_from_date    DATE,   valid_to_date      DATE,created_by         VARCHAR(60) not null,   creation_date      DATE not null,   last_updated_by    VARCHAR(60) not null,   last_update_date   DATE not null,   object_version_id  NUMERIC(15) not null ) ;

comment on table PAYMENT_OPTIONS  is 'The list of payment types defined for this particular customer';

comment on column PAYMENT_OPTIONS.payment_option_id  is 'Unique Id for this payment option';

comment on column PAYMENT_OPTIONS.customer_id  is 'Link to the customer';

comment on column PAYMENT_OPTIONS.payment_type_code  is 'Type of payment. Links to LOOKUP_CODES with the domain PAYMENT_TYPE_CODE';

comment on column PAYMENT_OPTIONS.billing_address_id  is 'Billing address ID if different from the primary address of the user';

comment on column PAYMENT_OPTIONS.account_number  is 'Account number of the Credit card, bank account etc.';

comment on column PAYMENT_OPTIONS.card_type_code  is 'If this is a credit/debit card what type is it. Links to LOOKUP_CODES using the domain CARD_TYPE_CODE ';

comment on column PAYMENT_OPTIONS.expire_date  is 'For a card payment when does this card expire. Input will be in the form of MM/YY. We will store as a date at the end of that specified month';

comment on column PAYMENT_OPTIONS.check_digits  is 'For a card payment this is the verification code that is usually on the signature strip';

comment on column PAYMENT_OPTIONS.routing_identifier  is 'Used when the type is direct debit. Holds the routing (sort) code of the bank';

comment on column PAYMENT_OPTIONS.institution_name  is 'If direct Debit is used the name of the bank.';

comment on column PAYMENT_OPTIONS.valid_from_date  is 'From when is this payment option valid? Will defaul to the creation date of the record, but the user may set this to the future if creating a new payment option.';

comment on column PAYMENT_OPTIONS.valid_to_date  is 'When was this payment option valid to ( in the case of a credit card this will be the end of the expiry month on the card)';

comment on column PAYMENT_OPTIONS.created_by  is 'History column';

comment on column PAYMENT_OPTIONS.creation_date  is 'History column';

comment on column PAYMENT_OPTIONS.last_updated_by  is 'History column';

comment on column PAYMENT_OPTIONS.last_update_date  is 'History column';

comment on column PAYMENT_OPTIONS.object_version_id  is 'History column';

alter table PAYMENT_OPTIONS  add constraint PAYMENT_OPTIONS_PK primary key (PAYMENT_OPTION_ID);

create table SHIPPING_OPTIONS_BASE (   shipping_option_id         NUMERIC(15) not null,   country_code               VARCHAR(2),   cost_per_class1_item       NUMERIC(8,2) not null,   cost_per_class2_item       NUMERIC(8,2) not null,   cost_per_class3_item       NUMERIC(8,2) not null,   free_shipping_allowed_flag VARCHAR(1) default 'N',created_by                 VARCHAR(60) not null,   creation_date              DATE not null,   last_updated_by            VARCHAR(60) not null,   last_update_date           DATE not null,   object_version_id          NUMERIC(15) not null ) ;

comment on table SHIPPING_OPTIONS_BASE  is 'This table drives the available shipping options for the order. This list is used by the UI and configured based on the shipping address''s country code. ';

comment on column SHIPPING_OPTIONS_BASE.shipping_option_id  is 'Unique Id for the shipping method';

comment on column SHIPPING_OPTIONS_BASE.country_code  is 'Link to the COUNTRY_CODES table. The various types of shipping have different costs for each target country. For the sake of brevity, this table is populated with costs for the a small set of countries. A null country code indicates the rest of the world as a catch all.';

comment on column SHIPPING_OPTIONS_BASE.cost_per_class1_item  is 'Unit cost for shipping CLASS1 items';

comment on column SHIPPING_OPTIONS_BASE.cost_per_class2_item  is 'Unit cost for shipping CLASS2 items';

comment on column SHIPPING_OPTIONS_BASE.cost_per_class3_item  is 'Unit cost for shipping CLASS3 items';

comment on column SHIPPING_OPTIONS_BASE.free_shipping_allowed_flag  is 'Boolean flag to indicate if this is a deductable shipping cost. In most cases this will only be set to Y for non-express shipping options';

comment on column SHIPPING_OPTIONS_BASE.created_by  is 'History column';

comment on column SHIPPING_OPTIONS_BASE.creation_date  is 'History column';

comment on column SHIPPING_OPTIONS_BASE.last_updated_by  is 'History column';

comment on column SHIPPING_OPTIONS_BASE.last_update_date  is 'History column';

comment on column SHIPPING_OPTIONS_BASE.object_version_id  is 'History column';

alter table SHIPPING_OPTIONS_BASE  add constraint SHIPPING_OPTIONS_PK primary key (SHIPPING_OPTION_ID);

alter table SHIPPING_OPTIONS_BASE  add constraint SHIPPING_OPTIONS_FREE_CHK  check (FREE_SHIPPING_ALLOWED_FLAG  in ('Y','N'));

create table WAREHOUSES (   warehouse_id      NUMERIC(15) not null,   address_id        NUMERIC(15) not null,   warehouse_name    VARCHAR(35) not null,created_by        VARCHAR(60) not null,   creation_date     DATE not null,   last_updated_by   VARCHAR(60) not null,   last_update_date  DATE not null,   object_version_id NUMERIC(15) not null ) ;

comment on table WAREHOUSES  is 'Warehouses owned by the store''s company (not individual suppliers) ';

comment on column WAREHOUSES.warehouse_id  is 'Unique Id for a warehouse';

comment on column WAREHOUSES.address_id  is 'Address of the warehouse. A warehouse can only have one location so there is a direct link to addresses here rather than a link via the ADDRESS_USAGES table.';

comment on column WAREHOUSES.created_by  is 'History column';

comment on column WAREHOUSES.creation_date  is 'History column';

comment on column WAREHOUSES.last_updated_by  is 'History column';

comment on column WAREHOUSES.last_update_date  is 'History column';

comment on column WAREHOUSES.object_version_id  is 'History column';

alter table WAREHOUSES  add constraint WAREHOUSES_PK primary key (WAREHOUSE_ID);

create table ORDERS (   order_id                NUMERIC(15) not null,   order_date              DATE not null,   order_shipped_date      DATE,   order_status_code       VARCHAR(30) not null,   order_total             NUMERIC(8,2) not null,   customer_id             NUMERIC(15) not null,   ship_to_name            VARCHAR(120),   ship_to_address_id      NUMERIC(15) not null,   ship_to_phone_number    VARCHAR(20),   shipping_option_id      NUMERIC(15) not null,   payment_option_id       NUMERIC(16),   discount_id             NUMERIC(15),   coupon_id               NUMERIC(15),   free_shipping_flag      VARCHAR(1) default 'N' not null,   customer_collect_flag   VARCHAR(1) default 'N' not null,   collection_warehouse_id NUMERIC(15),   giftwrap_flag           VARCHAR(1) default 'N' not null,   giftwrap_message        VARCHAR(2000),created_by              VARCHAR(60) not null,   creation_date           DATE not null,   last_updated_by         VARCHAR(60) not null,   last_update_date        DATE not null,   object_version_id       NUMERIC(15) not null ) ;

comment on table ORDERS  is 'Orders holds the core order information';

comment on column ORDERS.order_id  is 'Unique identifier for an order';

comment on column ORDERS.order_date  is 'Date on which the order was placed';

comment on column ORDERS.order_shipped_date  is 'Date on which the order was shipped. Note that the system does not provide for splitting orders into muliple parts for shipping purposes. Well we never said it was real!';

comment on column ORDERS.order_status_code  is 'What status the order is currently in. Links to the LOOKUP_CODES table using the domain ORDER_STATUS_CODE ';

comment on column ORDERS.order_total  is 'The calculated total for the order based on the products (and quantity) ordered. This value does not include shipping costs.';

comment on column ORDERS.customer_id  is 'Link to the customer placing the order';

comment on column ORDERS.ship_to_name  is 'The name to address this package to. If null then the name will be constructed from the Customer record';

comment on column ORDERS.ship_to_address_id  is 'Direct reference to the shipping address. The UI will generally default this to the primary address of the customer.';

comment on column ORDERS.ship_to_phone_number  is 'Contact phone number for the delivery guy. If null, the phone number of the Customer will be used';

comment on column ORDERS.shipping_option_id  is 'How should this order be shipped';

comment on column ORDERS.payment_option_id  is 'What form of payment will be used';

comment on column ORDERS.discount_id  is 'If the customer has a membership of some sort this will link to the discount level provided by that membership';

comment on column ORDERS.coupon_id  is 'link to a one-off coupon used with this order';

comment on column ORDERS.free_shipping_flag  is 'Boolean flag to indicate if shipping costs for basic shipping will be deducted. This flag only takes effect when the FREE_SHIPPING_ALLOWED_FLAG flag is set in the selected Shipping option';

comment on column ORDERS.customer_collect_flag  is 'Indicates if this order will be collected from a warehouse rather than being shipped';

comment on column ORDERS.collection_warehouse_id  is 'If the CUSTOMER_COLLECT_FLAG is set, this column will hold the warehouse that the customer will elect to collect from ';

comment on column ORDERS.giftwrap_flag  is 'Boolean Y/N';

comment on column ORDERS.giftwrap_message  is 'Message to be printed and included in a Giftwrapped order.';

comment on column ORDERS.created_by  is 'History column';

comment on column ORDERS.creation_date  is 'History column';

comment on column ORDERS.last_updated_by  is 'History column';

comment on column ORDERS.last_update_date  is 'History column';

comment on column ORDERS.object_version_id  is 'History column';

alter table ORDERS  add constraint ORDERS_PK primary key (ORDER_ID);

create table COUPON_USAGES (   customer_id       NUMERIC(15) not null,   discount_id       NUMERIC(15) not null,   applied_date      DATE not null,   order_id          NUMERIC(15) not null,created_by        VARCHAR(60) not null,   creation_date     DATE not null,   last_updated_by   VARCHAR(60) not null,   last_update_date  DATE not null,   object_version_id NUMERIC(15) not null ) ;

comment on table COUPON_USAGES  is 'Associates the use of One-time discounts (coupons) with a particular customer.  When the customer attempts to apply a coupon to a transaction, this table will be checked to see if they have already used this coupon.';

comment on column COUPON_USAGES.customer_id  is 'Link to the customer using the coupon (discount)';

comment on column COUPON_USAGES.discount_id  is 'Link to the discount being applied ';

comment on column COUPON_USAGES.applied_date  is 'When was the discount used';

comment on column COUPON_USAGES.order_id  is 'The order for which this discount was used.';

comment on column COUPON_USAGES.created_by  is 'History column';

comment on column COUPON_USAGES.creation_date  is 'History column';

comment on column COUPON_USAGES.last_updated_by  is 'History column';

comment on column COUPON_USAGES.last_update_date  is 'History column';

comment on column COUPON_USAGES.object_version_id  is 'History column';

alter table COUPON_USAGES  add constraint COUPON_USAGES_PK primary key (CUSTOMER_ID, DISCOUNT_ID);

create table CUSTOMER_IDENTIFICATIONS (   customer_id              NUMERIC(15) not null,   id_type_code             VARCHAR(30) not null,   id_detail                VARCHAR(20) not null,   additional_information   VARCHAR(1000),   verified_flag            VARCHAR(1) default 'N' not null,   verified_date            DATE,   verified_by              NUMERIC(15),   verification_method_code VARCHAR(30),created_by               VARCHAR(60) not null,   creation_date            DATE not null,   last_updated_by          VARCHAR(60) not null,   last_update_date         DATE not null,   object_version_id        NUMERIC(15) not null ) ;

comment on table CUSTOMER_IDENTIFICATIONS  is 'Various forms of identification provided by a customer. Confirmed identity will be used to configure the rules used during the order process, allowing higer spending and less manual verification';

comment on column CUSTOMER_IDENTIFICATIONS.customer_id  is 'Link to the persons table';

comment on column CUSTOMER_IDENTIFICATIONS.id_type_code  is 'The type of identity provided by the customer. A look up in the CODE_LOOKUPS table with the domain of ID_TYPE_CODE';

comment on column CUSTOMER_IDENTIFICATIONS.id_detail  is 'The relevant number corresponding to the selected ID type';

comment on column CUSTOMER_IDENTIFICATIONS.additional_information  is 'Free form text for staff use';

  comment on column CUSTOMER_IDENTIFICATIONS.verified_flag  is 'Boolean Y/N, has this piece of ID been verified ';

comment on column CUSTOMER_IDENTIFICATIONS.verified_date  is 'Date / time that the verification took place';

comment on column CUSTOMER_IDENTIFICATIONS.verified_by  is 'Id of the Staff member who verified the record';

comment on column CUSTOMER_IDENTIFICATIONS.verification_method_code  is 'The method of verification. A lookup in the LOOKUP_CODES table referencing the VERIFICATION_METHOD_CODE domain';

comment on column CUSTOMER_IDENTIFICATIONS.created_by  is 'History column';

comment on column CUSTOMER_IDENTIFICATIONS.creation_date  is 'History column';

comment on column CUSTOMER_IDENTIFICATIONS.last_updated_by  is 'History column';

comment on column CUSTOMER_IDENTIFICATIONS.last_update_date  is 'History column';

comment on column CUSTOMER_IDENTIFICATIONS.object_version_id  is 'History column';

alter table CUSTOMER_IDENTIFICATIONS   add constraint VERIFIED_ID_PK primary key (CUSTOMER_ID);

alter table CUSTOMER_IDENTIFICATIONS   add constraint CUSTOMER_ID_VERIFY_CHK   check (VERIFIED_FLAG in ('Y','N'));

create table CUSTOMER_INTERESTS (   customer_id           NUMERIC(15) not null,   customer_interests_id NUMERIC(15) not null,   category_id           NUMERIC(15) not null,created_by            VARCHAR(60) not null,   creation_date         DATE not null,   last_updated_by       VARCHAR(60) not null,   last_update_date      DATE not null,   object_version_id     NUMERIC(15) not null ) ;

comment on table CUSTOMER_INTERESTS  is 'The table is used to record the product categories that are of interest to the customer. This information is used to generate the recomendations list on the home page';

comment on column CUSTOMER_INTERESTS.customer_id  is 'Unique Id for the customer';

comment on column CUSTOMER_INTERESTS.category_id  is 'The Id iof the category that they are interested in ';

comment on column CUSTOMER_INTERESTS.created_by  is 'History column';

comment on column CUSTOMER_INTERESTS.creation_date  is 'History column';

comment on column CUSTOMER_INTERESTS.last_updated_by  is 'History column';

comment on column CUSTOMER_INTERESTS.last_update_date  is 'History column';

comment on column CUSTOMER_INTERESTS.object_version_id  is 'History column';

alter table CUSTOMER_INTERESTS  add constraint CUSTOMER_INTERESTS_PK primary key (CUSTOMER_INTERESTS_ID);

alter table CUSTOMER_INTERESTS  add constraint CUSTOMER_CATEGORY_ID_UNIQUE unique (CUSTOMER_ID, CATEGORY_ID);

create table DEMO_OPTIONS (   key   VARCHAR(40) not null,   value          VARCHAR(120),   java_data_type VARCHAR(120) default 'java.lang.String' not null,   description    VARCHAR(4000) not null ) ;

comment on table DEMO_OPTIONS  is 'Demo Settings defines the various options within the demo which are switched on. It also caches general configuration information such as email addresses and phone numbers to use as overrides in a demo scenario (where emails etc. may be fake)';

comment on column DEMO_OPTIONS.key  is 'Key Value to identify the preference. This will use a basic dot notation in the naming. e.g.  "override.customer.email"';

comment on column DEMO_OPTIONS.value  is 'The value for the property. If this is set to NULL then the behavior of the preference will depend on context. For example setting an "override.*" property to null will indicate that the override is not in use and the real value will be used.  The type of a preference will genarlly be String. However, should analternative type be required the value here should be valid for that type and the JAVA_DATA_TYPE set accordingly';

comment on column DEMO_OPTIONS.java_data_type  is 'Data Type of the setting value';

comment on column DEMO_OPTIONS.description  is 'Describes the use of the setting. All settings must be fully explained and define what the valid values are.';

alter table DEMO_OPTIONS  add constraint DEMO_OPTIONS_PK primary key (KEY);

create table DISCOUNT_TRANSLATIONS (   discount_translations_id NUMERIC(15) not null,   discount_id              NUMERIC(15) not null,   description              VARCHAR(4000) not null,   language                 VARCHAR(30) not null,   source_language          VARCHAR(15) not null,created_by               VARCHAR(60) not null,   creation_date            DATE not null,   last_updated_by          VARCHAR(60) not null,   last_update_date         DATE not null,   object_version_id        NUMERIC(15) not null ) ;

comment on table DISCOUNT_TRANSLATIONS  is 'Holds translations of the discount description text';

comment on column DISCOUNT_TRANSLATIONS.discount_id  is 'Link to the base discount table';

comment on column DISCOUNT_TRANSLATIONS.description  is 'The translated description';

comment on column DISCOUNT_TRANSLATIONS.language  is 'The language that this translation row represents ';

comment on column DISCOUNT_TRANSLATIONS.source_language  is 'The actual language that this row is in - it may not match the LANGUAGE column if the row has not actually been translated yet';

comment on column DISCOUNT_TRANSLATIONS.created_by  is 'History column';

comment on column DISCOUNT_TRANSLATIONS.creation_date  is 'History column';

comment on column DISCOUNT_TRANSLATIONS.last_updated_by  is 'History column';

comment on column DISCOUNT_TRANSLATIONS.last_update_date  is 'History column';

comment on column DISCOUNT_TRANSLATIONS.object_version_id  is 'History column';

alter table DISCOUNT_TRANSLATIONS  add constraint DISCOUNT_TRANSLATIONS_PK primary key (DISCOUNT_TRANSLATIONS_ID);


create table ELIGIBLE_DISCOUNTS (   membership_id     NUMERIC(15) not null,   discount_id       NUMERIC(15) not null,   valid_from_date   DATE,   valid_to_date     DATE,created_by        VARCHAR(60) not null,   creation_date     DATE not null,   last_updated_by   VARCHAR(60) not null,   last_update_date  DATE not null,   object_version_id NUMERIC(15) not null ) ;

comment on table ELIGIBLE_DISCOUNTS  is 'Maps the available discounts to a particular membership. Note that One-Time discounts (Coupons) cannot be allocated to memberships in this way.';

comment on column ELIGIBLE_DISCOUNTS.membership_id  is 'Link to the membership table';

comment on column ELIGIBLE_DISCOUNTS.discount_id  is 'Link to the relevant discount';

comment on column ELIGIBLE_DISCOUNTS.valid_from_date  is 'If the life of the discount is restricted, this is the start date (inclusive)';

comment on column ELIGIBLE_DISCOUNTS.valid_to_date  is 'If the life of the discount is restricted, this is the end date (inclusive)';

comment on column ELIGIBLE_DISCOUNTS.created_by  is 'History column';

comment on column ELIGIBLE_DISCOUNTS.creation_date  is 'History column';

comment on column ELIGIBLE_DISCOUNTS.last_updated_by  is 'History column';

comment on column ELIGIBLE_DISCOUNTS.last_update_date  is 'History column';

comment on column ELIGIBLE_DISCOUNTS.object_version_id  is 'History column';

alter table ELIGIBLE_DISCOUNTS  add constraint ELIGIBLE_DISCOUNTS_PK primary key (DISCOUNT_ID, MEMBERSHIP_ID);



create table HELP_TRANSLATIONS (   help_translations_id NUMERIC(15) not null,   help_id              NUMERIC(15) not null,   help_usage           VARCHAR(200) not null,   help_text            VARCHAR(2000) not null,   language             VARCHAR(30) not null,   source_language      VARCHAR(15) not null,created_by           VARCHAR(60) not null,   creation_date        DATE not null,   last_updated_by      VARCHAR(60) not null,   last_update_date     DATE not null,   object_version_id    NUMERIC(15) not null ) ;

comment on table HELP_TRANSLATIONS  is 'Holds translations of the application help text';

comment on column HELP_TRANSLATIONS.help_id  is 'Reserved for future use - the link to a base help table';

comment on column HELP_TRANSLATIONS.help_usage  is 'The usage of this text as it relates to the application';

comment on column HELP_TRANSLATIONS.help_text  is 'The translated help text';

comment on column HELP_TRANSLATIONS.language  is 'The language that this translation row represents ';

comment on column HELP_TRANSLATIONS.source_language  is 'The actual language that this row is in - it may not match the LANGUAGE column if the row has not actually been translated yet';

comment on column HELP_TRANSLATIONS.created_by  is 'History column';

comment on column HELP_TRANSLATIONS.creation_date  is 'History column';

comment on column HELP_TRANSLATIONS.last_updated_by  is 'History column';

comment on column HELP_TRANSLATIONS.last_update_date  is 'History column';

comment on column HELP_TRANSLATIONS.object_version_id  is 'History column';

alter table HELP_TRANSLATIONS  add constraint HELP_TRANSLATIONS_PK primary key (HELP_TRANSLATIONS_ID);

create table LOOKUP_CODES (   lookup_type       VARCHAR(30) not null,   lookup_code       VARCHAR(30) not null,   meaning           VARCHAR(80) not null,   description       VARCHAR(240),   language          VARCHAR(30) not null,   source_lang       VARCHAR(30) not null,created_by        VARCHAR(60) not null,   creation_date     DATE not null,   last_updated_by   VARCHAR(60) not null,   last_update_date  DATE not null,   object_version_id NUMERIC(15) not null ) ;

comment on table LOOKUP_CODES  is 'Codes used throughout the system following the standard pattern of code Domains specifying to what a code is used for. ';

comment on column LOOKUP_CODES.lookup_type  is 'The domain to use ';

comment on column LOOKUP_CODES.lookup_code  is 'The code to match';

comment on column LOOKUP_CODES.meaning  is 'What the code means';

comment on column LOOKUP_CODES.description  is 'Further qualification of the meaning';

comment on column LOOKUP_CODES.language  is 'The language that this row represents';

comment on column LOOKUP_CODES.source_lang  is 'The actual language that the strings in this row are in - this may not match the LANGUAGE column if the row has not yet been translated';

comment on column LOOKUP_CODES.created_by  is 'History column';

comment on column LOOKUP_CODES.creation_date  is 'History column';

comment on column LOOKUP_CODES.last_updated_by  is 'History column';

comment on column LOOKUP_CODES.last_update_date  is 'History column';

comment on column LOOKUP_CODES.object_version_id  is 'History column';

alter table LOOKUP_CODES  add constraint LOOKUP_CODES_PK primary key (LOOKUP_TYPE, LOOKUP_CODE, LANGUAGE);

create table MEMBERSHIP_TRANSLATIONS (   membership_translations_id NUMERIC(15) not null,   membership_id              NUMERIC(15) not null,   membership_name            VARCHAR(120) not null,   description                VARCHAR(2000),   language                   VARCHAR(30) not null,   source_language            VARCHAR(15) not null,created_by                 VARCHAR(60) not null,   creation_date              DATE not null,   last_updated_by            VARCHAR(60) not null,   last_update_date           DATE not null,   object_version_id          NUMERIC(15) not null ) ;

comment on column MEMBERSHIP_TRANSLATIONS.membership_id  is 'Link to the membership record that this translation is for';

comment on column MEMBERSHIP_TRANSLATIONS.membership_name  is 'Name of this particular membership';

comment on column MEMBERSHIP_TRANSLATIONS.description  is 'Free text description of the membership';

comment on column MEMBERSHIP_TRANSLATIONS.language  is 'Language which this particular row represents';

comment on column MEMBERSHIP_TRANSLATIONS.source_language  is 'Language in which this particular row is actually encoded. If the row has not been translated yet it will not be the same as the LANGUAGE column';

comment on column MEMBERSHIP_TRANSLATIONS.created_by  is 'History column';

comment on column MEMBERSHIP_TRANSLATIONS.creation_date  is 'History column';

comment on column MEMBERSHIP_TRANSLATIONS.last_updated_by  is 'History column';

comment on column MEMBERSHIP_TRANSLATIONS.last_update_date  is 'History column';

comment on column MEMBERSHIP_TRANSLATIONS.object_version_id  is 'History column';

alter table MEMBERSHIP_TRANSLATIONS  add constraint MEMBERSHIP_TRANSLATIONS_PK primary key (MEMBERSHIP_TRANSLATIONS_ID);


create table ORDER_ITEMS (   order_id          NUMERIC(15) not null,   line_item_id      NUMERIC(15) not null,   product_id        NUMERIC(15) not null,   quantity          NUMERIC(6) default 1 not null,   unit_price        NUMERIC(8,2) not null,created_by        VARCHAR(60) not null,   creation_date     DATE not null,   last_updated_by   VARCHAR(60) not null,   last_update_date  DATE not null,   object_version_id NUMERIC(15) not null ) ;

comment on table ORDER_ITEMS  is 'Holds the order lines';

comment on column ORDER_ITEMS.order_id  is 'ID of the associated Order';

comment on column ORDER_ITEMS.line_item_id  is 'Line number of this item';

comment on column ORDER_ITEMS.product_id  is 'Product being purchased';

comment on column ORDER_ITEMS.quantity  is 'Number of units of this product in the purchase';

comment on column ORDER_ITEMS.unit_price  is 'Price per unit';

comment on column ORDER_ITEMS.created_by  is 'History column';

comment on column ORDER_ITEMS.creation_date  is 'History column';

comment on column ORDER_ITEMS.last_updated_by  is 'History column';

comment on column ORDER_ITEMS.last_update_date  is 'History column';

comment on column ORDER_ITEMS.object_version_id  is 'History column';

create index INDEX_ORDER_ITEMS_ORDID_PRODID on ORDER_ITEMS (ORDER_ID, PRODUCT_ID);

create index INDEX_ORDER_ITEMS_PRODID on ORDER_ITEMS (PRODUCT_ID);

alter table ORDER_ITEMS  add constraint ORDER_ITEMS_PK primary key (ORDER_ID, LINE_ITEM_ID);



create table PRODUCT_IMAGES (   product_image_id  NUMERIC(15) not null,   product_id        NUMERIC(15) not null,   default_view_flag VARCHAR(1) default 'N' not null,   detail_image_id   NUMERIC(15),   image             bytea not null,created_by        VARCHAR(60) not null,   creation_date     DATE not null,   last_updated_by   VARCHAR(60) not null,   last_update_date  DATE not null,   object_version_id NUMERIC(15) not null ) ;

comment on table PRODUCT_IMAGES is 'Images of each product. A product many have several images available, only one of which will be marked as primary. Imgaes may also be thumbnails in which case the detailed version is pointed to by the DETAIL_IMAGE_ID';

comment on column PRODUCT_IMAGES.product_image_id is 'Unique Id for images';

comment on column PRODUCT_IMAGES.product_id is 'Link to the associated product';

comment on column PRODUCT_IMAGES.default_view_flag   is 'Only one image can be the default view. This will be the image show in the main catelog. Only one image for a particular product may have this flag set';

comment on column PRODUCT_IMAGES.detail_image_id  is 'Allows for a drilldown from thumbnail view to a detailed version of the image';

comment on column PRODUCT_IMAGES.image  is 'The image to show';

comment on column PRODUCT_IMAGES.created_by is 'History column';

comment on column PRODUCT_IMAGES.creation_date is 'History column';

comment on column PRODUCT_IMAGES.last_updated_by is 'History column';

comment on column PRODUCT_IMAGES.last_update_date is 'History column';

comment on column PRODUCT_IMAGES.object_version_id is 'History column';

alter table PRODUCT_IMAGES add constraint PRODUCT_IMAGES_PK primary key (PRODUCT_IMAGE_ID);



alter table PRODUCT_IMAGES add constraint PRODUCT_IMAGES_DEFAULT_CHK check (DEFAULT_VIEW_FLAG in ('Y','N'));

create table PRODUCT_TRANSLATIONS (   product_id        NUMERIC(15) not null,   language          VARCHAR(30) not null,   source_lang       VARCHAR(30),   description       VARCHAR(4000) not null,   additional_info   VARCHAR(4000),created_by        VARCHAR(60) not null,   creation_date     DATE not null,   last_updated_by   VARCHAR(60) not null,   last_update_date  DATE not null,   object_version_id NUMERIC(15) not null ) ;

comment on table PRODUCT_TRANSLATIONS is 'Holds the translated names and descriptions of the product. One translation row will exist for each language supported by the system and each product';

comment on column PRODUCT_TRANSLATIONS.product_id is 'Link to the product';

comment on column PRODUCT_TRANSLATIONS.language  is 'Language code for this entry';

comment on column PRODUCT_TRANSLATIONS.source_lang is 'Actual language that this entry is in. If the entry has not yet been translated this value may be different from the defined LANGUAGE of the entry';

comment on column PRODUCT_TRANSLATIONS.description  is 'Translated description of the product ';

comment on column PRODUCT_TRANSLATIONS.additional_info  is 'More ionformation about the product such as technical specifications';

comment on column PRODUCT_TRANSLATIONS.created_by   is 'History column';

comment on column PRODUCT_TRANSLATIONS.creation_date   is 'History column';

comment on column PRODUCT_TRANSLATIONS.last_updated_by  is 'History column';

comment on column PRODUCT_TRANSLATIONS.last_update_date  is 'History column';

comment on column PRODUCT_TRANSLATIONS.object_version_id  is 'History column';

alter table PRODUCT_TRANSLATIONS add constraint PRODUCT_TRANSLATIONS_PK primary key (PRODUCT_ID, LANGUAGE);


create table SHIPPING_OPTION_TRANSLATIONS (   shipping_translations_id NUMERIC(15) not null,   shipping_option_id       NUMERIC(15) not null,   shipping_method          VARCHAR(100) not null,   language                 VARCHAR(30) not null,   source_lang              VARCHAR(4000) not null,created_by               VARCHAR(60) not null,   creation_date            DATE not null,   last_updated_by          VARCHAR(60) not null,   last_update_date         DATE not null,   object_version_id        NUMERIC(15) not null ) ;

comment on table SHIPPING_OPTION_TRANSLATIONS is 'Holds the translated shipping option description. One translation will exist for each supported language and shipping option combination';

comment on column SHIPPING_OPTION_TRANSLATIONS.shipping_option_id is 'Link to the shipping option ';

comment on column SHIPPING_OPTION_TRANSLATIONS.shipping_method is 'Translated description';

comment on column SHIPPING_OPTION_TRANSLATIONS.language is 'The language that this row represents';

comment on column SHIPPING_OPTION_TRANSLATIONS.source_lang is 'The actual language that this entry is currently in. This value may not match the LANGUAGE column if the entry has yet to be translated.';

comment on column SHIPPING_OPTION_TRANSLATIONS.created_by is 'History column';

comment on column SHIPPING_OPTION_TRANSLATIONS.creation_date is 'History column';

comment on column SHIPPING_OPTION_TRANSLATIONS.last_updated_by is 'History column';

comment on column SHIPPING_OPTION_TRANSLATIONS.last_update_date is 'History column';

comment on column SHIPPING_OPTION_TRANSLATIONS.object_version_id is 'History column';

alter table SHIPPING_OPTION_TRANSLATIONS add constraint SHIPPING_OPTION_TRANSLATI_PK primary key (SHIPPING_TRANSLATIONS_ID);


create table WAREHOUSE_STOCK_LEVELS (   product_id        NUMERIC(15) not null,   warehouse_id      NUMERIC(15) not null,   quantity_on_hand  NUMERIC(8) not null,created_by        VARCHAR(60) not null,   creation_date     DATE not null,   last_updated_by   VARCHAR(60) not null,   last_update_date  DATE not null,   object_version_id NUMERIC(15) not null );

 comment on table WAREHOUSE_STOCK_LEVELS  is 'Holds information about the stock levels for a particular product in each warehouse.';

comment on column WAREHOUSE_STOCK_LEVELS.product_id  is 'Link to the product table';

comment on column WAREHOUSE_STOCK_LEVELS.warehouse_id  is 'The warehouse in question ';

comment on column WAREHOUSE_STOCK_LEVELS.quantity_on_hand  is 'The stock level of this product';

comment on column WAREHOUSE_STOCK_LEVELS.created_by  is 'History column';

comment on column WAREHOUSE_STOCK_LEVELS.creation_date  is 'History column';

comment on column WAREHOUSE_STOCK_LEVELS.last_updated_by  is 'History column';

comment on column WAREHOUSE_STOCK_LEVELS.last_update_date  is 'History column';

comment on column WAREHOUSE_STOCK_LEVELS.object_version_id  is 'History column';

alter table WAREHOUSE_STOCK_LEVELS  add constraint WAREHOUSE_STOCK_LEVELS_PK primary key (PRODUCT_ID, WAREHOUSE_ID);


create table "user" (id NUMERIC(15) not null,   username VARCHAR(40) not null,   password  VARCHAR(80) not null , UNIQUE(username));
alter table "user"   add constraint USER_PK primary key (id);

create table ROLE (id NUMERIC(15) not null,   name VARCHAR(20) not null , unique(name));
alter table ROLE  add constraint ROLE_PK primary key (id);

create table user_role(user_id NUMERIC(15) not null,   role_id Numeric(15) not null);
alter table user_role  add constraint user_role_PK primary key (user_id, role_id);



create sequence ADDRESS_SEQ;
create sequence ADDRESS_USAGES_SEQ;
create sequence CATEGORY_SEQ;
create sequence CUSTOMER_INTERESTS_SEQ;
create sequence DISCOUNT_SEQ;
create sequence DISCOUNT_TRANSLATIONS_SEQ;
create sequence HELP_TRANSLATIONS_SEQ;
create sequence MEMBER_SEQ;
create sequence MEMBER_TRANSLATIONS_SEQ;
create sequence ORDER_ITEMS_SEQ;
create sequence ORDER_SEQ;
create sequence PAYMENT_OPTION_SEQ;
create sequence PERSON_SEQ;
create sequence PRODUCT_IMAGE_SEQ;
create sequence PRODUCT_SEQ;
create sequence SHIPPING_OPTION_SEQ;
create sequence SHIPPING_TRANSLATIONS_SEQ;
create sequence SUPPLIER_SEQ;
create sequence WAREHOUSE_SEQ;

