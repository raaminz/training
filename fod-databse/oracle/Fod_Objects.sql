--------------------------------------------------
-- Export file for user FOD                     --
-- Created by Hosein on 10/11/2013, 12:29:47 PM --
--------------------------------------------------

set define off
spool sd.log

prompt
prompt Creating table ADDRESSES
prompt ========================
prompt
create table ADDRESSES
(
  address_id        NUMBER(15) not null,
  address1          VARCHAR2(40) not null,
  address2          VARCHAR2(40),
  city              VARCHAR2(40) not null,
  postal_code       VARCHAR2(12),
  state_province    VARCHAR2(40) not null,
  country_id        CHAR(2) not null,
  longitude         NUMBER,
  latitude          NUMBER,
  created_by        VARCHAR2(60) not null,
  creation_date     DATE not null,
  last_updated_by   VARCHAR2(60) not null,
  last_update_date  DATE not null,
  object_version_id NUMBER(15) not null
)
;
comment on table ADDRESSES
  is 'The shared address table that is used to hold customer addresses, shipping addresses, warehouse addresses and so on. ';
comment on column ADDRESSES.address_id
  is 'Unique identifier for an address';
comment on column ADDRESSES.address1
  is 'First Line of the Address e.g. Street / Apartment number';
comment on column ADDRESSES.address2
  is 'Second line of adress if required';
comment on column ADDRESSES.city
  is 'Postal city or town';
comment on column ADDRESSES.state_province
  is 'If in the  US, this will be restricted to the US States, otherwise this will be free form.';
comment on column ADDRESSES.country_id
  is 'ISO country code. See the COUNTRY_CODES table';
comment on column ADDRESSES.longitude
  is 'Grid reference information for use in map mashups';
comment on column ADDRESSES.latitude
  is 'Grid reference information for use in map mashups';
comment on column ADDRESSES.created_by
  is 'History column';
comment on column ADDRESSES.creation_date
  is 'History column';
comment on column ADDRESSES.last_updated_by
  is 'History column';
comment on column ADDRESSES.last_update_date
  is 'History column';
comment on column ADDRESSES.object_version_id
  is 'History column';
alter table ADDRESSES
  add constraint ADDRESSES_PK primary key (ADDRESS_ID);

prompt
prompt Creating table SUPPLIERS
prompt ========================
prompt
create table SUPPLIERS
(
  supplier_id       NUMBER(15) not null,
  supplier_name     VARCHAR2(120) not null,
  supplier_status   VARCHAR2(30) not null,
  phone_number      VARCHAR2(20),
  email             VARCHAR2(255),
  ui_skin           VARCHAR2(60),
  created_by        VARCHAR2(60) not null,
  creation_date     DATE not null,
  last_updated_by   VARCHAR2(60) not null,
  last_update_date  DATE not null,
  object_version_id NUMBER(15) not null
)
;
comment on table SUPPLIERS
  is 'This table holds a list of product suppliers';
comment on column SUPPLIERS.supplier_id
  is 'Unique identifier for a supplier';
comment on column SUPPLIERS.supplier_name
  is 'Supplier Name';
comment on column SUPPLIERS.created_by
  is 'History column';
comment on column SUPPLIERS.creation_date
  is 'History column';
comment on column SUPPLIERS.last_updated_by
  is 'History column';
comment on column SUPPLIERS.last_update_date
  is 'History column';
comment on column SUPPLIERS.object_version_id
  is 'History column';
alter table SUPPLIERS
  add constraint SUPPLIERS_PK primary key (SUPPLIER_ID);

prompt
prompt Creating table MEMBERSHIPS_BASE
prompt ===============================
prompt
create table MEMBERSHIPS_BASE
(
  membership_id        NUMBER(15) not null,
  membership_type_code VARCHAR2(30) not null,
  contact_id           NUMBER(15) not null,
  created_by           VARCHAR2(60) not null,
  creation_date        DATE not null,
  last_updated_by      VARCHAR2(60) not null,
  last_update_date     DATE not null,
  object_version_id    NUMBER(15) not null
)
;
comment on table MEMBERSHIPS_BASE
  is 'The memberships table holds information about corporate and group membership programs. Particular discounts (see ELIGIBLE_DISCOUNTS) are associated with a membership.  Memberships may be personal,  group, coroprate or partner Note that this table is not translated.';
comment on column MEMBERSHIPS_BASE.membership_id
  is 'Unique Id for a memberships';
comment on column MEMBERSHIPS_BASE.membership_type_code
  is 'Typ[e of membership, references LOOKUP_CODES; domain: MEMBERSHIP_TYPE_CODE';
comment on column MEMBERSHIPS_BASE.contact_id
  is 'Link to the customer who is the named contact for this particular membership. This is mainly of interest to Group, Corporate and Partner memberships where many users will be associated with the same membership number';
comment on column MEMBERSHIPS_BASE.created_by
  is 'History column';
comment on column MEMBERSHIPS_BASE.creation_date
  is 'History column';
comment on column MEMBERSHIPS_BASE.last_updated_by
  is 'History column';
comment on column MEMBERSHIPS_BASE.last_update_date
  is 'History column';
comment on column MEMBERSHIPS_BASE.object_version_id
  is 'History column';
alter table MEMBERSHIPS_BASE
  add constraint MEMBERSHIPS_BASE_PK primary key (MEMBERSHIP_ID);

prompt
prompt Creating table PERSONS
prompt ======================
prompt
create table PERSONS
(
  person_id                   NUMBER(15) not null,
  principal_name              VARCHAR2(60) not null,
  title                       VARCHAR2(12),
  first_name                  VARCHAR2(30),
  last_name                   VARCHAR2(30),
  person_type_code            VARCHAR2(30) not null,
  supplier_id                 NUMBER(15),
  provisioned_flag            VARCHAR2(1) default 'N',
  primary_address_id          NUMBER(15),
  registered_date             DATE,
  membership_id               NUMBER(15),
  email                       VARCHAR2(25) not null,
  confirmed_email             VARCHAR2(25),
  phone_number                VARCHAR2(20),
  mobile_phone_number         VARCHAR2(20),
  credit_limit                NUMBER(9,2),
  date_of_birth               DATE,
  marital_status_code         VARCHAR2(30) not null,
  gender                      VARCHAR2(1) not null,
  children_under_18           NUMBER(2),
  approximate_income          NUMBER(15),
  contact_method_code         VARCHAR2(30),
  contactable_flag            VARCHAR2(1) default 'Y' not null,
  contact_by_affilliates_flag VARCHAR2(1) default 'Y' not null,
  created_by                  VARCHAR2(60) not null,
  creation_date               DATE not null,
  last_updated_by             VARCHAR2(60) not null,
  last_update_date            DATE not null,
  object_version_id           NUMBER(15) not null
)
;
comment on table PERSONS
  is 'The core person information table';
comment on column PERSONS.person_id
  is 'Unique Identifier for a Person';
comment on column PERSONS.principal_name
  is 'Associates this person record with a security username (principle name) from LDAP or whatever security credential store is in use. ';
comment on column PERSONS.person_type_code
  is 'Descriminator column: Customer or Staff. References LOOKUP_CODES, domain PERSON_TYPE_CODE';
comment on column PERSONS.provisioned_flag
  is 'Boolean (Y/N) flag used to indicate if a person has been provisioned (created) in the security repository';
comment on column PERSONS.primary_address_id
  is 'Main address of the person. This will be used as the default for filling in forms etc.';
comment on column PERSONS.registered_date
  is 'The date that this person was registered on the system - note that this may not match the CREATION_DATE if the customer delays in confirming the registration.  The CREATION_DATE records when the record was created in the table, the REGISTERED_DATE records when the registration was finally confirmed. Implicitly a record with no REGISTRATION_DATE is a person who has begun, but not completed the registration process';
comment on column PERSONS.membership_id
  is 'Customers may enroll in the membership program either using an ID unique to them or a shared Partner or Corporate ID';
comment on column PERSONS.email
  is 'Contact email for the person. If this needs to be updated once the record is created then the user will either have to call customer support, or if they use the UI then they will have to confirm the email address change from the old email address (CONFIRMED_EMAIL) before it is finalised. Once the new address is confirmed both EMAIL and CONFIRMED_EMAIL will be set to the same value.';
comment on column PERSONS.confirmed_email
  is 'The confirmed email column holds the last known good email address for the user. This will be set during the confirmation (identity verification) stage of the registration and as part of the final step of an email change operation';
comment on column PERSONS.phone_number
  is 'Primary contact number';
comment on column PERSONS.credit_limit
  is 'Calculated credit limit for this person used by the various rules within the shipping process';
comment on column PERSONS.marital_status_code
  is 'Link to the LOOKUP_CODES table, MARITAL_STATUS_DOMAIN';
comment on column PERSONS.gender
  is 'Three way flag M - Male, F - Female, D - Decline to Answer';
comment on column PERSONS.approximate_income
  is 'Income  rounded - no precision needed';
comment on column PERSONS.contact_method_code
  is 'Link to the LOOKUP_CODES table, domain: CONTACT_METHOD_CODE';
comment on column PERSONS.contactable_flag
  is 'Can the person be contacted with great offers by us? ';
comment on column PERSONS.contact_by_affilliates_flag
  is 'Can the person be contacted with great offers by our carefully chosen partners? ';
comment on column PERSONS.created_by
  is 'History column';
comment on column PERSONS.creation_date
  is 'History column';
comment on column PERSONS.last_updated_by
  is 'History column';
comment on column PERSONS.last_update_date
  is 'History column';
comment on column PERSONS.object_version_id
  is 'History column';
alter table PERSONS
  add constraint PERSONS_PK primary key (PERSON_ID);
alter table PERSONS
  add constraint PERSONS_ADDRESSES_FK foreign key (PRIMARY_ADDRESS_ID)
  references ADDRESSES (ADDRESS_ID);
alter table PERSONS
  add constraint PERSONS_MEMBERSHIPS_BASE_FK foreign key (MEMBERSHIP_ID)
  references MEMBERSHIPS_BASE (MEMBERSHIP_ID);
alter table PERSONS
  add constraint PERSON_SUPPLIER_FK foreign key (SUPPLIER_ID)
  references SUPPLIERS (SUPPLIER_ID);
alter table PERSONS
  add constraint PERSONS_AFF_CONTACT_CHK
  check (CONTACT_BY_AFFILLIATES_FLAG in ('Y','N'));
alter table PERSONS
  add constraint PERSONS_CONTACT_CHK
  check (CONTACTABLE_FLAG in ('Y','N'));
alter table PERSONS
  add constraint PERSONS_GENDER_CHK
  check (GENDER in ('M','F','D'));
alter table PERSONS
  add constraint PERSONS_PROVISIONED_CHK
  check (PROVISIONED_FLAG in ('Y','N'));

prompt
prompt Creating table ADDRESS_USAGES
prompt =============================
prompt
create table ADDRESS_USAGES
(
  address_usages_id   NUMBER not null,
  associated_owner_id NUMBER(15) not null,
  owner_type_code     VARCHAR2(30) not null,
  address_id          NUMBER(15) not null,
  usage_type_code     VARCHAR2(30) not null,
  expired_flag        VARCHAR2(1) default 'N' not null,
  created_by          VARCHAR2(60) not null,
  creation_date       DATE not null,
  last_updated_by     VARCHAR2(60) not null,
  last_update_date    DATE not null,
  object_version_id   NUMBER(15) not null
)
;
comment on table ADDRESS_USAGES
  is 'Intersection entity that maps addresses to customers, suppliers etc. Any entity that can have multiple addresses will map them through this table. Certain address references such as a Customer''s primary address are also de-normalised into the relevant table. Where a consumer has one and only one address it will have a direct reference to the address table and will not have an entry here (for example Warehouse)';
comment on column ADDRESS_USAGES.associated_owner_id
  is 'The ID of the associated Customer or Supplier';
comment on column ADDRESS_USAGES.owner_type_code
  is 'Links the address usage to either a Customer or a Supplier. References LOOKUP_CODES with the domain OWNER_TYPE_CODE';
comment on column ADDRESS_USAGES.address_id
  is 'Unique Id of the mapped address';
comment on column ADDRESS_USAGES.usage_type_code
  is 'Distinguish between shipping, postal and invoice addresses.References LOOKUP_CODES with the domain USAGE_TYPE_CODE';
comment on column ADDRESS_USAGES.expired_flag
  is 'Boolean to indicate if this address mapping is still valid';
