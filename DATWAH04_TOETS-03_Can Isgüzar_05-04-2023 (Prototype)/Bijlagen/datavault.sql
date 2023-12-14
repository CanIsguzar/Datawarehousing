/*==============================================================*/
/* DBMS name:      MySQL 5.0                                    */
/* Created on:     03/04/2023 16:19:41                          */
/*==============================================================*/
use master;
drop database anbc;
create database anbc;
use anbc;

/*==============================================================*/
/* Table: HUB_CONSIGNMENT                                       */
/*==============================================================*/
create table HUB_CONSIGNMENT
(
   CONSIGNMENT_ID       int not null,
   LDS                  varchar(1024),
   RS                   varchar(1024),
   CONSIGNMENT_NR       varchar(1024),
   primary key (CONSIGNMENT_ID)
);

/*==============================================================*/
/* Table: HUB_CUSTOMER                                          */
/*==============================================================*/
create table HUB_CUSTOMER
(
   CUSTOMER_ID          int not null,
   LDS                  varchar(1024),
   RS                   varchar(1024),
   CUSTOMER_NR          varchar(1024),
   primary key (CUSTOMER_ID)
);

/*==============================================================*/
/* Table: HUB_DISTRICT                                          */
/*==============================================================*/
create table HUB_DISTRICT
(
   DISTRICT_ID          int not null,
   LDS                  varchar(1024),
   RS                   varchar(1024),
   DISTRICT_NAME        varchar(1024),
   primary key (DISTRICT_ID)
);

/*==============================================================*/
/* Table: HUB_EMPLOYEE                                          */
/*==============================================================*/
create table HUB_EMPLOYEE
(
   EMPLOYEE_ID          int not null,
   LDS                  varchar(1024),
   RS                   varchar(1024),
   EMPLOYEE_NR          varchar(1024),
   primary key (EMPLOYEE_ID)
);

/*==============================================================*/
/* Table: HUB_PARCEL                                            */
/*==============================================================*/
create table HUB_PARCEL
(
   PARCEL_ID            int not null,
   LDS                  varchar(1024),
   RS                   varchar(1024),
   PARCEL_NR            varchar(1024),
   primary key (PARCEL_ID)
);

/*==============================================================*/
/* Table: HUB_WEATHER                                           */
/*==============================================================*/
create table HUB_WEATHER
(
   WEATHER_ID           int not null,
   LDS                  varchar(1024),
   RS                   varchar(1024),
   primary key (WEATHER_ID)
);

/*==============================================================*/
/* Table: LINK_CONSIGNMENT_CUSTOMER                             */
/*==============================================================*/
create table LINK_CONSIGNMENT_CUSTOMER
(
   CONSIGNMENT_ID       int not null,
   CUSTOMER_ID          int not null,
   LDS                  varchar(1024),
   RS                   varchar(1024),
   primary key (CONSIGNMENT_ID, CUSTOMER_ID)
);

/*==============================================================*/
/* Table: LINK_CONSIGNMENT_WEATHER                              */
/*==============================================================*/
create table LINK_CONSIGNMENT_WEATHER
(
   CONSIGNMENT_ID       int not null,
   WEATHER_ID           int not null,
   LDS					varchar(1024),
   RS					varchar(1024),
   primary key (CONSIGNMENT_ID, WEATHER_ID)
);

/*==============================================================*/
/* Table: LINK_EMPLOYEE_DISTRICT                                */
/*==============================================================*/
create table LINK_EMPLOYEE_DISTRICT
(
   DISTRICT_ID          int not null,
   EMPLOYEE_ID          int not null,
   LDS                  varchar(1024),
   RS                   varchar(1024),
   WEEK                 varchar(1024),
   EMPLOYEE_DISTRICT_ID varchar(1024) not null,
   primary key (EMPLOYEE_DISTRICT_ID)
);

/*==============================================================*/
/* Table: LINK_PARCEL_CONSIGNMENT                               */
/*==============================================================*/
create table LINK_PARCEL_CONSIGNMENT
(
   PARCEL_ID            int not null,
   CONSIGNMENT_ID       int not null,
   LDS                  varchar(1024),
   RS                   varchar(1024),
   primary key (PARCEL_ID, CONSIGNMENT_ID)
);

/*==============================================================*/
/* Table: LINK_PARCEL_EMPLOYEE                                  */
/*==============================================================*/
create table LINK_PARCEL_EMPLOYEE
(
   EMPLOYEE_ID          int not null,
   PARCEL_ID            int not null,
   LDS                  varchar(1024),
   RS                   varchar(1024),
   primary key (EMPLOYEE_ID, PARCEL_ID)
);

