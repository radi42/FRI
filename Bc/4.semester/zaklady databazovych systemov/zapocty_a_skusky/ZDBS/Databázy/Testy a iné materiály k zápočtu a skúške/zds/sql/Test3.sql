/*==============================================================*/
/* Database name:  PhysicalDataModel_1                          */
/* DBMS name:      PostgreSQL 7                                 */
/* Created on:     3. 2. 2004 16:19:03                          */
/*==============================================================*/


drop table Adress;

drop table Castle;

drop table Client;

drop table Contact;

drop table Event;

drop table Event_Type;

drop table Events;

drop table Foto_Gallery;

drop table Gallery;

drop table Hotel;

drop table Icon;

drop table Icons;

drop table Info;

drop table Map;

drop table Multi_Parent;

drop table Name_Desc;

drop table Picture;

drop table Point;

drop table Price;

drop table Reservation;

drop table Reservation_Type;

drop table Restaurant;

drop table Subject;

drop table Subject_Type;

/*==============================================================*/
/* Table: Adress                                                */
/*==============================================================*/
create table Adress (
ID                   INT4                 not null,
PSC                  VARCHAR(6)           null,
Adress               VARCHAR(200)         null,
constraint PK_ADRESS primary key (ID)
);

/*==============================================================*/
/* Table: Castle                                                */
/*==============================================================*/
create table Castle (
Subject_ID           INT4                 not null,
Exsposure_Name_Desc_ID INT4                 null,
constraint PK_CASTLE primary key (Subject_ID)
);

/*==============================================================*/
/* Table: Client                                                */
/*==============================================================*/
create table Client (
ID                   INT4                 not null,
Name                 VARCHAR(100)         null,
Adress_ID            INT4                 null,
Email                VARCHAR(50)          null,
Phone                VARCHAR(20)          null,
Cell_Phone           VARCHAR(20)          null,
Rating               INT2                 null,
Code                 VARCHAR(20)          null,
constraint PK_CLIENT primary key (ID)
);

/*==============================================================*/
/* Table: Contact                                               */
/*==============================================================*/
create table Contact (
ID                   INT4                 not null,
Text                 VARCHAR(200)         null,
Type                 VARCHAR(10)          null,
constraint PK_CONTACT primary key (ID)
);

/*==============================================================*/
/* Table: Event                                                 */
/*==============================================================*/
create table Event (
ID                   INT4                 not null,
DFrom                TIMESTAMP            null,
DTo                  TIMESTAMP            null,
Event_Type_ID        INT4                 null,
Name_Desc_ID         INT4                 null,
Subject_ID           INT4                 null,
Data_Int             INT8                 null,
Data_Float           FLOAT8               null,
Data_Str             VARCHAR(200)         null,
Data_Bool            BOOL                 null,
constraint PK_EVENT primary key (ID)
);

/*==============================================================*/
/* Table: Event_Type                                            */
/*==============================================================*/
create table Event_Type (
ID                   INT4                 not null,
Type                 VARCHAR(10)          null,
constraint PK_SUBJECT_TYPE primary key (ID)
);

/*==============================================================*/
/* Table: Events                                                */
/*==============================================================*/
create table Events (
ID                   INT4                 not null,
"Order"              INT2                 not null,
Event_ID             INT4                 null,
constraint PK_ICONS primary key (ID, "Order")
);

/*==============================================================*/
/* Table: Foto_Gallery                                          */
/*==============================================================*/
create table Foto_Gallery (
ID                   INT4                 not null,
"Order"              INT2                 not null,
Pic_ID               INT4                 null,
constraint PK_FOTO_GALLERY primary key (ID, "Order")
);

/*==============================================================*/
/* Table: Gallery                                               */
/*==============================================================*/
create table Gallery (
Subject_ID           INT4                 not null,
Exsposure_Name_Desc_ID INT4                 null,
constraint PK_GALLERY primary key (Subject_ID)
);

/*==============================================================*/
/* Table: Hotel                                                 */
/*==============================================================*/
create table Hotel (
Subject_ID           INT4                 not null,
Bed_Count            INT2                 null,
Price_1Bed           INT4                 null,
Price_2Bed           INT4                 null,
Price_Apartment      INT4                 null,
Price_Breakfast      INT4                 null,
Breakfast_Name_Desc_ID INT4                 null,
constraint PK_HOTEL primary key (Subject_ID)
);