comment on column ADDRESS_USAGES.created_by
  is 'History column';
comment on column ADDRESS_USAGES.creation_date
  is 'History column';
comment on column ADDRESS_USAGES.last_updated_by
  is 'History column';
comment on column ADDRESS_USAGES.last_update_date
  is 'History column';
comment on column ADDRESS_USAGES.object_version_id
  is 'History column';
alter table ADDRESS_USAGES
  add constraint ADDRESS_USAGES_PK primary key (ADDRESS_USAGES_ID);
alter table ADDRESS_USAGES
  add constraint ADDRESS_USAGES_ADDRESSES_FK foreign key (ADDRESS_ID)
  references ADDRESSES (ADDRESS_ID);
alter table ADDRESS_USAGES
  add constraint ADDRESS_USAGES_PERSONS_FK foreign key (ASSOCIATED_OWNER_ID)
  references PERSONS (PERSON_ID);
alter table ADDRESS_USAGES
  add constraint ADDRESS_USAGES_CHK_EXPIRED
  check (EXPIRED_FLAG in ('Y','N'));

prompt
prompt Creating table AVAILABLE_LANGUAGES
prompt ==================================
prompt
create table AVAILABLE_LANGUAGES
(
  language          VARCHAR2(30) not null,
  default_flag      VARCHAR2(1) default 'N' not null,
  created_by        VARCHAR2(60) not null,
  creation_date     DATE not null,
  last_updated_by   VARCHAR2(60) not null,
  last_update_date  DATE not null,
  object_version_id NUMBER(15) not null
)
;
comment on table AVAILABLE_LANGUAGES
  is 'AVAILABLE_LANGUAGES lists all of the translations that are available in the system. Any translation table will be fully populated with one instance per available language. The entry itself may not yet be translated, in which case, the SOURCE_LANGUAGE column in the translation table will hold the language that the entry is currently in. When a value has been translated SOURCE_LANGUAGE and LANGUAGE will be the same. Only one row in this table will have the DEFAULT_FLAG set to Y ';
comment on column AVAILABLE_LANGUAGES.language
  is 'The supported language';
comment on column AVAILABLE_LANGUAGES.default_flag
  is 'Is this the system base language? Boolean Flag Y or N';
comment on column AVAILABLE_LANGUAGES.created_by
  is 'History column';
comment on column AVAILABLE_LANGUAGES.creation_date
  is 'History column';
comment on column AVAILABLE_LANGUAGES.last_updated_by
  is 'History column';
comment on column AVAILABLE_LANGUAGES.last_update_date
  is 'History column';
comment on column AVAILABLE_LANGUAGES.object_version_id
  is 'History column';
alter table AVAILABLE_LANGUAGES
  add constraint AVAILABLE_LANGUAGES_PK primary key (LANGUAGE);
alter table AVAILABLE_LANGUAGES
  add constraint AVAILABLE_LANGUAGES_DEFLT_CHK
  check (DEFAULT_FLAG in ('Y','N'));

prompt
prompt Creating table PRODUCTS_BASE
prompt ============================
prompt
create table PRODUCTS_BASE
(
  product_id             NUMBER(15) not null,
  supplier_id            NUMBER(15) not null,
  parent_category_id     NUMBER(15),
  category_id            NUMBER(15),
  product_name           VARCHAR2(50) not null,
  product_status         VARCHAR2(30) not null,
  cost_price             NUMBER(8,2),
  list_price             NUMBER(8,2) not null,
  min_price              NUMBER(8,2) not null,
  warranty_period_months NUMBER(2),
  shipping_class_code    VARCHAR2(30) not null,
  external_url           VARCHAR2(200),
  attribute_category     VARCHAR2(30),
  attribute1             VARCHAR2(150),
  attribute2             VARCHAR2(150),
  attribute3             VARCHAR2(150),
  attribute4             VARCHAR2(150),
  attribute5             VARCHAR2(150),
  attribute6             VARCHAR2(150),
  attribute7             VARCHAR2(150),
  attribute8             VARCHAR2(150),
  attribute9             VARCHAR2(150),
  attribute10            VARCHAR2(150),
  attribute11            VARCHAR2(150),
  attribute12            VARCHAR2(150),
  attribute13            VARCHAR2(150),
  attribute14            VARCHAR2(150),
  attribute15            VARCHAR2(150),
  created_by             VARCHAR2(60) not null,
  creation_date          DATE not null,
  last_updated_by        VARCHAR2(60) not null,
  last_update_date       DATE not null,
  object_version_id      NUMBER(15) not null
)
;
comment on table PRODUCTS_BASE
  is 'The products that are sold';
comment on column PRODUCTS_BASE.product_id
  is 'The unique identifier for this product';
comment on column PRODUCTS_BASE.supplier_id
  is 'The unique ID of the supplier of this product';
comment on column PRODUCTS_BASE.category_id
  is 'The category to which this product belongs. This category us used to help in searching for and organizing the products in the Storefront.';
comment on column PRODUCTS_BASE.product_name
  is 'A descriptive name for this product.';
comment on column PRODUCTS_BASE.cost_price
  is 'The amount paid to the supplier for this product';
comment on column PRODUCTS_BASE.list_price
  is 'The suggested list price for the product';
comment on column PRODUCTS_BASE.min_price
  is 'The agreed minimum price (after discounts) for this product';
comment on column PRODUCTS_BASE.warranty_period_months
  is 'How long is the warantee for this product';
comment on column PRODUCTS_BASE.shipping_class_code
  is 'Defines the weight class for this particular product. This is then used to calculate the shipping cost. Code is a lookup to the LOOKUP_CODES table with a domain of SHIPPING_CLASS_CODE';
comment on column PRODUCTS_BASE.external_url
  is 'Link back to the supplier website ';
comment on column PRODUCTS_BASE.attribute_category
  is 'Reserved for Applications use as Descriptive Flexfield';
comment on column PRODUCTS_BASE.attribute1
  is 'Reserved for Applications use as Descriptive Flexfield';
comment on column PRODUCTS_BASE.attribute2
  is 'Reserved for Applications use as Descriptive Flexfield';
comment on column PRODUCTS_BASE.attribute3
  is 'Reserved for Applications use as Descriptive Flexfield';
comment on column PRODUCTS_BASE.attribute4
  is 'Reserved for Applications use as Descriptive Flexfield';
comment on column PRODUCTS_BASE.attribute5
  is 'Reserved for Applications use as Descriptive Flexfield';
comment on column PRODUCTS_BASE.attribute6
  is 'Reserved for Applications use as Descriptive Flexfield';
comment on column PRODUCTS_BASE.attribute7
  is 'Reserved for Applications use as Descriptive Flexfield';
comment on column PRODUCTS_BASE.attribute8
  is 'Reserved for Applications use as Descriptive Flexfield';
comment on column PRODUCTS_BASE.attribute9
  is 'Reserved for Applications use as Descriptive Flexfield';
comment on column PRODUCTS_BASE.attribute10
  is 'Reserved for Applications use as Descriptive Flexfield';
comment on column PRODUCTS_BASE.attribute11
  is 'Reserved for Applications use as Descriptive Flexfield';
comment on column PRODUCTS_BASE.attribute12
  is 'Reserved for Applications use as Descriptive Flexfield';
comment on column PRODUCTS_BASE.attribute13
  is 'Reserved for Applications use as Descriptive Flexfield';
comment on column PRODUCTS_BASE.attribute14
  is 'Reserved for Applications use as Descriptive Flexfield';
comment on column PRODUCTS_BASE.created_by
  is 'History column';
comment on column PRODUCTS_BASE.creation_date
  is 'History column';
comment on column PRODUCTS_BASE.last_updated_by
  is 'History column';
comment on column PRODUCTS_BASE.last_update_date
  is 'History column';
comment on column PRODUCTS_BASE.object_version_id
  is 'History column';
alter table PRODUCTS_BASE
  add constraint PRODUCTS_PK primary key (PRODUCT_ID);
alter table PRODUCTS_BASE
  add constraint PRODUCTS_PRODUCT_CATEGORIES_FK foreign key (CATEGORY_ID)
  references PRODUCT_CATEGORIES_BASE (CATEGORY_ID);
alter table PRODUCTS_BASE
  add constraint PRODUCTS_SUPPLIERS_FK foreign key (SUPPLIER_ID)
  references SUPPLIERS (SUPPLIER_ID);

prompt
prompt Creating table PRODUCT_CATEGORIES_BASE
prompt ======================================
prompt
create table PRODUCT_CATEGORIES_BASE
(
  category_id               NUMBER(15) not null,
  parent_category_id        NUMBER(15),
  category_locked_flag      VARCHAR2(1) default 'N' not null,
  representative_product_id NUMBER(15),
  created_by                VARCHAR2(60) not null,
  creation_date             DATE not null,
  last_updated_by           VARCHAR2(60) not null,
  last_update_date          DATE not null,
  object_version_id         NUMBER(15) not null
)
;
comment on table PRODUCT_CATEGORIES_BASE
  is 'The classification hierachy for a particular product. Categories can be nested and then a product is assigned to a particular category.  The actual names and descriptions for the categories are held in the separate CATEGORY_TRANSLATIONS table.';
comment on column PRODUCT_CATEGORIES_BASE.category_id
  is 'Unique Id for the category';
comment on column PRODUCT_CATEGORIES_BASE.parent_category_id
  is 'The parent of this category in the hierachy';
comment on column PRODUCT_CATEGORIES_BASE.category_locked_flag
  is 'Boolean fag to define if new products may be assigned to this category or not ';
comment on column PRODUCT_CATEGORIES_BASE.representative_product_id
  is 'Links to a product which will be used to provide the sample image to illustrate the whole category.';
comment on column PRODUCT_CATEGORIES_BASE.created_by
  is 'History column';
comment on column PRODUCT_CATEGORIES_BASE.creation_date
  is 'History column';
comment on column PRODUCT_CATEGORIES_BASE.last_updated_by
  is 'History column';
comment on column PRODUCT_CATEGORIES_BASE.last_update_date
  is 'History column';
comment on column PRODUCT_CATEGORIES_BASE.object_version_id
  is 'History column';
alter table PRODUCT_CATEGORIES_BASE
  add constraint PRODUCT_TAGS_PK primary key (CATEGORY_ID);
alter table PRODUCT_CATEGORIES_BASE
  add constraint PRODUCT_CATEGORIES_FK foreign key (PARENT_CATEGORY_ID)
  references PRODUCT_CATEGORIES_BASE (CATEGORY_ID);
alter table PRODUCT_CATEGORIES_BASE
  add constraint REPRESENTATIVE_PRODUCT_FK foreign key (REPRESENTATIVE_PRODUCT_ID)
  references PRODUCTS_BASE (PRODUCT_ID);
alter table PRODUCT_CATEGORIES_BASE
  add constraint PRODUCT_CATEGORIES_LOCKED_CHK
  check (CATEGORY_LOCKED_FLAG in ('Y','N'));

prompt
prompt Creating table CATEGORY_TRANSLATIONS
prompt ====================================
prompt
create table CATEGORY_TRANSLATIONS
(
  category_id          NUMBER(15) not null,
  category_name        VARCHAR2(50) not null,
  category_description VARCHAR2(1000),
  language             VARCHAR2(30) not null,
  source_lang          VARCHAR2(30),
  created_by           VARCHAR2(60) not null,
  creation_date        DATE not null,
  last_updated_by      VARCHAR2(60) not null,
  last_update_date     DATE not null,
  object_version_id    NUMBER(15) not null
)
;
comment on table CATEGORY_TRANSLATIONS
  is 'Holds one translation for the  category text for each lanuage supported by the system.';
comment on column CATEGORY_TRANSLATIONS.category_id
  is 'Link to the category table';
comment on column CATEGORY_TRANSLATIONS.category_name
  is 'Name of the category in the relevant language';
comment on column CATEGORY_TRANSLATIONS.category_description
  is 'Description of the category in the relevant language';
comment on column CATEGORY_TRANSLATIONS.language
  is 'Language assigned for this entry ';
comment on column CATEGORY_TRANSLATIONS.source_lang
  is 'Actual language that the values are currently in. The value may not actually be translated, if LANGUAGE and SOURCE_LANG are the same then the row has been translated';
comment on column CATEGORY_TRANSLATIONS.created_by
  is 'History column';
comment on column CATEGORY_TRANSLATIONS.creation_date
  is 'History column';
comment on column CATEGORY_TRANSLATIONS.last_updated_by
  is 'History column';