/*==============================================================*/
/* Table: SAT_CONSIGNMENT                                       */
/*==============================================================*/
create table SAT_CONSIGNMENT
(
   CONSIGNMENT_ID       int not null,
   LDS                  varchar(1024) not null,
   RS                   varchar(1024),
   RECV_FIRSTNAME       varchar(1024),
   RECV_LASTNAME        varchar(1024),
   RECV_COMPANY         varchar(1024),
   SCHED_PICKUP_TIME    varchar(1024),
   PICKUP_TIME          varchar(1024),
   EXPRESS_DURATION     varchar(1024),
   DISPATCH				bit,
   primary key (CONSIGNMENT_ID, LDS)
);

/*==============================================================*/
/* Table: SAT_CONSIGNMENT_CUSTOMER                              */
/*==============================================================*/
create table SAT_CONSIGNMENT_CUSTOMER
(
   CONSIGNMENT_ID       int not null,
   CUSTOMER_ID          int not null,
   LDS                  varchar(1024) not null,
   RS					varchar(1024) not null,
   STATUS               varchar(1024),
   primary key (CONSIGNMENT_ID, CUSTOMER_ID, LDS)
);

/*==============================================================*/
/* Table: SAT_CUSTOMER                                          */
/*==============================================================*/
create table SAT_CUSTOMER
(
   CUSTOMER_ID          int not null,
   LDS                  varchar(1024) not null,
   RS                   varchar(1024),
   COMPANY              varchar(1024),
   CONTACTPHONE_NR      varchar(1024),
   CELLPHONE_NR         varchar(1024),
   GENERALPHONE_NR      varchar(1024),
   FAX_NR               varchar(1024),
   FIRSTNAME            varchar(1024),
   LASTNAME             varchar(1024),
   primary key (CUSTOMER_ID, LDS)
);

/*==============================================================*/
/* Table: SAT_DISTRICT                                          */
/*==============================================================*/
create table SAT_DISTRICT
(
   DISTRICT_ID          int not null,
   LDS                  varchar(1024) not null,
   RS                   varchar(1024),
   TOWN                 varchar(1024),
   primary key (DISTRICT_ID, LDS)
);

/*==============================================================*/
/* Table: SAT_EMPLOYEE                                          */
/*==============================================================*/
create table SAT_EMPLOYEE
(
   EMPLOYEE_ID          int not null,
   LDS                  varchar(1024) not null,
   RS                   varchar(1024),
   BSN                  varchar(1024),
   EXPRESS              varchar(1024),
   MAXHOUR              varchar(1024),
   CELLPHONE_NR         varchar(1024),
   HOMEPHONE_NR         varchar(1024),
   BIRTH_DATE           varchar(1024),
   GENDER               varchar(1024),
   FIRSTNAME            varchar(1024),
   LASTNAME             varchar(1024),
   PASSWORD             varchar(1024),
   primary key (EMPLOYEE_ID, LDS)
);

/*==============================================================*/
/* Table: SAT_PARCEL                                            */
/*==============================================================*/
create table SAT_PARCEL
(
   PARCEL_ID            int not null,
   LDS                  varchar(1024) not null,
   RS                   varchar(1024),
   WEIGHT               float,
   SIGNATURE            varchar(1024),
   DELIVERY_TIME        varchar(1024),
   PRICE				float,
   primary key (PARCEL_ID, LDS)
);

/*==============================================================*/
/* Table: SAT_WEATHER                                           */
/*==============================================================*/
create table SAT_WEATHER
(
   WEATHER_ID           int not null,
   LDS                  varchar(1024) not null,
   RS                   varchar(1024),
   WIND_SPEED           float,
   TEMPERATURE          float,
   PRECIP               float,
   AIR_PRESSURE         float,
   HORIZONTAL_VIEW      float,
   CLOUD                bit,
   HUMIDITY             bit,
   MIST                 bit,
   RAIN                 bit,
   SNOW                 bit,
   THUNDER              bit,
   ICE                  bit,
   primary key (WEATHER_ID, LDS)
);

alter table LINK_CONSIGNMENT_CUSTOMER add constraint FK_REFERENCE_3 foreign key (CONSIGNMENT_ID)
      references HUB_CONSIGNMENT (CONSIGNMENT_ID) on delete cascade on update cascade;

alter table LINK_CONSIGNMENT_CUSTOMER add constraint FK_REFERENCE_4 foreign key (CUSTOMER_ID)
      references HUB_CUSTOMER (CUSTOMER_ID) on delete cascade on update cascade;

alter table LINK_CONSIGNMENT_WEATHER add constraint FK_REFERENCE_17 foreign key (CONSIGNMENT_ID)
      references HUB_CONSIGNMENT (CONSIGNMENT_ID) on delete cascade on update cascade;