/*==============================================================*/
/* Table: Icon                                                  */
/*==============================================================*/
create table Icon (
ID                   INT2                 not null,
Pic_ID               INT4                 null,
Name_Desc_ID         INT4                 null,
constraint PK_ICON primary key (ID)
);

/*==============================================================*/
/* Table: Icons                                                 */
/*==============================================================*/
create table Icons (
ID                   INT4                 not null,
"Order"              INT2                 not null,
Icon_ID              INT2                 null,
constraint PK_ICONS primary key (ID, "Order")
);

/*==============================================================*/
/* Table: Info                                                  */
/*==============================================================*/
create table Info (
ID                   INT4                 not null,
Language             VARCHAR(2)           not null,
Billboard            VARCHAR(1000)        null,
PrintInfo            VARCHAR(1000)        null,
Form                 VARCHAR(1000)        null,
constraint PK_INFO primary key (ID, Language)
);

/*==============================================================*/
/* Table: Map                                                   */
/*==============================================================*/
create table Map (
ID                   INT4                 not null,
Pic_0                INT4                 null,
Pic_1                INT4                 null,
Pic_2                INT4                 null,
Pic_3                INT4                 null,
constraint PK_MAP primary key (ID)
);

/*==============================================================*/
/* Table: Multi_Parent                                          */
/*==============================================================*/
create table Multi_Parent (
ID                   INT4                 not null,
"Order"              INT4                 not null,
Parent_ID            INT4                 null,
Parent_Type_ID       INT2                 null,
constraint PK_MULTI_PARENT primary key (ID, "Order")
);

/*==============================================================*/
/* Table: Name_Desc                                             */
/*==============================================================*/
create table Name_Desc (
ID                   INT4                 not null,
Language             VARCHAR(2)           not null,
Description          VARCHAR(1000)        null,
Name                 VARCHAR(200)         null,
constraint PK_NAME_DESC primary key (ID, Language)
);

/*==============================================================*/
/* Table: Picture                                               */
/*==============================================================*/
create table Picture (
ID                   INT4                 not null,
Name                 VARCHAR(200)         null,
FileName             VARCHAR(500)         null,
constraint PK_PICTURE primary key (ID)
);

/*==============================================================*/
/* Table: Point                                                 */
/*==============================================================*/
create table Point (
ID                   INT4                 not null,
X                    FLOAT4               null,
Y                    FLOAT4               null,
constraint PK_POINT primary key (ID)
);

/*==============================================================*/
/* Table: Price                                                 */
/*==============================================================*/
create table Price (
ID                   INT4                 not null,
Price                FLOAT4               null,
Currency             VARCHAR(5)           null,
constraint PK_PRICE primary key (ID)
);

/*==============================================================*/
/* Table: Reservation                                           */
/*==============================================================*/
create table Reservation (
ID                   INT4                 not null,
Datum                TIMESTAMP            null,
DFrom                TIMESTAMP            null,
Dto                  TIMESTAMP            null,
Subject_ID           INT4                 null,
Reservation_Type_ID  INT4                 null,
Client_ID            INT4                 null,
Code                 VARCHAR(20)          null,
Count_0              INT2                 null,
Count_1              INT2                 null,
Count_2              INT2                 null,
Count_3              INT2                 null,
constraint PK_RESERVATION primary key (ID)
);

/*==============================================================*/
/* Table: Reservation_Type                                      */
/*==============================================================*/
create table Reservation_Type (
ID                   INT2                 not null,
Type                 VARCHAR(10)          null,
constraint PK_SUBJECT_TYPE primary key (ID)
);

/*==============================================================*/
/* Table: Restaurant                                            */
/*==============================================================*/
create table Restaurant (
Subject_ID           INT4                 not null,
Count                INT2                 null,
Price_Lunch          INT4                 null,
Kitchen_Name_Desc_ID INT4                 null,
constraint PK_RESTAURANT primary key (Subject_ID)
);

/*==============================================================*/
/* Table: Subject                                               */
/*==============================================================*/
create table Subject (
ID                   INT4                 not null,
Type_ID              INT2                 null,
Adress_ID            INT4                 null,
Erb_Pic              INT4                 null,
Name_Desc_ID         INT4                 null,
Info_ID              INT4                 null,
Contact_ID           INT4                 null,
Point_ID             INT4                 null,
Map_ID               INT4                 null,
Photo_Gallery_ID     INT4                 null,
Parent_ID            INT4                 null,
Parent_Type_ID       INT2                 null,
Multi_Parent_ID      INT4                 null,
Icons_ID             INT4                 null,
Events_ID            INT4                 null,
constraint PK_SUBJECT primary key (ID)
);