comment on column CATEGORY_TRANSLATIONS.last_update_date
  is 'History column';
comment on column CATEGORY_TRANSLATIONS.object_version_id
  is 'History column';
alter table CATEGORY_TRANSLATIONS
  add constraint CATEGORY_TRANSLATIONS_PK primary key (CATEGORY_ID, LANGUAGE);
alter table CATEGORY_TRANSLATIONS
  add constraint CATEGORY_TRANSLATIONS_FK foreign key (CATEGORY_ID)
  references PRODUCT_CATEGORIES_BASE (CATEGORY_ID);

prompt
prompt Creating table COUNTRY_CODES
prompt ============================
prompt
create table COUNTRY_CODES
(
  iso_country_code  VARCHAR2(2) not null,
  country_name      VARCHAR2(100),
  language          VARCHAR2(30) not null,
  source_lang       VARCHAR2(30),
  created_by        VARCHAR2(60) not null,
  creation_date     DATE not null,
  last_updated_by   VARCHAR2(60) not null,
  last_update_date  DATE not null,
  object_version_id NUMBER(15) not null
)
;
comment on table COUNTRY_CODES
  is 'List of ISO Country codes and the name of the relevant country. This contains the translations for each country name as well. So each country code will be repeated for each supported language';
comment on column COUNTRY_CODES.iso_country_code
  is 'The actual country code';
comment on column COUNTRY_CODES.country_name
  is 'Translated country name';
comment on column COUNTRY_CODES.language
  is 'Language that this row represents';
comment on column COUNTRY_CODES.source_lang
  is 'Actual language that this row is currently in. May not necessarily match the LANGUGE value if the entry has yet to be translated';
comment on column COUNTRY_CODES.created_by
  is 'History column';
comment on column COUNTRY_CODES.creation_date
  is 'History column';
comment on column COUNTRY_CODES.last_updated_by
  is 'History column';
comment on column COUNTRY_CODES.last_update_date
  is 'History column';
comment on column COUNTRY_CODES.object_version_id
  is 'History column';
alter table COUNTRY_CODES
  add constraint COUNTRY_CODES_PK primary key (ISO_COUNTRY_CODE, LANGUAGE);

prompt
prompt Creating table DISCOUNTS_BASE
prompt =============================
prompt
create table DISCOUNTS_BASE
(
  discount_id              NUMBER(15) not null,
  discount_type_code       VARCHAR2(30) not null,
  discount_amount          NUMBER not null,
  apply_as_percentage_flag VARCHAR2(1) default 'N' not null,
  easy_code                VARCHAR2(20),
  add_free_shipping_flag   VARCHAR2(1) default 'N' not null,
  onetime_discount_flag    VARCHAR2(1) default 'Y' not null,
  created_by               VARCHAR2(60) not null,
  creation_date            DATE not null,
  last_updated_by          VARCHAR2(60) not null,
  last_update_date         DATE not null,
  object_version_id        NUMBER(15) not null
)
;
comment on table DISCOUNTS_BASE
  is 'DISCOUNTS provides modifiers to an order. A particular order may have up to two discounts applied. The base discount resulting from customer membership  enrollment and a coupon discount for one-time savings';
comment on column DISCOUNTS_BASE.discount_id
  is 'Unique identifier for the discount';
comment on column DISCOUNTS_BASE.discount_type_code
  is 'Type of discount referencing a lookup to the LOOKUP_TYPES table, domain DISCOUNT_TYPE_CODE';
comment on column DISCOUNTS_BASE.discount_amount
  is 'The value of the discount either as a dollar amount or as a percentage (see APPLY_AS_PERCENTAGE_FLAG) ';
comment on column DISCOUNTS_BASE.apply_as_percentage_flag
  is 'Boolean flag (Y/N) to define if the DISCOUNT_AMOUNT is a percentage or an absolute value';
comment on column DISCOUNTS_BASE.easy_code
  is 'Short Code for use in marketing promos and email shots';
comment on column DISCOUNTS_BASE.add_free_shipping_flag
  is 'Boolean Y/N: deduct shipping cost when this flag set to Y';
comment on column DISCOUNTS_BASE.onetime_discount_flag
  is 'Boolean Y/N value. Can this discount only be applied once per customer?';
comment on column DISCOUNTS_BASE.created_by
  is 'History column';
comment on column DISCOUNTS_BASE.creation_date
  is 'History column';
comment on column DISCOUNTS_BASE.last_updated_by
  is 'History column';
comment on column DISCOUNTS_BASE.last_update_date
  is 'History column';
comment on column DISCOUNTS_BASE.object_version_id
  is 'History column';
alter table DISCOUNTS_BASE
  add constraint DISCOUNTS_PK primary key (DISCOUNT_ID);
alter table DISCOUNTS_BASE
  add constraint DISCOUNTS_FREE_SHIPPING_CHK
  check (ADD_FREE_SHIPPING_FLAG in ('Y','N'));
alter table DISCOUNTS_BASE
  add constraint DISCOUNTS_ONETIME_CHK
  check (ONETIME_DISCOUNT_FLAG in ('Y','N'));
alter table DISCOUNTS_BASE
  add constraint DISCOUNT_AS_PERCENTAGE_CHK
  check (APPLY_AS_PERCENTAGE_FLAG in ('Y','N'));

prompt
prompt Creating table PAYMENT_OPTIONS
prompt ==============================
prompt
create table PAYMENT_OPTIONS
(
  payment_option_id  NUMBER(16) not null,
  customer_id        NUMBER(15) not null,
  payment_type_code  VARCHAR2(30) not null,
  billing_address_id INTEGER,
  account_number     NUMBER(19) not null,
  card_type_code     VARCHAR2(30),
  expire_date        DATE,
  check_digits       NUMBER(4),
  routing_identifier VARCHAR2(15),
  institution_name   VARCHAR2(120),
  valid_from_date    DATE,
  valid_to_date      DATE,
  created_by         VARCHAR2(60) not null,
  creation_date      DATE not null,
  last_updated_by    VARCHAR2(60) not null,
  last_update_date   DATE not null,
  object_version_id  NUMBER(15) not null
)
;
comment on table PAYMENT_OPTIONS
  is 'The list of payment types defined for this particular customer';
comment on column PAYMENT_OPTIONS.payment_option_id
  is 'Unique Id for this payment option';
comment on column PAYMENT_OPTIONS.customer_id
  is 'Link to the customer';
comment on column PAYMENT_OPTIONS.payment_type_code
  is 'Type of payment. Links to LOOKUP_CODES with the domain PAYMENT_TYPE_CODE';
comment on column PAYMENT_OPTIONS.billing_address_id
  is 'Billing address ID if different from the primary address of the user';
comment on column PAYMENT_OPTIONS.account_number
  is 'Account number of the Credit card, bank account etc.';
comment on column PAYMENT_OPTIONS.card_type_code
  is 'If this is a credit/debit card what type is it. Links to LOOKUP_CODES using the domain CARD_TYPE_CODE ';
comment on column PAYMENT_OPTIONS.expire_date
  is 'For a card payment when does this card expire. Input will be in the form of MM/YY. We will store as a date at the end of that specified month';
comment on column PAYMENT_OPTIONS.check_digits
  is 'For a card payment this is the verification code that is usually on the signature strip';
comment on column PAYMENT_OPTIONS.routing_identifier
  is 'Used when the type is direct debit. Holds the routing (sort) code of the bank';
comment on column PAYMENT_OPTIONS.institution_name
  is 'If direct Debit is used the name of the bank.';
comment on column PAYMENT_OPTIONS.valid_from_date
  is 'From when is this payment option valid? Will defaul to the creation date of the record, but the user may set this to the future if creating a new payment option.';
comment on column PAYMENT_OPTIONS.valid_to_date
  is 'When was this payment option valid to ( in the case of a credit card this will be the end of the expiry month on the card)';
comment on column PAYMENT_OPTIONS.created_by
  is 'History column';
comment on column PAYMENT_OPTIONS.creation_date
  is 'History column';
comment on column PAYMENT_OPTIONS.last_updated_by
  is 'History column';
comment on column PAYMENT_OPTIONS.last_update_date
  is 'History column';
comment on column PAYMENT_OPTIONS.object_version_id
  is 'History column';
alter table PAYMENT_OPTIONS
  add constraint PAYMENT_OPTIONS_PK primary key (PAYMENT_OPTION_ID);
alter table PAYMENT_OPTIONS
  add constraint PAYMENT_OPTIONS_PERSONS_FK foreign key (CUSTOMER_ID)
  references PERSONS (PERSON_ID);

prompt
prompt Creating table SHIPPING_OPTIONS_BASE
prompt ====================================
prompt
create table SHIPPING_OPTIONS_BASE
(
  shipping_option_id         NUMBER(15) not null,
  country_code               VARCHAR2(2),
  cost_per_class1_item       NUMBER(8,2) not null,
  cost_per_class2_item       NUMBER(8,2) not null,
  cost_per_class3_item       NUMBER(8,2) not null,
  free_shipping_allowed_flag VARCHAR2(1) default 'N',
  created_by                 VARCHAR2(60) not null,
  creation_date              DATE not null,
  last_updated_by            VARCHAR2(60) not null,
  last_update_date           DATE not null,
  object_version_id          NUMBER(15) not null
)
;
comment on table SHIPPING_OPTIONS_BASE
  is 'This table drives the available shipping options for the order. This list is used by the UI and configured based on the shipping address''s country code. ';
comment on column SHIPPING_OPTIONS_BASE.shipping_option_id
  is 'Unique Id for the shipping method';
comment on column SHIPPING_OPTIONS_BASE.country_code
  is 'Link to the COUNTRY_CODES table. The various types of shipping have different costs for each target country. For the sake of brevity, this table is populated with costs for the a small set of countries. A null country code indicates the rest of the world as a catch all.';
comment on column SHIPPING_OPTIONS_BASE.cost_per_class1_item
  is 'Unit cost for shipping CLASS1 items';
comment on column SHIPPING_OPTIONS_BASE.cost_per_class2_item
  is 'Unit cost for shipping CLASS2 items';
comment on column SHIPPING_OPTIONS_BASE.cost_per_class3_item
  is 'Unit cost for shipping CLASS3 items';
comment on column SHIPPING_OPTIONS_BASE.free_shipping_allowed_flag
  is 'Boolean flag to indicate if this is a deductable shipping cost. In most cases this will only be set to Y for non-express shipping options';
comment on column SHIPPING_OPTIONS_BASE.created_by
  is 'History column';
comment on column SHIPPING_OPTIONS_BASE.creation_date
  is 'History column';
comment on column SHIPPING_OPTIONS_BASE.last_updated_by
  is 'History column';
comment on column SHIPPING_OPTIONS_BASE.last_update_date
  is 'History column';
comment on column SHIPPING_OPTIONS_BASE.object_version_id
  is 'History column';
alter table SHIPPING_OPTIONS_BASE
  add constraint SHIPPING_OPTIONS_PK primary key (SHIPPING_OPTION_ID);
alter table SHIPPING_OPTIONS_BASE
  add constraint SHIPPING_OPTIONS_FREE_CHK
  check (FREE_SHIPPING_ALLOWED_FLAG  in ('Y','N'));

prompt
prompt Creating table WAREHOUSES
prompt =========================
prompt
create table WAREHOUSES
(
  warehouse_id      NUMBER(15) not null,
  address_id        NUMBER(15) not null,
  warehouse_name    VARCHAR2(35) not null,
  created_by        VARCHAR2(60) not null,
  creation_date     DATE not null,
  last_updated_by   VARCHAR2(60) not null,
  last_update_date  DATE not null,
  object_version_id NUMBER(15) not null
)
;
comment on table WAREHOUSES
  is 'Warehouses owned by the store''s company (not individual suppliers) ';
comment on column WAREHOUSES.warehouse_id
  is 'Unique Id for a warehouse';
comment on column WAREHOUSES.address_id
  is 'Address of the warehouse. A warehouse can only have one location so there is a direct link to addresses here rather than a link via the ADDRESS_USAGES table.';
comment on column WAREHOUSES.created_by
  is 'History column';
comment on column WAREHOUSES.creation_date
  is 'History column';
comment on column WAREHOUSES.last_updated_by
  is 'History column';
comment on column WAREHOUSES.last_update_date
  is 'History column';
comment on column WAREHOUSES.object_version_id
  is 'History column';
alter table WAREHOUSES
  add constraint WAREHOUSES_PK primary key (WAREHOUSE_ID);