alter table LINK_CONSIGNMENT_WEATHER add constraint FK_REFERENCE_19 foreign key (WEATHER_ID)
      references HUB_WEATHER (WEATHER_ID) on delete cascade on update cascade;

alter table LINK_EMPLOYEE_DISTRICT add constraint FK_REFERENCE_10 foreign key (EMPLOYEE_ID)
      references HUB_EMPLOYEE (EMPLOYEE_ID) on delete cascade on update cascade;

alter table LINK_EMPLOYEE_DISTRICT add constraint FK_REFERENCE_11 foreign key (DISTRICT_ID)
      references HUB_DISTRICT (DISTRICT_ID) on delete cascade on update cascade;

alter table LINK_PARCEL_CONSIGNMENT add constraint FK_REFERENCE_5 foreign key (CONSIGNMENT_ID)
      references HUB_CONSIGNMENT (CONSIGNMENT_ID) on delete cascade on update cascade;

alter table LINK_PARCEL_CONSIGNMENT add constraint FK_REFERENCE_6 foreign key (PARCEL_ID)
      references HUB_PARCEL (PARCEL_ID) on delete cascade on update cascade;

alter table LINK_PARCEL_EMPLOYEE add constraint FK_REFERENCE_8 foreign key (PARCEL_ID)
      references HUB_PARCEL (PARCEL_ID) on delete cascade on update cascade;

alter table LINK_PARCEL_EMPLOYEE add constraint FK_REFERENCE_9 foreign key (EMPLOYEE_ID)
      references HUB_EMPLOYEE (EMPLOYEE_ID) on delete cascade on update cascade;

alter table SAT_CONSIGNMENT add constraint FK_REFERENCE_2 foreign key (CONSIGNMENT_ID)
      references HUB_CONSIGNMENT (CONSIGNMENT_ID) on delete cascade on update cascade;

alter table SAT_CONSIGNMENT_CUSTOMER add constraint FK_REFERENCE_20 foreign key (CONSIGNMENT_ID, CUSTOMER_ID)
      references LINK_CONSIGNMENT_CUSTOMER (CONSIGNMENT_ID, CUSTOMER_ID) on delete cascade on update cascade;

alter table SAT_CUSTOMER add constraint FK_REFERENCE_1 foreign key (CUSTOMER_ID)
      references HUB_CUSTOMER (CUSTOMER_ID) on delete cascade on update cascade;

alter table SAT_DISTRICT add constraint FK_REFERENCE_14 foreign key (DISTRICT_ID)
      references HUB_DISTRICT (DISTRICT_ID) on delete cascade on update cascade;

alter table SAT_EMPLOYEE add constraint FK_REFERENCE_16 foreign key (EMPLOYEE_ID)
      references HUB_EMPLOYEE (EMPLOYEE_ID) on delete cascade on update cascade;

alter table SAT_PARCEL add constraint FK_REFERENCE_18 foreign key (PARCEL_ID)
      references HUB_PARCEL (PARCEL_ID) on delete cascade on update cascade;

alter table SAT_WEATHER add constraint FK_REFERENCE_21 foreign key (WEATHER_ID)
      references HUB_WEATHER (WEATHER_ID) on delete cascade on update cascade;


go
CREATE VIEW consignment_fact AS
SELECT sc.SCHED_PICKUP_TIME, sum(price) as price, count(hc.consignment_id) as aantal, lpe.employee_id, mist, rain, snow, thunder, ice, (FIRSTNAME + ' ' + LASTNAME) as name, EXPRESS, sc.PICKUP_TIME
FROM sat_consignment sc
INNER JOIN hub_consignment hc ON (sc.consignment_id = hc.consignment_id)
INNER JOIN LINK_PARCEL_CONSIGNMENT lpc ON (hc.consignment_id = lpc.consignment_id)
INNER JOIN hub_parcel hp ON (hp.parcel_id = lpc.parcel_id)
INNER JOIN sat_parcel sp ON (sp.parcel_id = hp.parcel_id)
INNER JOIN link_parcel_employee lpe ON (lpe.parcel_id = hp.parcel_id)
INNER JOIN sat_employee se ON (se.employee_id = lpe.employee_id)
INNER JOIN link_consignment_weather lcw ON (lcw.consignment_id = hc.consignment_id)
INNER JOIN sat_weather sw ON (lcw.weather_id = sw.weather_id)
GROUP BY sc.SCHED_PICKUP_TIME, sc.PICKUP_TIME, lpe.employee_id, mist, rain, snow, thunder, ice, (FIRSTNAME + ' ' + LASTNAME), EXPRESS;
go