/*==============================================================*/
/* Table: Subject_Type                                          */
/*==============================================================*/
create table Subject_Type (
ID                   INT2                 not null,
Type                 VARCHAR(10)          null,
Name_Desc_ID         INT4                 null,
constraint PK_SUBJECT_TYPE primary key (ID)
);

alter table Castle
   add constraint FK_CASTLE_REFERENCE_SUBJECT foreign key (Subject_ID)
      references Subject (ID)
      on delete restrict on update restrict;

alter table Castle
   add constraint FK_CASTLE_REFERENCE_NAME_DES foreign key (Exsposure_Name_Desc_ID)
      references Name_Desc (ID)
      on delete restrict on update restrict;

alter table Client
   add constraint FK_CLIENT_REFERENCE_ADRESS foreign key (Adress_ID)
      references Adress (ID)
      on delete restrict on update restrict;

alter table Event
   add constraint FK_EVENT_REFERENCE_EVENT_TY foreign key (Event_Type_ID)
      references Event_Type (ID)
      on delete restrict on update restrict;

alter table Event
   add constraint FK_EVENT_REFERENCE_NAME_DES foreign key (Name_Desc_ID)
      references Name_Desc (ID)
      on delete restrict on update restrict;

alter table Event
   add constraint FK_EVENT_REFERENCE_SUBJECT foreign key (Subject_ID)
      references Subject (ID)
      on delete restrict on update restrict;

alter table Events
   add constraint FK_EVENTS_REFERENCE_EVENT foreign key (Event_ID)
      references Event (ID)
      on delete restrict on update restrict;

alter table Foto_Gallery
   add constraint FK_FOTO_GAL_REFERENCE_PICTURE foreign key (Pic_ID)
      references Picture (ID)
      on delete restrict on update restrict;

alter table Gallery
   add constraint FK_GALLERY_REFERENCE_SUBJECT foreign key (Subject_ID)
      references Subject (ID)
      on delete restrict on update restrict;

alter table Gallery
   add constraint FK_GALLERY_REFERENCE_NAME_DES foreign key (Exsposure_Name_Desc_ID)
      references Name_Desc (ID)
      on delete restrict on update restrict;

alter table Hotel
   add constraint FK_HOTEL_REFERENCE_SUBJECT foreign key (Subject_ID)
      references Subject (ID)
      on delete restrict on update restrict;

alter table Hotel
   add constraint FK_HOTEL_REFERENCE_PRICE_1BED foreign key (Price_1Bed)
      references Price (ID)
      on delete restrict on update restrict;

alter table Hotel
   add constraint FK_HOTEL_REFERENCE_PRICE_2BED foreign key (Price_2Bed)
      references Price (ID)
      on delete restrict on update restrict;

alter table Hotel
   add constraint FK_HOTEL_REF_PRICE_APARTMENT foreign key (Price_Apartment)
      references Price (ID)
      on delete restrict on update restrict;

alter table Hotel
   add constraint FK_HOTEL_REF_PRICE_BREAKFAST foreign key (Price_Breakfast)
      references Price (ID)
      on delete restrict on update restrict;

alter table Hotel
   add constraint FK_HOTEL_REFERENCE_NAME_DES foreign key (Breakfast_Name_Desc_ID)
      references Name_Desc (ID)
      on delete restrict on update restrict;

alter table Icon
   add constraint FK_ICON_REFERENCE_NAME_DES foreign key (Name_Desc_ID)
      references Name_Desc (ID)
      on delete restrict on update restrict;

alter table Icon
   add constraint FK_ICON_REFERENCE_PICTURE foreign key (Pic_ID)
      references Picture (ID)
      on delete restrict on update restrict;

alter table Icons
   add constraint FK_ICONS_REFERENCE_ICON foreign key (Icon_ID)
      references Icon (ID)
      on delete restrict on update restrict;

alter table Map
   add constraint FK_MAP_MAP_PIC0_PICTURE foreign key (Pic_0)
      references Picture (ID)
      on delete restrict on update restrict;

alter table Map
   add constraint FK_MAP_MAP_PIC1_PICTURE foreign key (Pic_1)
      references Picture (ID)
      on delete restrict on update restrict;

alter table Map
   add constraint FK_MAP_MAP_PIC2_PICTURE foreign key (Pic_2)
      references Picture (ID)
      on delete restrict on update restrict;