alter table WAREHOUSES
  add constraint WAREHOUSES_ADDRESSES_FK foreign key (ADDRESS_ID)
  references ADDRESSES (ADDRESS_ID);

prompt
prompt Creating table ORDERS
prompt =====================
prompt
create table ORDERS
(
  order_id                NUMBER(15) not null,
  order_date              DATE not null,
  order_shipped_date      DATE,
  order_status_code       VARCHAR2(30) not null,
  order_total             NUMBER(8,2) not null,
  customer_id             NUMBER(15) not null,
  ship_to_name            VARCHAR2(120),
  ship_to_address_id      NUMBER(15) not null,
  ship_to_phone_number    VARCHAR2(20),
  shipping_option_id      NUMBER(15) not null,
  payment_option_id       NUMBER(16),
  discount_id             NUMBER(15),
  coupon_id               NUMBER(15),
  free_shipping_flag      VARCHAR2(1) default 'N' not null,
  customer_collect_flag   VARCHAR2(1) default 'N' not null,
  collection_warehouse_id NUMBER(15),
  giftwrap_flag           VARCHAR2(1) default 'N' not null,
  giftwrap_message        VARCHAR2(2000),
  created_by              VARCHAR2(60) not null,
  creation_date           DATE not null,
  last_updated_by         VARCHAR2(60) not null,
  last_update_date        DATE not null,
  object_version_id       NUMBER(15) not null
)
;
comment on table ORDERS
  is 'Orders holds the core order information';
comment on column ORDERS.order_id
  is 'Unique identifier for an order';
comment on column ORDERS.order_date
  is 'Date on which the order was placed';
comment on column ORDERS.order_shipped_date
  is 'Date on which the order was shipped. Note that the system does not provide for splitting orders into muliple parts for shipping purposes. Well we never said it was real!';
comment on column ORDERS.order_status_code
  is 'What status the order is currently in. Links to the LOOKUP_CODES table using the domain ORDER_STATUS_CODE ';
comment on column ORDERS.order_total
  is 'The calculated total for the order based on the products (and quantity) ordered. This value does not include shipping costs.';
comment on column ORDERS.customer_id
  is 'Link to the customer placing the order';
comment on column ORDERS.ship_to_name
  is 'The name to address this package to. If null then the name will be constructed from the Customer record';
comment on column ORDERS.ship_to_address_id
  is 'Direct reference to the shipping address. The UI will generally default this to the primary address of the customer.';
comment on column ORDERS.ship_to_phone_number
  is 'Contact phone number for the delivery guy. If null, the phone number of the Customer will be used';
comment on column ORDERS.shipping_option_id
  is 'How should this order be shipped';
comment on column ORDERS.payment_option_id
  is 'What form of payment will be used';
comment on column ORDERS.discount_id
  is 'If the customer has a membership of some sort this will link to the discount level provided by that membership';
comment on column ORDERS.coupon_id
  is 'link to a one-off coupon used with this order';
comment on column ORDERS.free_shipping_flag
  is 'Boolean flag to indicate if shipping costs for basic shipping will be deducted. This flag only takes effect when the FREE_SHIPPING_ALLOWED_FLAG flag is set in the selected Shipping option';
comment on column ORDERS.customer_collect_flag
  is 'Indicates if this order will be collected from a warehouse rather than being shipped';
comment on column ORDERS.collection_warehouse_id
  is 'If the CUSTOMER_COLLECT_FLAG is set, this column will hold the warehouse that the customer will elect to collect from ';
comment on column ORDERS.giftwrap_flag
  is 'Boolean Y/N';
comment on column ORDERS.giftwrap_message
  is 'Message to be printed and included in a Giftwrapped order.';
comment on column ORDERS.created_by
  is 'History column';
comment on column ORDERS.creation_date
  is 'History column';
comment on column ORDERS.last_updated_by
  is 'History column';
comment on column ORDERS.last_update_date
  is 'History column';
comment on column ORDERS.object_version_id
  is 'History column';
alter table ORDERS
  add constraint ORDERS_PK primary key (ORDER_ID);
alter table ORDERS
  add constraint ORDERS_ADDRESSES_FK foreign key (SHIP_TO_ADDRESS_ID)
  references ADDRESSES (ADDRESS_ID);
alter table ORDERS
  add constraint ORDERS_DISCOUNTS_FK foreign key (DISCOUNT_ID)
  references DISCOUNTS_BASE (DISCOUNT_ID);
alter table ORDERS
  add constraint ORDERS_DISCOUNTS_FK1 foreign key (COUPON_ID)
  references DISCOUNTS_BASE (DISCOUNT_ID);
alter table ORDERS
  add constraint ORDERS_PAYMENT_OPTIONS_FK foreign key (PAYMENT_OPTION_ID)
  references PAYMENT_OPTIONS (PAYMENT_OPTION_ID);
alter table ORDERS
  add constraint ORDERS_PERSONS_FK foreign key (CUSTOMER_ID)
  references PERSONS (PERSON_ID);
alter table ORDERS
  add constraint ORDERS_SHIPPING_OPTIONS_FK foreign key (SHIPPING_OPTION_ID)
  references SHIPPING_OPTIONS_BASE (SHIPPING_OPTION_ID);
alter table ORDERS
  add constraint ORDERS_WAREHOUSES_FK foreign key (COLLECTION_WAREHOUSE_ID)
  references WAREHOUSES (WAREHOUSE_ID);

prompt
prompt Creating table COUPON_USAGES
prompt ============================
prompt
create table COUPON_USAGES
(
  customer_id       NUMBER(15) not null,
  discount_id       NUMBER(15) not null,
  applied_date      DATE not null,
  order_id          NUMBER(15) not null,
  created_by        VARCHAR2(60) not null,
  creation_date     DATE not null,
  last_updated_by   VARCHAR2(60) not null,
  last_update_date  DATE not null,
  object_version_id NUMBER(15) not null
)
;
comment on table COUPON_USAGES
  is 'Associates the use of One-time discounts (coupons) with a particular customer.  When the customer attempts to apply a coupon to a transaction, this table will be checked to see if they have already used this coupon.';
comment on column COUPON_USAGES.customer_id
  is 'Link to the customer using the coupon (discount)';
comment on column COUPON_USAGES.discount_id
  is 'Link to the discount being applied ';
comment on column COUPON_USAGES.applied_date
  is 'When was the discount used';
comment on column COUPON_USAGES.order_id
  is 'The order for which this discount was used.';
comment on column COUPON_USAGES.created_by
  is 'History column';
comment on column COUPON_USAGES.creation_date
  is 'History column';
comment on column COUPON_USAGES.last_updated_by
  is 'History column';
comment on column COUPON_USAGES.last_update_date
  is 'History column';
comment on column COUPON_USAGES.object_version_id
  is 'History column';
alter table COUPON_USAGES
  add constraint COUPON_USAGES_PK primary key (CUSTOMER_ID, DISCOUNT_ID);
alter table COUPON_USAGES
  add constraint COUPON_USAGES_DISCOUNTS_FK foreign key (DISCOUNT_ID)
  references DISCOUNTS_BASE (DISCOUNT_ID);
alter table COUPON_USAGES
  add constraint COUPON_USAGES_ORDERS_FK foreign key (ORDER_ID)
  references ORDERS (ORDER_ID);
alter table COUPON_USAGES
  add constraint COUPON_USAGES_PERSONS_FK foreign key (CUSTOMER_ID)
  references PERSONS (PERSON_ID);

prompt
prompt Creating table CUSTOMER_IDENTIFICATIONS
prompt =======================================
prompt
create table CUSTOMER_IDENTIFICATIONS
(
  customer_id              NUMBER(15) not null,
  id_type_code             VARCHAR2(30) not null,
  id_detail                VARCHAR2(20) not null,
  additional_information   VARCHAR2(1000),
  verified_flag            VARCHAR2(1) default 'N' not null,
  verified_date            DATE,
  verified_by              NUMBER(15),
  verification_method_code VARCHAR2(30),
  created_by               VARCHAR2(60) not null,
  creation_date            DATE not null,
  last_updated_by          VARCHAR2(60) not null,
  last_update_date         DATE not null,
  object_version_id        NUMBER(15) not null
)
;
comment on table CUSTOMER_IDENTIFICATIONS
  is 'Various forms of identification provided by a customer. Confirmed identity will be used to configure the rules used during the order process, allowing higer spending and less manual verification';
comment on column CUSTOMER_IDENTIFICATIONS.customer_id
  is 'Link to the persons table';
comment on column CUSTOMER_IDENTIFICATIONS.id_type_code
  is 'The type of identity provided by the customer. A look up in the CODE_LOOKUPS table with the domain of ID_TYPE_CODE';
comment on column CUSTOMER_IDENTIFICATIONS.id_detail
  is 'The relevant number corresponding to the selected ID type';
comment on column CUSTOMER_IDENTIFICATIONS.additional_information
  is 'Free form text for staff use';
comment on column CUSTOMER_IDENTIFICATIONS.verified_flag
  is 'Boolean Y/N, has this piece of ID been verified ';
comment on column CUSTOMER_IDENTIFICATIONS.verified_date
  is 'Date / time that the verification took place';
comment on column CUSTOMER_IDENTIFICATIONS.verified_by
  is 'Id of the Staff member who verified the record';
comment on column CUSTOMER_IDENTIFICATIONS.verification_method_code
  is 'The method of verification. A lookup in the LOOKUP_CODES table referencing the VERIFICATION_METHOD_CODE domain';
comment on column CUSTOMER_IDENTIFICATIONS.created_by
  is 'History column';
comment on column CUSTOMER_IDENTIFICATIONS.creation_date
  is 'History column';
comment on column CUSTOMER_IDENTIFICATIONS.last_updated_by
  is 'History column';
comment on column CUSTOMER_IDENTIFICATIONS.last_update_date
  is 'History column';
comment on column CUSTOMER_IDENTIFICATIONS.object_version_id
  is 'History column';
alter table CUSTOMER_IDENTIFICATIONS
  add constraint VERIFIED_ID_PK primary key (CUSTOMER_ID);
alter table CUSTOMER_IDENTIFICATIONS
  add constraint CUSTOMER_IDENTIFICATIONS_FK foreign key (CUSTOMER_ID)
  references PERSONS (PERSON_ID);
alter table CUSTOMER_IDENTIFICATIONS
  add constraint CUSTOMER_IDENTIFICATIONS__FK1 foreign key (VERIFIED_BY)
  references PERSONS (PERSON_ID);
alter table CUSTOMER_IDENTIFICATIONS
  add constraint CUSTOMER_ID_VERIFY_CHK
  check (VERIFIED_FLAG in ('Y','N'));

prompt
prompt Creating table CUSTOMER_INTERESTS
prompt =================================
prompt
create table CUSTOMER_INTERESTS
(
  customer_id           NUMBER(15) not null,
  customer_interests_id NUMBER(15) not null,
  category_id           NUMBER(15) not null,
  created_by            VARCHAR2(60) not null,
  creation_date         DATE not null,
  last_updated_by       VARCHAR2(60) not null,
  last_update_date      DATE not null,
  object_version_id     NUMBER(15) not null
)
;
comment on table CUSTOMER_INTERESTS
  is 'The table is used to record the product categories that are of interest to the customer. This information is used to generate the recomendations list on the home page';
comment on column CUSTOMER_INTERESTS.customer_id
  is 'Unique Id for the customer';
comment on column CUSTOMER_INTERESTS.category_id
  is 'The Id iof the category that they are interested in ';
comment on column CUSTOMER_INTERESTS.created_by
  is 'History column';
comment on column CUSTOMER_INTERESTS.creation_date
  is 'History column';
comment on column CUSTOMER_INTERESTS.last_updated_by
  is 'History column';
comment on column CUSTOMER_INTERESTS.last_update_date
  is 'History column';
comment on column CUSTOMER_INTERESTS.object_version_id
  is 'History column';
alter table CUSTOMER_INTERESTS
  add constraint CUSTOMER_INTERESTS_PK primary key (CUSTOMER_INTERESTS_ID);
alter table CUSTOMER_INTERESTS
  add constraint CUSTOMER_CATEGORY_ID_UNIQUE unique (CUSTOMER_ID, CATEGORY_ID);
alter table CUSTOMER_INTERESTS
  add constraint CUSTOMER_INTERESTS_FK1 foreign key (CATEGORY_ID)
  references PRODUCT_CATEGORIES_BASE (CATEGORY_ID);
