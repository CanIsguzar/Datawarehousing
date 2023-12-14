/*==============================================================*/
/* DBMS name:      MySQL 5.0                                    */
/* Created on:     03/04/2023 16:13:25                          */
/*==============================================================*/
use master;
DROP database anbc_ster;
CREATE DATABASE anbc_ster;
use anbc_ster;
/*==============================================================*/
/* Table: CONSIGNMENT_FACT d                                     */
/*==============================================================*/
create table CONSIGNMENT_FACT
(
   SCHED_TIME_ID              int not null,
   PICKUP_TIME_ID               int not null,
   PERSONEEL_ID         int not null,
   WEATHER_ID           int not null,
   PRIJS			    float not null,
   AANTAL               int,
   primary key (SCHED_TIME_ID, PICKUP_TIME_ID, PERSONEEL_ID, WEATHER_ID)
);

/*==============================================================*/
/* Table: PERSONEEL_DIM                                         */
/*==============================================================*/
create table PERSONEEL_DIM
(
   PERSONEEL_ID         int not null,
   EMPLOYEE             varchar(1024),
   EXPRESS_ERVARING		bit,
   primary key (PERSONEEL_ID)
);

/*==============================================================*/
/* Table: TIME_DIM                                              */
/*==============================================================*/
create table TIME_DIM
(
   TIME_ID              int not null,
   DATUM                datetime,
   MAAND                varchar(1024),
   WEEK                 varchar(1024),
   DAG                  varchar(1024),
   JAAR                 varchar(1024),
   primary key (TIME_ID)
);

/*==============================================================*/
/* Table: WEATHER_DIM                                           */
/*==============================================================*/
create table WEATHER_DIM
(
   WEATHER_ID           int not null,
   OMSTANDIGHEDEN       varchar(1024),
   primary key (WEATHER_ID)
);

alter table CONSIGNMENT_FACT add constraint FK_REFERENCE_1 foreign key (PICKUP_TIME_ID)
      references TIME_DIM (TIME_ID) on delete NO ACTION on update NO ACTION;

alter table CONSIGNMENT_FACT add constraint FK_REFERENCE_2 foreign key (SCHED_TIME_ID)
      references TIME_DIM (TIME_ID) on delete NO ACTION on update NO ACTION;

alter table CONSIGNMENT_FACT add constraint FK_REFERENCE_3 foreign key (PERSONEEL_ID)
      references PERSONEEL_DIM (PERSONEEL_ID) on delete cascade on update cascade;

alter table CONSIGNMENT_FACT add constraint FK_REFERENCE_4 foreign key (WEATHER_ID)
      references WEATHER_DIM (WEATHER_ID) on delete cascade on update cascade;