alter table Map
   add constraint FK_MAP_MAP_PIC3_PICTURE foreign key (Pic_3)
      references Picture (ID)
      on delete restrict on update restrict;

alter table Multi_Parent
   add constraint FK_MULTI_PA_REFERENCE_SUBJECT foreign key (Parent_ID)
      references Subject (ID)
      on delete restrict on update restrict;

alter table Multi_Parent
   add constraint FK_MULTI_PA_REFERENCE_SUBJECT_ foreign key (Parent_Type_ID)
      references Subject_Type (ID)
      on delete restrict on update restrict;

alter table Reservation
   add constraint FK_RESERVAT_REFERENCE_CLIENT foreign key (Client_ID)
      references Client (ID)
      on delete restrict on update restrict;

alter table Reservation
   add constraint FK_RESERVAT_REFERENCE_RESERVAT foreign key (Reservation_Type_ID)
      references Reservation_Type (ID)
      on delete restrict on update restrict;

alter table Reservation
   add constraint FK_RESERVAT_REFERENCE_SUBJECT foreign key (Subject_ID)
      references Subject (ID)
      on delete restrict on update restrict;

alter table Restaurant
   add constraint FK_RESTAURA_REFERENCE_SUBJECT foreign key (Subject_ID)
      references Subject (ID)
      on delete restrict on update restrict;

alter table Restaurant
   add constraint FK_RESTAURA_REFERENCE_PRICE foreign key (Price_Lunch)
      references Price (ID)
      on delete restrict on update restrict;

alter table Restaurant
   add constraint FK_RESTAURA_REFERENCE_NAME_DES foreign key (Kitchen_Name_Desc_ID)
      references Name_Desc (ID)
      on delete restrict on update restrict;

alter table Subject
   add constraint FK_SUBJECT_ERB_PICTURE foreign key (Erb_Pic)
      references Picture (ID)
      on delete restrict on update restrict;

alter table Subject
   add constraint FK_SUBJECT_REFERENCE_ADRESS foreign key (Adress_ID)
      references Adress (ID)
      on delete restrict on update restrict;

alter table Subject
   add constraint FK_SUBJECT_REFERENCE_CONTACT foreign key (Contact_ID)
      references Contact (ID)
      on delete restrict on update restrict;

alter table Subject
   add constraint FK_SUBJECT_REFERENCE_FOTO_GAL foreign key (Photo_Gallery_ID)
      references Foto_Gallery (ID)
      on delete restrict on update restrict;

alter table Subject
   add constraint FK_SUBJECT_REFERENCE_ICONS foreign key (Icons_ID)
      references Icons (ID)
      on delete restrict on update restrict;

alter table Subject
   add constraint FK_SUBJECT_REFERENCE_MAP foreign key (Map_ID)
      references Map (ID)
      on delete restrict on update restrict;

alter table Subject
   add constraint FK_SUBJECT_REFERENCE_MULTI_PA foreign key (Multi_Parent_ID)
      references Multi_Parent (ID)
      on delete restrict on update restrict;

alter table Subject
   add constraint FK_SUBJECT_REFERENCE_NAME_DES foreign key (Name_Desc_ID)
      references Name_Desc (ID)
      on delete restrict on update restrict;

alter table Subject
   add constraint FK_SUBJECT_REFERENCE_SUBJECT foreign key (Parent_ID)
      references Subject (ID)
      on delete restrict on update restrict;

alter table Subject
   add constraint FK_SUBJECT_TOWN_INFO_INFO foreign key (Info_ID)
      references Info (ID)
      on delete restrict on update restrict;

alter table Subject
   add constraint FK_SUBJECT_TOW_POINT_POINT foreign key (Point_ID)
      references Point (ID)
      on delete restrict on update restrict;

alter table Subject
   add constraint FK_SUB_FK_SUB_PAR_TYPE foreign key (Parent_Type_ID)
      references Subject_Type (ID)
      on delete restrict on update restrict;

alter table Subject
   add constraint FK_SUB_REF_SUB_TYPE foreign key (Type_ID)
      references Subject_Type (ID)
      on delete restrict on update restrict;

alter table Subject
   add constraint FK_SUBJECT_REFERENCE_EVENTS foreign key (Events_ID)
      references Events (ID)
      on delete restrict on update restrict;

alter table Subject_Type
   add constraint FK_SUBJECT__REFERENCE_NAME_DES foreign key (Name_Desc_ID)
      references Name_Desc (ID)
      on delete restrict on update restrict;