alter table CUSTOMER_INTERESTS
  add constraint CUSTOMER_INTERESTS_PERSON_FK1 foreign key (CUSTOMER_ID)
  references PERSONS (PERSON_ID);

prompt
prompt Creating table DEMO_OPTIONS
prompt ===========================
prompt
create table DEMO_OPTIONS
(
  key            VARCHAR2(40) not null,
  value          VARCHAR2(120),
  java_data_type VARCHAR2(120) default 'java.lang.String' not null,
  description    VARCHAR2(4000) not null
)
;
comment on table DEMO_OPTIONS
  is 'Demo Settings defines the various options within the demo which are switched on. It also caches general configuration information such as email addresses and phone numbers to use as overrides in a demo scenario (where emails etc. may be fake)';
comment on column DEMO_OPTIONS.key
  is 'Key Value to identify the preference. This will use a basic dot notation in the naming. e.g.  "override.customer.email"';
comment on column DEMO_OPTIONS.value
  is 'The value for the property. If this is set to NULL then the behavior of the preference will depend on context. For example setting an "override.*" property to null will indicate that the override is not in use and the real value will be used.  The type of a preference will genarlly be String. However, should an alternative type be required the value here should be valid for that type and the JAVA_DATA_TYPE set accordingly';
comment on column DEMO_OPTIONS.java_data_type
  is 'Data Type of the setting value';
comment on column DEMO_OPTIONS.description
  is 'Describes the use of the setting. All settings must be fully explained and define what the valid values are.';
alter table DEMO_OPTIONS
  add constraint DEMO_OPTIONS_PK primary key (KEY);

prompt
prompt Creating table DISCOUNT_TRANSLATIONS
prompt ====================================
prompt
create table DISCOUNT_TRANSLATIONS
(
  discount_translations_id NUMBER(15) not null,
  discount_id              NUMBER(15) not null,
  description              VARCHAR2(4000) not null,
  language                 VARCHAR2(30) not null,
  source_language          VARCHAR2(15) not null,
  created_by               VARCHAR2(60) not null,
  creation_date            DATE not null,
  last_updated_by          VARCHAR2(60) not null,
  last_update_date         DATE not null,
  object_version_id        NUMBER(15) not null
)
;
comment on table DISCOUNT_TRANSLATIONS
  is 'Holds translations of the discount description text';
comment on column DISCOUNT_TRANSLATIONS.discount_id
  is 'Link to the base discount table';
comment on column DISCOUNT_TRANSLATIONS.description
  is 'The translated description';
comment on column DISCOUNT_TRANSLATIONS.language
  is 'The language that this translation row represents ';
comment on column DISCOUNT_TRANSLATIONS.source_language
  is 'The actual language that this row is in - it may not match the LANGUAGE column if the row has not actually been translated yet';
comment on column DISCOUNT_TRANSLATIONS.created_by
  is 'History column';
comment on column DISCOUNT_TRANSLATIONS.creation_date
  is 'History column';
comment on column DISCOUNT_TRANSLATIONS.last_updated_by
  is 'History column';
comment on column DISCOUNT_TRANSLATIONS.last_update_date
  is 'History column';
comment on column DISCOUNT_TRANSLATIONS.object_version_id
  is 'History column';
alter table DISCOUNT_TRANSLATIONS
  add constraint DISCOUNT_TRANSLATIONS_PK primary key (DISCOUNT_TRANSLATIONS_ID);
alter table DISCOUNT_TRANSLATIONS
  add constraint DISCOUNT_TRANSLATIONS_FK foreign key (DISCOUNT_ID)
  references DISCOUNTS_BASE (DISCOUNT_ID);

prompt
prompt Creating table ELIGIBLE_DISCOUNTS
prompt =================================
prompt
create table ELIGIBLE_DISCOUNTS
(
  membership_id     NUMBER(15) not null,
  discount_id       NUMBER(15) not null,
  valid_from_date   DATE,
  valid_to_date     DATE,
  created_by        VARCHAR2(60) not null,
  creation_date     DATE not null,
  last_updated_by   VARCHAR2(60) not null,
  last_update_date  DATE not null,
  object_version_id NUMBER(15) not null
)
;
comment on table ELIGIBLE_DISCOUNTS
  is 'Maps the available discounts to a particular membership. Note that One-Time discounts (Coupons) cannot be allocated to memberships in this way.';
comment on column ELIGIBLE_DISCOUNTS.membership_id
  is 'Link to the membership table';
comment on column ELIGIBLE_DISCOUNTS.discount_id
  is 'Link to the relevant discount';
comment on column ELIGIBLE_DISCOUNTS.valid_from_date
  is 'If the life of the discount is restricted, this is the start date (inclusive)';
comment on column ELIGIBLE_DISCOUNTS.valid_to_date
  is 'If the life of the discount is restricted, this is the end date (inclusive)';
comment on column ELIGIBLE_DISCOUNTS.created_by
  is 'History column';
comment on column ELIGIBLE_DISCOUNTS.creation_date
  is 'History column';
comment on column ELIGIBLE_DISCOUNTS.last_updated_by
  is 'History column';
comment on column ELIGIBLE_DISCOUNTS.last_update_date
  is 'History column';
comment on column ELIGIBLE_DISCOUNTS.object_version_id
  is 'History column';
alter table ELIGIBLE_DISCOUNTS
  add constraint ELIGIBLE_DISCOUNTS_PK primary key (DISCOUNT_ID, MEMBERSHIP_ID);
alter table ELIGIBLE_DISCOUNTS
  add constraint ELIGIBLE_DISCOUNTS_FK foreign key (MEMBERSHIP_ID)
  references MEMBERSHIPS_BASE (MEMBERSHIP_ID);
alter table ELIGIBLE_DISCOUNTS
  add constraint ELIGIBLE_DISCOUNTS_FK1 foreign key (DISCOUNT_ID)
  references DISCOUNTS_BASE (DISCOUNT_ID);

prompt
prompt Creating table HELP_TRANSLATIONS
prompt ================================
prompt
create table HELP_TRANSLATIONS
(
  help_translations_id NUMBER(15) not null,
  help_id              NUMBER(15) not null,
  help_usage           VARCHAR2(200) not null,
  help_text            VARCHAR2(2000) not null,
  language             VARCHAR2(30) not null,
  source_language      VARCHAR2(15) not null,
  created_by           VARCHAR2(60) not null,
  creation_date        DATE not null,
  last_updated_by      VARCHAR2(60) not null,
  last_update_date     DATE not null,
  object_version_id    NUMBER(15) not null
)
;
comment on table HELP_TRANSLATIONS
  is 'Holds translations of the application help text';
comment on column HELP_TRANSLATIONS.help_id
  is 'Reserved for future use - the link to a base help table';
comment on column HELP_TRANSLATIONS.help_usage
  is 'The usage of this text as it relates to the application';
comment on column HELP_TRANSLATIONS.help_text
  is 'The translated help text';
comment on column HELP_TRANSLATIONS.language
  is 'The language that this translation row represents ';
comment on column HELP_TRANSLATIONS.source_language
  is 'The actual language that this row is in - it may not match the LANGUAGE column if the row has not actually been translated yet';
comment on column HELP_TRANSLATIONS.created_by
  is 'History column';
comment on column HELP_TRANSLATIONS.creation_date
  is 'History column';
comment on column HELP_TRANSLATIONS.last_updated_by
  is 'History column';
comment on column HELP_TRANSLATIONS.last_update_date
  is 'History column';
comment on column HELP_TRANSLATIONS.object_version_id
  is 'History column';
alter table HELP_TRANSLATIONS
  add constraint HELP_TRANSLATIONS_PK primary key (HELP_TRANSLATIONS_ID);

prompt
prompt Creating table LOOKUP_CODES
prompt ===========================
prompt
create table LOOKUP_CODES
(
  lookup_type       VARCHAR2(30) not null,
  lookup_code       VARCHAR2(30) not null,
  meaning           VARCHAR2(80) not null,
  description       VARCHAR2(240),
  language          VARCHAR2(30) not null,
  source_lang       VARCHAR2(30) not null,
  created_by        VARCHAR2(60) not null,
  creation_date     DATE not null,
  last_updated_by   VARCHAR2(60) not null,
  last_update_date  DATE not null,
  object_version_id NUMBER(15) not null
)
;
comment on table LOOKUP_CODES
  is 'Codes used throughout the system following the standard pattern of code Domains specifying to what a code is used for. ';
comment on column LOOKUP_CODES.lookup_type
  is 'The domain to use ';
comment on column LOOKUP_CODES.lookup_code
  is 'The code to match';
comment on column LOOKUP_CODES.meaning
  is 'What the code means';
comment on column LOOKUP_CODES.description
  is 'Further qualification of the meaning';
comment on column LOOKUP_CODES.language
  is 'The language that this row represents';
comment on column LOOKUP_CODES.source_lang
  is 'The actual language that the strings in this row are in - this may not match the LANGUAGE column if the row has not yet been translated';
comment on column LOOKUP_CODES.created_by
  is 'History column';
comment on column LOOKUP_CODES.creation_date
  is 'History column';
comment on column LOOKUP_CODES.last_updated_by
  is 'History column';
comment on column LOOKUP_CODES.last_update_date
  is 'History column';
comment on column LOOKUP_CODES.object_version_id
  is 'History column';
alter table LOOKUP_CODES
  add constraint LOOKUP_CODES_PK primary key (LOOKUP_TYPE, LOOKUP_CODE, LANGUAGE);

prompt
prompt Creating table MEMBERSHIP_TRANSLATIONS
prompt ======================================
prompt
create table MEMBERSHIP_TRANSLATIONS
(
  membership_translations_id NUMBER(15) not null,
  membership_id              NUMBER(15) not null,
  membership_name            VARCHAR2(120) not null,
  description                VARCHAR2(2000),
  language                   VARCHAR2(30) not null,
  source_language            VARCHAR2(15) not null,
  created_by                 VARCHAR2(60) not null,
  creation_date              DATE not null,
  last_updated_by            VARCHAR2(60) not null,
  last_update_date           DATE not null,
  object_version_id          NUMBER(15) not null
)
;
comment on column MEMBERSHIP_TRANSLATIONS.membership_id
  is 'Link to the membership record that this translation is for';
comment on column MEMBERSHIP_TRANSLATIONS.membership_name
  is 'Name of this particular membership';
comment on column MEMBERSHIP_TRANSLATIONS.description
  is 'Free text description of the membership';
comment on column MEMBERSHIP_TRANSLATIONS.language
  is 'Language which this particular row represents';
comment on column MEMBERSHIP_TRANSLATIONS.source_language
  is 'Language in which this particular row is actually encoded. If the row has not been translated yet it will not be the same as the LANGUAGE column';
comment on column MEMBERSHIP_TRANSLATIONS.created_by
  is 'History column';
comment on column MEMBERSHIP_TRANSLATIONS.creation_date
  is 'History column';
comment on column MEMBERSHIP_TRANSLATIONS.last_updated_by
  is 'History column';
comment on column MEMBERSHIP_TRANSLATIONS.last_update_date
  is 'History column';
comment on column MEMBERSHIP_TRANSLATIONS.object_version_id
  is 'History column';
alter table MEMBERSHIP_TRANSLATIONS
  add constraint MEMBERSHIP_TRANSLATIONS_PK primary key (MEMBERSHIP_TRANSLATIONS_ID);
alter table MEMBERSHIP_TRANSLATIONS
  add constraint MEMBERSHIP_TRANSLATIONS_FK foreign key (MEMBERSHIP_ID)
  references MEMBERSHIPS_BASE (MEMBERSHIP_ID);

prompt
prompt Creating table ORDER_ITEMS
prompt ==========================
prompt
create table ORDER_ITEMS
(
  order_id          NUMBER(15) not null,
  line_item_id      NUMBER(15) not null,
  product_id        NUMBER(15) not null,
  quantity          NUMBER(6) default 1 not null,
  unit_price        NUMBER(8,2) not null,
  created_by        VARCHAR2(60) not null,
  creation_date     DATE not null,
  last_updated_by   VARCHAR2(60) not null,
  last_update_date  DATE not null,
  object_version_id NUMBER(15) not null
)
;
comment on table ORDER_ITEMS
  is 'Holds the order lines';
comment on column ORDER_ITEMS.order_id
  is 'ID of the associated Order';
comment on column ORDER_ITEMS.line_item_id
  is 'Line number of this item';
comment on column ORDER_ITEMS.product_id
  is 'Product being purchased';
comment on column ORDER_ITEMS.quantity
  is 'Number of units of this product in the purchase';
comment on column ORDER_ITEMS.unit_price
  is 'Price per unit';
comment on column ORDER_ITEMS.created_by
  is 'History column';
comment on column ORDER_ITEMS.creation_date
  is 'History column';
comment on column ORDER_ITEMS.last_updated_by
  is 'History column';
comment on column ORDER_ITEMS.last_update_date
  is 'History column';
comment on column ORDER_ITEMS.object_version_id
  is 'History column';
create index INDEX_ORDER_ITEMS_ORDID_PRODID on ORDER_ITEMS (ORDER_ID, PRODUCT_ID);
create index INDEX_ORDER_ITEMS_PRODID on ORDER_ITEMS (PRODUCT_ID);
alter table ORDER_ITEMS
  add constraint ORDER_ITEMS_PK primary key (ORDER_ID, LINE_ITEM_ID);
alter table ORDER_ITEMS
  add constraint ORDER_ITEMS_ORDERS_FK foreign key (ORDER_ID)
  references ORDERS (ORDER_ID);
alter table ORDER_ITEMS
  add constraint ORDER_ITEMS_PRODUCTS_FK foreign key (PRODUCT_ID)
  references PRODUCTS_BASE (PRODUCT_ID);

prompt
prompt Creating table PRODUCT_IMAGES
prompt =============================
prompt
create table PRODUCT_IMAGES
(
  product_image_id  NUMBER(15) not null,
  product_id        NUMBER(15) not null,
  default_view_flag VARCHAR2(1) default 'N' not null,
  detail_image_id   NUMBER(15),
  image             BLOB not null,
  created_by        VARCHAR2(60) not null,
  creation_date     DATE not null,
  last_updated_by   VARCHAR2(60) not null,
  last_update_date  DATE not null,
  object_version_id NUMBER(15) not null
)
;
comment on table PRODUCT_IMAGES
  is 'Images of each product. A product many have several images available, only one of which will be marked as primary. Imgaes may also be thumbnails in which case the detailed version is pointed to by the DETAIL_IMAGE_ID';
comment on column PRODUCT_IMAGES.product_image_id
  is 'Unique Id for images';
comment on column PRODUCT_IMAGES.product_id
  is 'Link to the associated product';
comment on column PRODUCT_IMAGES.default_view_flag
  is 'Only one image can be the default view. This will be the image show in the main catelog. Only one image for a particular product may have this flag set';
comment on column PRODUCT_IMAGES.detail_image_id
  is 'Allows for a drilldown from thumbnail view to a detailed version of the image';
comment on column PRODUCT_IMAGES.image
  is 'The image to show';
comment on column PRODUCT_IMAGES.created_by
  is 'History column';
comment on column PRODUCT_IMAGES.creation_date
  is 'History column';
comment on column PRODUCT_IMAGES.last_updated_by
  is 'History column';
comment on column PRODUCT_IMAGES.last_update_date
  is 'History column';
comment on column PRODUCT_IMAGES.object_version_id
  is 'History column';
alter table PRODUCT_IMAGES
  add constraint PRODUCT_IMAGES_PK primary key (PRODUCT_IMAGE_ID);
alter table PRODUCT_IMAGES
  add constraint PRODUCT_IMAGES_FK foreign key (DETAIL_IMAGE_ID)
  references PRODUCT_IMAGES (PRODUCT_IMAGE_ID);
alter table PRODUCT_IMAGES
  add constraint PRODUCT_IMAGES_PRODUCTS_FK foreign key (PRODUCT_ID)
  references PRODUCTS_BASE (PRODUCT_ID);
alter table PRODUCT_IMAGES
  add constraint PRODUCT_IMAGES_DEFAULT_CHK
  check (DEFAULT_VIEW_FLAG in ('Y','N'));

prompt
prompt Creating table PRODUCT_TRANSLATIONS
prompt ===================================
prompt
create table PRODUCT_TRANSLATIONS
(
  product_id        NUMBER(15) not null,
  language          VARCHAR2(30) not null,
  source_lang       VARCHAR2(30),
  description       VARCHAR2(4000) not null,
  additional_info   VARCHAR2(4000),
  created_by        VARCHAR2(60) not null,
  creation_date     DATE not null,
  last_updated_by   VARCHAR2(60) not null,
  last_update_date  DATE not null,
  object_version_id NUMBER(15) not null
)
;
comment on table PRODUCT_TRANSLATIONS
  is 'Holds the translated names and descriptions of the product. One translation row will exist for each language supported by the system and each product';
comment on column PRODUCT_TRANSLATIONS.product_id
  is 'Link to the product';
comment on column PRODUCT_TRANSLATIONS.language
  is 'Language code for this entry';
comment on column PRODUCT_TRANSLATIONS.source_lang
  is 'Actual language that this entry is in. If the entry has not yet been translated this value may be different from the defined LANGUAGE of the entry';
comment on column PRODUCT_TRANSLATIONS.description
  is 'Translated description of the product ';
comment on column PRODUCT_TRANSLATIONS.additional_info
  is 'More ionformation about the product such as technical specifications';
comment on column PRODUCT_TRANSLATIONS.created_by
  is 'History column';
comment on column PRODUCT_TRANSLATIONS.creation_date
  is 'History column';
comment on column PRODUCT_TRANSLATIONS.last_updated_by
  is 'History column';
comment on column PRODUCT_TRANSLATIONS.last_update_date
  is 'History column';
comment on column PRODUCT_TRANSLATIONS.object_version_id
  is 'History column';
alter table PRODUCT_TRANSLATIONS
  add constraint PRODUCT_TRANSLATIONS_PK primary key (PRODUCT_ID, LANGUAGE);
alter table PRODUCT_TRANSLATIONS
  add constraint PRODUCT_TRANSLATIONS_FK foreign key (PRODUCT_ID)
  references PRODUCTS_BASE (PRODUCT_ID);

prompt
prompt Creating table SHIPPING_OPTION_TRANSLATIONS
prompt ===========================================
prompt
create table SHIPPING_OPTION_TRANSLATIONS
(
  shipping_translations_id NUMBER(15) not null,
  shipping_option_id       NUMBER(15) not null,
  shipping_method          VARCHAR2(100) not null,
  language                 VARCHAR2(30) not null,
  source_lang              VARCHAR2(4000) not null,
  created_by               VARCHAR2(60) not null,
  creation_date            DATE not null,
  last_updated_by          VARCHAR2(60) not null,
  last_update_date         DATE not null,
  object_version_id        NUMBER(15) not null
)
;
comment on table SHIPPING_OPTION_TRANSLATIONS
  is 'Holds the translated shipping option description. One translation will exist for each supported language and shipping option combination';
comment on column SHIPPING_OPTION_TRANSLATIONS.shipping_option_id
  is 'Link to the shipping option ';
comment on column SHIPPING_OPTION_TRANSLATIONS.shipping_method
  is 'Translated description';
comment on column SHIPPING_OPTION_TRANSLATIONS.language
  is 'The language that this row represents';
comment on column SHIPPING_OPTION_TRANSLATIONS.source_lang
  is 'The actual language that this entry is currently in. This value may not match the LANGUAGE column if the entry has yet to be translated.';
comment on column SHIPPING_OPTION_TRANSLATIONS.created_by
  is 'History column';
comment on column SHIPPING_OPTION_TRANSLATIONS.creation_date
  is 'History column';
comment on column SHIPPING_OPTION_TRANSLATIONS.last_updated_by
  is 'History column';
comment on column SHIPPING_OPTION_TRANSLATIONS.last_update_date
  is 'History column';
comment on column SHIPPING_OPTION_TRANSLATIONS.object_version_id
  is 'History column';
alter table SHIPPING_OPTION_TRANSLATIONS
  add constraint SHIPPING_OPTION_TRANSLATI_PK primary key (SHIPPING_TRANSLATIONS_ID);
alter table SHIPPING_OPTION_TRANSLATIONS
  add constraint SHIPPING_OPTION_TRANSLATION_FK foreign key (SHIPPING_OPTION_ID)
  references SHIPPING_OPTIONS_BASE (SHIPPING_OPTION_ID);

prompt
prompt Creating table WAREHOUSE_STOCK_LEVELS
prompt =====================================
prompt
create table WAREHOUSE_STOCK_LEVELS
(
  product_id        NUMBER(15) not null,
  warehouse_id      NUMBER(15) not null,
  quantity_on_hand  NUMBER(8) not null,
  created_by        VARCHAR2(60) not null,
  creation_date     DATE not null,
  last_updated_by   VARCHAR2(60) not null,
  last_update_date  DATE not null,
  object_version_id NUMBER(15) not null
)
;
comment on table WAREHOUSE_STOCK_LEVELS
  is 'Holds information about the stock levels for a particular product in each warehouse.';
comment on column WAREHOUSE_STOCK_LEVELS.product_id
  is 'Link to the product table';
comment on column WAREHOUSE_STOCK_LEVELS.warehouse_id
  is 'The warehouse in question ';
comment on column WAREHOUSE_STOCK_LEVELS.quantity_on_hand
  is 'The stock level of this product';
comment on column WAREHOUSE_STOCK_LEVELS.created_by
  is 'History column';
comment on column WAREHOUSE_STOCK_LEVELS.creation_date
  is 'History column';
comment on column WAREHOUSE_STOCK_LEVELS.last_updated_by
  is 'History column';
comment on column WAREHOUSE_STOCK_LEVELS.last_update_date
  is 'History column';
comment on column WAREHOUSE_STOCK_LEVELS.object_version_id
  is 'History column';
alter table WAREHOUSE_STOCK_LEVELS
  add constraint WAREHOUSE_STOCK_LEVELS_PK primary key (PRODUCT_ID, WAREHOUSE_ID);
alter table WAREHOUSE_STOCK_LEVELS
  add constraint WAREHOUSE_STOCK_LEVELS_FK foreign key (WAREHOUSE_ID)
  references WAREHOUSES (WAREHOUSE_ID);
alter table WAREHOUSE_STOCK_LEVELS
  add constraint WAREHOUSE_STOCK_LEVELS_FK1 foreign key (PRODUCT_ID)
  references PRODUCTS_BASE (PRODUCT_ID);

prompt
prompt Creating sequence ADDRESS_SEQ
prompt =============================
prompt
create sequence ADDRESS_SEQ
minvalue 1
maxvalue 9999999999999999999999999999
start with 300
increment by 1
cache 20;

prompt
prompt Creating sequence ADDRESS_USAGES_SEQ
prompt ====================================
prompt
create sequence ADDRESS_USAGES_SEQ
minvalue 1
maxvalue 9999999999999999999999999999
start with 300
increment by 1
cache 20;

prompt
prompt Creating sequence CATEGORY_SEQ
prompt ==============================
prompt
create sequence CATEGORY_SEQ
minvalue 1
maxvalue 9999999999999999999999999999
start with 15
increment by 1
cache 20;

prompt
prompt Creating sequence CUSTOMER_INTERESTS_SEQ
prompt ========================================
prompt
create sequence CUSTOMER_INTERESTS_SEQ
minvalue 1
maxvalue 9999999999999999999999999999
start with 200
increment by 1
cache 20;

prompt
prompt Creating sequence DISCOUNT_SEQ
prompt ==============================
prompt
create sequence DISCOUNT_SEQ
minvalue 1
maxvalue 9999999999999999999999999999
start with 8
increment by 1
cache 20;

prompt
prompt Creating sequence DISCOUNT_TRANSLATIONS_SEQ
prompt ===========================================
prompt
create sequence DISCOUNT_TRANSLATIONS_SEQ
minvalue 1
maxvalue 9999999999999999999999999999
start with 48
increment by 1
cache 20;

prompt
prompt Creating sequence HELP_TRANSLATIONS_SEQ
prompt =======================================
prompt
create sequence HELP_TRANSLATIONS_SEQ
minvalue 1
maxvalue 9999999999999999999999999999
start with 104
increment by 1
cache 20;

prompt
prompt Creating sequence MEMBER_SEQ
prompt ============================
prompt
create sequence MEMBER_SEQ
minvalue 1
maxvalue 9999999999999999999999999999
start with 15
increment by 1
cache 20;

prompt
prompt Creating sequence MEMBER_TRANSLATIONS_SEQ
prompt =========================================
prompt
create sequence MEMBER_TRANSLATIONS_SEQ
minvalue 1
maxvalue 9999999999999999999999999999
start with 48
increment by 1
cache 20;

prompt
prompt Creating sequence ORDER_ITEMS_SEQ
prompt =================================
prompt
create sequence ORDER_ITEMS_SEQ
minvalue 1
maxvalue 9999999999999999999999999999
start with 121
increment by 1
cache 20;

prompt
prompt Creating sequence ORDER_SEQ
prompt ===========================
prompt
create sequence ORDER_SEQ
minvalue 1
maxvalue 9999999999999999999999999999
start with 1110
increment by 1
cache 10;

prompt
prompt Creating sequence PAYMENT_OPTION_SEQ
prompt ====================================
prompt
create sequence PAYMENT_OPTION_SEQ
minvalue 1
maxvalue 9999999999999999999999999999
start with 1058
increment by 1
cache 20;

prompt
prompt Creating sequence PERSON_SEQ
prompt ============================
prompt
create sequence PERSON_SEQ
minvalue 1
maxvalue 9999999999999999999999999999
start with 300
increment by 1
cache 10;

prompt
prompt Creating sequence PRODUCT_IMAGE_SEQ
prompt ===================================
prompt
create sequence PRODUCT_IMAGE_SEQ
minvalue 1
maxvalue 9999999999999999999999999999
start with 208
increment by 1
cache 20;

prompt
prompt Creating sequence PRODUCT_SEQ
prompt =============================
prompt
create sequence PRODUCT_SEQ
minvalue 1
maxvalue 9999999999999999999999999999
start with 100
increment by 1
cache 20;

prompt
prompt Creating sequence SHIPPING_OPTION_SEQ
prompt =====================================
prompt
create sequence SHIPPING_OPTION_SEQ
minvalue 1
maxvalue 9999999999999999999999999999
start with 5
increment by 1
cache 20;

prompt
prompt Creating sequence SHIPPING_TRANSLATIONS_SEQ
prompt ===========================================
prompt
create sequence SHIPPING_TRANSLATIONS_SEQ
minvalue 1
maxvalue 9999999999999999999999999999
start with 25
increment by 1
cache 20;

prompt
prompt Creating sequence SUPPLIER_SEQ
prompt ==============================
prompt
create sequence SUPPLIER_SEQ
minvalue 1
maxvalue 9999999999999999999999999999
start with 300
increment by 1
cache 10;

prompt
prompt Creating sequence WAREHOUSE_SEQ
prompt ===============================
prompt
create sequence WAREHOUSE_SEQ
minvalue 1
maxvalue 9999999999999999999999999999
start with 200
increment by 1
cache 20;

prompt
prompt Creating view DISCOUNTS
prompt =======================
prompt
CREATE OR REPLACE FORCE VIEW DISCOUNTS AS
SELECT DISCOUNT_ID DISCOUNT_ID, DISCOUNT_TRANSLATIONS.DESCRIPTION DESCRIPTION, DISCOUNTS_BASE.DISCOUNT_TYPE_CODE DISCOUNT_TYPE_CODE, DISCOUNTS_BASE.DISCOUNT_AMOUNT DISCOUNT_AMOUNT, DISCOUNTS_BASE.APPLY_AS_PERCENTAGE_FLAG APPLY_AS_PERCENTAGE_FLAG, DISCOUNTS_BASE.EASY_CODE EASY_CODE, DISCOUNTS_BASE.ADD_FREE_SHIPPING_FLAG ADD_FREE_SHIPPING_FLAG, DISCOUNTS_BASE.ONETIME_DISCOUNT_FLAG ONETIME_DISCOUNT_FLAG FROM DISCOUNT_TRANSLATIONS INNER JOIN DISCOUNTS_BASE USING (DISCOUNT_ID) WHERE DISCOUNT_TRANSLATIONS.LANGUAGE = SYS_CONTEXT('userenv', 'LANG') WITH READ ONLY;
comment on table DISCOUNTS is 'Defines a simplified view of discounts where the translation aspect is automatically handled based on the current user environment';

prompt
prompt Creating view MEMBERSHIPS
prompt =========================
prompt
CREATE OR REPLACE FORCE VIEW MEMBERSHIPS AS
SELECT MEMBERSHIP_ID MEMBERSHIP_ID, MEMBERSHIPS_BASE.MEMBERSHIP_TYPE_CODE MEMBERSHIP_TYPE_CODE, MEMBERSHIP_TRANSLATIONS.MEMBERSHIP_NAME MEMBERSHIP_NAME, MEMBERSHIP_TRANSLATIONS.DESCRIPTION DESCRIPTION, MEMBERSHIPS_BASE.CONTACT_ID CONTACT_ID FROM MEMBERSHIP_TRANSLATIONS INNER JOIN MEMBERSHIPS_BASE USING (MEMBERSHIP_ID) WHERE MEMBERSHIP_TRANSLATIONS.LANGUAGE = SYS_CONTEXT('USERENV', 'LANG');

prompt
prompt Creating view PERSON_INFORMATION
prompt ================================
prompt
CREATE OR REPLACE FORCE VIEW PERSON_INFORMATION AS
SELECT PERSONS.PERSON_ID CUSTOMER_ID, PERSONS.PRINCIPAL_NAME PRINCIPAL_NAME, PERSONS.TITLE TITLE, PERSONS.FIRST_NAME FIRST_NAME, PERSONS.LAST_NAME LAST_NAME, ADDRESSES1.ADDRESS1 ADDRESS1, ADDRESSES1.ADDRESS2 ADDRESS2, ADDRESSES1.CITY CITY, ADDRESSES1.POSTAL_CODE POSTAL_CODE, ADDRESSES1.STATE_PROVINCE STATE_PROVINCE, ADDRESSES1.COUNTRY_ID COUNTRY_ID, ADDRESSES1.LONGITUDE LONGITUDE, ADDRESSES1.LATITUDE LATITUDE, PERSONS.CONFIRMED_EMAIL CONFIRMED_EMAIL, PERSONS.PHONE_NUMBER PHONE_NUMBER, PERSONS.MOBILE_PHONE_NUMBER MOBILE_PHONE_NUMBER, PERSONS.REGISTERED_DATE REGISTERED_DATE, PERSONS.MEMBERSHIP_ID MEMBERSHIP_ID, PERSONS.CREDIT_LIMIT CREDIT_LIMIT, PERSONS.DATE_OF_BIRTH DATE_OF_BIRTH, PERSONS.MARITAL_STATUS_CODE MARITAL_STATUS_CODE, PERSONS.GENDER GENDER, PERSONS.CHILDREN_UNDER_18 CHILDREN_UNDER_18, PERSONS.APPROXIMATE_INCOME APPROXIMATE_INCOME, PERSONS.CONTACT_METHOD_CODE CONTACT_METHOD_CODE, PERSONS.CONTACTABLE_FLAG CONTACTABLE_FLAG, PERSONS.CONTACT_BY_AFFILLIATES_FLAG CONTACT_BY_AFFILLIATES_FLAG FROM PERSONS INNER JOIN ADDRESSES ADDRESSES1 ON PERSONS.PRIMARY_ADDRESS_ID = ADDRESSES1.ADDRESS_ID;

prompt
prompt Creating view PRODUCTS
prompt ======================
prompt
CREATE OR REPLACE FORCE VIEW PRODUCTS AS
SELECT PRODUCT_TRANSLATIONS.DESCRIPTION DESCRIPTION, PRODUCT_TRANSLATIONS.ADDITIONAL_INFO ADDITIONAL_INFO, PRODUCTS_BASE.COST_PRICE COST_PRICE, PRODUCTS_BASE.SUPPLIER_ID SUPPLIER_ID, PRODUCTS_BASE.PRODUCT_NAME PRODUCT_NAME, PRODUCTS_BASE.LIST_PRICE LIST_PRICE, PRODUCT_ID PRODUCT_ID, PRODUCTS_BASE.CATEGORY_ID CATEGORY_ID, PRODUCTS_BASE.MIN_PRICE MIN_PRICE, PRODUCTS_BASE.WARRANTY_PERIOD_MONTHS WARRANTY_PERIOD_MONTHS, PRODUCTS_BASE.SHIPPING_CLASS_CODE SHIPPING_CLASS_CODE, PRODUCTS_BASE.EXTERNAL_URL EXTERNAL_URL, PRODUCTS_BASE.ATTRIBUTE_CATEGORY ATTRIBUTE_CATEGORY, PRODUCTS_BASE.ATTRIBUTE15 ATTRIBUTE15, PRODUCTS_BASE.ATTRIBUTE1 ATTRIBUTE1, PRODUCTS_BASE.ATTRIBUTE2 ATTRIBUTE2, PRODUCTS_BASE.ATTRIBUTE3 ATTRIBUTE3, PRODUCTS_BASE.ATTRIBUTE4 ATTRIBUTE4, PRODUCTS_BASE.ATTRIBUTE5 ATTRIBUTE5, PRODUCTS_BASE.ATTRIBUTE6 ATTRIBUTE6, PRODUCTS_BASE.ATTRIBUTE7 ATTRIBUTE7, PRODUCTS_BASE.ATTRIBUTE8 ATTRIBUTE8, PRODUCTS_BASE.ATTRIBUTE9 ATTRIBUTE9, PRODUCTS_BASE.ATTRIBUTE10 ATTRIBUTE10, PRODUCTS_BASE.ATTRIBUTE11 ATTRIBUTE11, PRODUCTS_BASE.ATTRIBUTE12 ATTRIBUTE12, PRODUCTS_BASE.ATTRIBUTE13 ATTRIBUTE13, PRODUCTS_BASE.ATTRIBUTE14 ATTRIBUTE14 FROM PRODUCT_TRANSLATIONS INNER JOIN PRODUCTS_BASE USING (PRODUCT_ID) WHERE PRODUCT_TRANSLATIONS.LANGUAGE = SYS_CONTEXT('USERENV', 'LANG');

prompt
prompt Creating view PRODUCT_CATEGORIES
prompt ================================
prompt
CREATE OR REPLACE FORCE VIEW PRODUCT_CATEGORIES AS
SELECT CATEGORY_TRANSLATIONS.CATEGORY_NAME CATEGORY_NAME, CATEGORY_TRANSLATIONS.CATEGORY_DESCRIPTION CATEGORY_DESCRIPTION, CATEGORY_ID CATEGORY_ID, PRODUCT_CATEGORIES_BASE.PARENT_CATEGORY_ID PARENT_CATEGORY_ID, PRODUCT_CATEGORIES_BASE.CATEGORY_LOCKED_FLAG CATEGORY_LOCKED_FLAG, PRODUCT_IMAGES.IMAGE IMAGE FROM CATEGORY_TRANSLATIONS INNER JOIN PRODUCT_CATEGORIES_BASE USING (CATEGORY_ID), PRODUCT_IMAGES WHERE PRODUCT_IMAGES.PRODUCT_ID = PRODUCT_CATEGORIES_BASE.REPRESENTATIVE_PRODUCT_ID AND PRODUCT_IMAGES.DEFAULT_VIEW_FLAG = 'Y' AND CATEGORY_TRANSLATIONS.LANGUAGE = SYS_CONTEXT('userenv', 'LANG') WITH READ ONLY;
comment on table PRODUCT_CATEGORIES is 'Simplified view of categories';

prompt
prompt Creating view SHIPPING_OPTIONS
prompt ==============================
prompt
CREATE OR REPLACE FORCE VIEW SHIPPING_OPTIONS AS
SELECT SHIPPING_OPTION_TRANSLATIONS.SHIPPING_METHOD SHIPPING_METHOD, SHIPPING_OPTION_ID SHIPPING_OPTION_ID, SHIPPING_OPTIONS_BASE.COUNTRY_CODE COUNTRY_CODE, SHIPPING_OPTIONS_BASE.COST_PER_CLASS1_ITEM COST_PER_CLASS1_ITEM, SHIPPING_OPTIONS_BASE.COST_PER_CLASS2_ITEM COST_PER_CLASS2_ITEM, SHIPPING_OPTIONS_BASE.COST_PER_CLASS3_ITEM COST_PER_CLASS3_ITEM, SHIPPING_OPTIONS_BASE.FREE_SHIPPING_ALLOWED_FLAG FREE_SHIPPING_ALLOWED_FLAG FROM SHIPPING_OPTION_TRANSLATIONS INNER JOIN SHIPPING_OPTIONS_BASE USING (SHIPPING_OPTION_ID) WHERE SHIPPING_OPTION_TRANSLATIONS.LANGUAGE = SYS_CONTEXT('userenv', 'LANG');

prompt
prompt Creating package USER_CONTEXT_PKG
prompt =================================
prompt
CREATE OR REPLACE PACKAGE user_context_pkg IS PROCEDURE set_app_user_lang ( user_lang IN VARCHAR2); END user_context_pkg;
/

prompt
prompt Creating package body USER_CONTEXT_PKG
prompt ======================================
prompt
CREATE OR REPLACE PACKAGE body user_context_pkg IS PROCEDURE set_app_user_lang ( user_lang IN VARCHAR2) IS BEGIN dbms_application_info.set_client_info(user_lang); EXCEPTION WHEN OTHERS THEN raise_application_error (-20001, 'Error in user_context_pkg.set_app_user_lang: ' || SQLERRM); END; END user_context_pkg;
/

prompt
prompt Creating trigger ASSIGN_ADDRESS_ID
prompt ==================================
prompt
CREATE OR REPLACE TRIGGER ASSIGN_ADDRESS_ID BEFORE INSERT ON ADDRESSES
FOR EACH ROW
BEGIN
 IF :NEW.ADDRESS_ID IS NULL OR :NEW.ADDRESS_ID < 0 THEN
   SELECT ADDRESS_SEQ.NEXTVAL
     INTO :NEW.ADDRESS_ID
     FROM DUAL;
   END IF;
END;
/

prompt
prompt Creating trigger ASSIGN_ADDRESS_USAGES_ID
prompt =========================================
prompt
CREATE OR REPLACE TRIGGER ASSIGN_ADDRESS_USAGES_ID BEFORE INSERT ON ADDRESS_USAGES
FOR EACH ROW
BEGIN
 IF :NEW.ADDRESS_USAGES_ID IS NULL OR :NEW.ADDRESS_USAGES_ID < 0 THEN
   SELECT ADDRESS_USAGES_SEQ.NEXTVAL
     INTO :NEW.ADDRESS_USAGES_ID
     FROM DUAL;
   END IF;
END;
/

prompt
prompt Creating trigger ASSIGN_CATEGORY_ID
prompt ===================================
prompt
CREATE OR REPLACE TRIGGER ASSIGN_CATEGORY_ID BEFORE INSERT ON PRODUCT_CATEGORIES_BASE
FOR EACH ROW
BEGIN
 IF :NEW.CATEGORY_ID IS NULL OR :NEW.CATEGORY_ID < 0 THEN
   SELECT CATEGORY_SEQ.NEXTVAL
     INTO :NEW.CATEGORY_ID
     FROM DUAL;
   END IF;
END;
/

prompt
prompt Creating trigger ASSIGN_CUSTOMER_INTRSTS_ID
prompt ===========================================
prompt
CREATE OR REPLACE TRIGGER ASSIGN_CUSTOMER_INTRSTS_ID BEFORE INSERT ON CUSTOMER_INTERESTS
FOR EACH ROW
BEGIN
 IF :NEW.CUSTOMER_INTERESTS_ID IS NULL OR :NEW.CUSTOMER_INTERESTS_ID < 0 THEN
   SELECT CUSTOMER_INTERESTS_SEQ.NEXTVAL
     INTO :NEW.CUSTOMER_INTERESTS_ID
     FROM DUAL;
   END IF;
END;
/

prompt
prompt Creating trigger ASSIGN_DISCOUNT_ID
prompt ===================================
prompt
CREATE OR REPLACE TRIGGER ASSIGN_DISCOUNT_ID BEFORE INSERT ON DISCOUNTS_BASE
FOR EACH ROW
BEGIN
 IF :NEW.DISCOUNT_ID IS NULL OR :NEW.DISCOUNT_ID < 0 THEN
   SELECT DISCOUNT_SEQ.NEXTVAL
     INTO :NEW.DISCOUNT_ID
     FROM DUAL;
   END IF;
END;
/

prompt
prompt Creating trigger ASSIGN_DISCOUNT_TRANS_ID
prompt =========================================
prompt
CREATE OR REPLACE TRIGGER ASSIGN_DISCOUNT_TRANS_ID BEFORE INSERT ON DISCOUNT_TRANSLATIONS
FOR EACH ROW
BEGIN
 IF :NEW.DISCOUNT_TRANSLATIONS_ID IS NULL OR :NEW.DISCOUNT_TRANSLATIONS_ID < 0 THEN
   SELECT DISCOUNT_TRANSLATIONS_SEQ.NEXTVAL
     INTO :NEW.DISCOUNT_TRANSLATIONS_ID
     FROM DUAL;
   END IF;
END;
/

prompt
prompt Creating trigger ASSIGN_HELP_TRANS_ID
prompt =====================================
prompt
CREATE OR REPLACE TRIGGER ASSIGN_HELP_TRANS_ID BEFORE INSERT ON HELP_TRANSLATIONS
FOR EACH ROW
BEGIN
 IF :NEW.HELP_TRANSLATIONS_ID IS NULL OR :NEW.HELP_TRANSLATIONS_ID < 0 THEN
   SELECT HELP_TRANSLATIONS_SEQ.NEXTVAL
     INTO :NEW.HELP_TRANSLATIONS_ID
     FROM DUAL;
   END IF;
END;
/

prompt
prompt Creating trigger ASSIGN_LINE_ITEM_ID
prompt ====================================
prompt
CREATE OR REPLACE TRIGGER ASSIGN_LINE_ITEM_ID BEFORE INSERT ON ORDER_ITEMS
FOR EACH ROW
BEGIN
 IF :NEW.LINE_ITEM_ID IS NULL OR :NEW.LINE_ITEM_ID < 0 THEN
   SELECT ORDER_ITEMS_SEQ.NEXTVAL
     INTO :NEW.LINE_ITEM_ID
     FROM DUAL;
   END IF;
END;
/

prompt
prompt Creating trigger ASSIGN_MEMBERSHIP_ID
prompt =====================================
prompt
CREATE OR REPLACE TRIGGER ASSIGN_MEMBERSHIP_ID BEFORE INSERT ON MEMBERSHIPS_BASE
FOR EACH ROW
BEGIN
 IF :NEW.MEMBERSHIP_ID IS NULL OR :NEW.MEMBERSHIP_ID < 0 THEN
   SELECT MEMBER_SEQ.NEXTVAL
     INTO :NEW.MEMBERSHIP_ID
     FROM DUAL;
   END IF;
END;
/

prompt
prompt Creating trigger ASSIGN_MEMBERSHIP_TRANS_ID
prompt ===========================================
prompt
CREATE OR REPLACE TRIGGER ASSIGN_MEMBERSHIP_TRANS_ID BEFORE INSERT ON MEMBERSHIP_TRANSLATIONS
FOR EACH ROW
BEGIN
 IF :NEW.MEMBERSHIP_TRANSLATIONS_ID IS NULL OR :NEW.MEMBERSHIP_TRANSLATIONS_ID < 0 THEN
   SELECT MEMBER_TRANSLATIONS_SEQ.NEXTVAL
     INTO :NEW.MEMBERSHIP_TRANSLATIONS_ID
     FROM DUAL;
   END IF;
END;
/

prompt
prompt Creating trigger ASSIGN_ORDER_ID
prompt ================================
prompt
CREATE OR REPLACE TRIGGER ASSIGN_ORDER_ID BEFORE INSERT ON ORDERS
FOR EACH ROW
BEGIN
 IF :NEW.ORDER_ID IS NULL OR :NEW.ORDER_ID < 0 THEN
   SELECT ORDER_SEQ.NEXTVAL
     INTO :NEW.ORDER_ID
     FROM DUAL;
   END IF;
END;
/

prompt
prompt Creating trigger ASSIGN_PAYMENT_OPTION_ID
prompt =========================================
prompt
CREATE OR REPLACE TRIGGER ASSIGN_PAYMENT_OPTION_ID BEFORE INSERT ON PAYMENT_OPTIONS
FOR EACH ROW
BEGIN
 IF :NEW.PAYMENT_OPTION_ID IS NULL OR :NEW.PAYMENT_OPTION_ID < 0 THEN
   SELECT PAYMENT_OPTION_SEQ.NEXTVAL
     INTO :NEW.PAYMENT_OPTION_ID
     FROM DUAL;
   END IF;
END;
/

prompt
prompt Creating trigger ASSIGN_PERSON_ID
prompt =================================
prompt
CREATE OR REPLACE TRIGGER ASSIGN_PERSON_ID BEFORE INSERT ON PERSONS
FOR EACH ROW
BEGIN
 IF :NEW.PERSON_ID IS NULL OR :NEW.PERSON_ID < 0 THEN
   SELECT PERSON_SEQ.NEXTVAL
     INTO :NEW.PERSON_ID
     FROM DUAL;
   END IF;
END;
/

prompt
prompt Creating trigger ASSIGN_PRODUCT_ID
prompt ==================================
prompt
CREATE OR REPLACE TRIGGER ASSIGN_PRODUCT_ID BEFORE INSERT ON PRODUCTS_BASE
FOR EACH ROW
BEGIN
 IF :NEW.PRODUCT_ID IS NULL OR :NEW.PRODUCT_ID < 0 THEN
   SELECT PRODUCT_SEQ.NEXTVAL
     INTO :NEW.PRODUCT_ID
     FROM DUAL;
   END IF;
END;
/

prompt
prompt Creating trigger ASSIGN_PRODUCT_IMAGE_ID
prompt ========================================
prompt
CREATE OR REPLACE TRIGGER ASSIGN_PRODUCT_IMAGE_ID BEFORE INSERT ON PRODUCT_IMAGES
FOR EACH ROW
BEGIN
 IF :NEW.PRODUCT_IMAGE_ID IS NULL OR :NEW.PRODUCT_IMAGE_ID < 0 THEN
   SELECT PRODUCT_IMAGE_SEQ.NEXTVAL
     INTO :NEW.PRODUCT_IMAGE_ID
     FROM DUAL;
   END IF;
END;
/

prompt
prompt Creating trigger ASSIGN_SHIPPING_OPTION_ID
prompt ==========================================
prompt
CREATE OR REPLACE TRIGGER ASSIGN_SHIPPING_OPTION_ID BEFORE INSERT ON SHIPPING_OPTIONS_BASE
FOR EACH ROW
BEGIN
 IF :NEW.SHIPPING_OPTION_ID IS NULL OR :NEW.SHIPPING_OPTION_ID < 0 THEN
   SELECT SHIPPING_OPTION_SEQ.NEXTVAL
     INTO :NEW.SHIPPING_OPTION_ID
     FROM DUAL;
   END IF;
END;
/

prompt
prompt Creating trigger ASSIGN_SHIPPING_TRANS_ID
prompt =========================================
prompt
CREATE OR REPLACE TRIGGER ASSIGN_SHIPPING_TRANS_ID BEFORE INSERT ON SHIPPING_OPTION_TRANSLATIONS
FOR EACH ROW
BEGIN
 IF :NEW.SHIPPING_TRANSLATIONS_ID IS NULL OR :NEW.SHIPPING_TRANSLATIONS_ID < 0 THEN
   SELECT SHIPPING_TRANSLATIONS_SEQ.NEXTVAL
     INTO :NEW.SHIPPING_TRANSLATIONS_ID
     FROM DUAL;
   END IF;
END;
/

prompt
prompt Creating trigger ASSIGN_SUPPLIER_ID
prompt ===================================
prompt
CREATE OR REPLACE TRIGGER ASSIGN_SUPPLIER_ID BEFORE INSERT ON SUPPLIERS
FOR EACH ROW
BEGIN
 IF :NEW.SUPPLIER_ID IS NULL OR :NEW.SUPPLIER_ID < 0 THEN
   SELECT SUPPLIER_SEQ.NEXTVAL
     INTO :NEW.SUPPLIER_ID
     FROM DUAL;
   END IF;
END;
/

prompt
prompt Creating trigger ASSIGN_WAREHOUSE_ID
prompt ====================================
prompt
CREATE OR REPLACE TRIGGER ASSIGN_WAREHOUSE_ID BEFORE INSERT ON WAREHOUSES
FOR EACH ROW
BEGIN
 IF :NEW.WAREHOUSE_ID IS NULL OR :NEW.WAREHOUSE_ID < 0 THEN
   SELECT WAREHOUSE_SEQ.NEXTVAL
     INTO :NEW.WAREHOUSE_ID
     FROM DUAL;
   END IF;
END;
/


spool off
