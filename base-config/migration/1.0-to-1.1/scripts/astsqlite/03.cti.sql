
CREATE TABLE cticontexts (
 id integer unsigned,
 name varchar(50),
 directories text NOT NULL,
 display text NOT NULL,
 description text NOT NULL,
 deletable tinyint(1),
 PRIMARY KEY(id)
);

INSERT INTO cticontexts VALUES(3,'default','xivodir','Display','Contexte par défaut',1);

CREATE TABLE ctidirectories (
 id integer unsigned,
 name varchar(255),
 uri varchar(255),
 delimiter varchar(20),
 match_direct text NOT NULL,
 match_reverse text NOT NULL,
 display_reverse varchar(255),
 description varchar(255),
 deletable tinyint(1),
 PRIMARY KEY(id)
);

INSERT INTO ctidirectories VALUES(1,'xivodir', 'phonebook', '', '["phonebook.firstname","phonebook.lastname","phonebook.displayname","phonebook.society","phonebooknumber.office.number"]','["phonebooknumber.office.number","phonebooknumber.mobile.number"]','["{db-fullname}"]','Répertoire XiVO Externe',1);
INSERT INTO ctidirectories VALUES(2,'internal','internal','','','','','Répertoire XiVO Interne',1);

DROP TABLE ctidirectoryfields;
CREATE TABLE ctidirectoryfields (
	dir_id integer unsigned,
	fieldname varchar(255),
	value varchar(255),
	PRIMARY KEY(dir_id, fieldname)
);

INSERT INTO ctidirectoryfields VALUES (1, 'phone'    , 'phonebooknumber.office.number');
INSERT INTO ctidirectoryfields VALUES (1, 'firstname', 'phonebook.firsname');
INSERT INTO ctidirectoryfields VALUES (1, 'lastname' , 'phonebook.lastname');
INSERT INTO ctidirectoryfields VALUES (1, 'fullname' , 'phonebook.fullname');
INSERT INTO ctidirectoryfields VALUES (1, 'company'  , 'phonebook.company');
INSERT INTO ctidirectoryfields VALUES (1, 'mail'     , 'phonebook.email');
INSERT INTO ctidirectoryfields VALUES (2, 'fullname' , '{internal-fullname}');


CREATE TABLE ctidisplays (
 id integer unsigned,
 name varchar(50),
 data text NOT NULL,
 deletable tinyint(1),
 description text NOT NULL,
 PRIMARY KEY(id)
);

INSERT INTO ctidisplays VALUES(4,'Display','{"10": [ "Numéro","phone","","{db-phone}" ],"20": [ "Nom","","","{db-fullname}" ],"30": [ "Entreprise","","Inconnue","{db-company}" ],"40": [ "E-mail","","","{db-mail} ({xivo-directory})" ]}',1,'Affichage par défaut');


CREATE TABLE ctimain (
 id integer unsigned,
 commandset varchar(20),
 fagi_ip varchar(255),
 fagi_port integer unsigned,
 cti_ip varchar(255),
 cti_port integer unsigned,
 webi_ip varchar(255),
 webi_port integer unsigned,
 info_ip varchar(255),
 info_port integer unsigned,
 announce_ip varchar(255),
 announce_port integer unsigned,
 asterisklist varchar(255),
 updates_period integer unsigned,
 socket_timeout integer unsigned,
 login_timeout integer unsigned,
 parting_astid_context varchar(255),
 PRIMARY KEY(id)
);

INSERT INTO ctimain VALUES(1, 'xivocti', '127.0.0.1', 5002, '0.0.0.0', 5003, '127.0.0.1', 5004, '127.0.0.1', 5005, '127.0.0.1', 5006, 1, 60, 10, 5, 'context');


CREATE TABLE ctiphonehints (
 id integer unsigned,
 number integer,
 name varchar(255),
 color varchar(128),
 PRIMARY KEY(id)
);

INSERT INTO ctiphonehints VALUES(1,-2,'Inexistant','#030303');
INSERT INTO ctiphonehints VALUES(2,-1,'Désactivé','#000000');
INSERT INTO ctiphonehints VALUES(3,0,'Disponible','#0DFF25');
INSERT INTO ctiphonehints VALUES(4,1,'En ligne OU appelle','#FF032D');
INSERT INTO ctiphonehints VALUES(5,2,'Occupé','#FF0008');
INSERT INTO ctiphonehints VALUES(6,4,'Indisponible','#FFFFFF');
INSERT INTO ctiphonehints VALUES(7,8,'Sonne','#1B0AFF');
INSERT INTO ctiphonehints VALUES(8,9,'(En Ligne OU Appelle) ET Sonne','#FF0526');
INSERT INTO ctiphonehints VALUES(9,16,'En Attente','#F7FF05');


CREATE TABLE ctipresences (
 id integer unsigned,
 name varchar(255),
 description varchar(255),
 deletable tinyint(1),
 PRIMARY KEY(id)
);

INSERT INTO ctipresences VALUES(1,'xivo','De base non supprimable',0);


CREATE TABLE ctiprofiles (
 id integer unsigned,
 xlets text,
 funcs varchar(255),
 maxgui integer,
 appliname varchar(255),
 name varchar(40) unique,
 presence varchar(255),
 services varchar(255),
 preferences varchar(2048),
 deletable tinyint(1),
 PRIMARY KEY(id)
);

INSERT INTO ctiprofiles VALUES(9,'[[ "queues", "dock", "fms", "N/A" ],[ "queuedetails", "dock", "fms", "N/A" ],[ "queueentrydetails", "dock", "fcms", "N/A" ],[ "agents", "dock", "fcms", "N/A" ],[ "agentdetails", "dock", "fcms", "N/A" ],[ "identity", "grid", "fcms", "0" ],[ "conference", "dock", "fcm", "N/A" ]]','agents,presence,switchboard',-1,'Superviseur','agentsup','xivo','','',1);
INSERT INTO ctiprofiles VALUES(10,'[[ "queues", "dock", "ms", "N/A" ],[ "identity", "grid", "fcms", "0" ],[ "customerinfo", "dock", "cms", "N/A" ],[ "agentdetails", "dock", "cms", "N/A" ]]','presence',-1,'Agent','agent','xivo','','',1);
INSERT INTO ctiprofiles VALUES(11,'[[ "tabber", "grid", "fcms", "1" ],[ "dial", "grid", "fcms", "2" ],[ "search", "tab", "fcms", "0" ],[ "customerinfo", "tab", "fcms", "4" ],[ "identity", "grid", "fcms", "0" ],[ "fax", "tab", "fcms", "N/A" ],[ "history", "tab", "fcms", "N/A" ],[ "directory", "tab", "fcms", "N/A" ],[ "features", "tab", "fcms", "N/A" ],[ "mylocaldir", "tab", "fcms", "N/A" ],[ "conference", "tab", "fcms", "N/A" ]]','presence,customerinfo',-1,'Client','client','xivo','','',1);
INSERT INTO ctiprofiles VALUES(12,'[[ "tabber", "grid", "fcms", "1" ],[ "dial", "grid", "fcms", "2" ],[ "search", "tab", "fcms", "0" ],[ "customerinfo", "tab", "fcms", "4" ],[ "identity", "grid", "fcms", "0" ],[ "fax", "tab", "fcms", "N/A" ],[ "history", "tab", "fcms", "N/A" ],[ "directory", "tab", "fcms", "N/A" ],[ "features", "tab", "fcms", "N/A" ],[ "mylocaldir", "tab", "fcms", "N/A" ],[ "conference", "tab", "fcms", "N/A" ],[ "outlook", "tab", "fcms", "N/A" ]]','presence,customerinfo',-1,'Client+Outlook','clientoutlook','xivo','','',1);
INSERT INTO ctiprofiles VALUES(13,'[[ "datetime", "dock", "fm", "N/A" ]]','',-1,'Horloge','clock','xivo','','',1);
INSERT INTO ctiprofiles VALUES(14,'[[ "dial", "dock", "fm", "N/A" ],[ "operator", "dock", "fcm", "N/A" ],[ "datetime", "dock", "fcm", "N/A" ],[ "identity", "grid", "fcms", "0" ],[ "calls", "dock", "fcm", "N/A" ],[ "parking", "dock", "fcm", "N/A" ],[ "calls", "dock", "fcm", "N/A" ]]','presence,switchboard,search,dial',-1,'Opérateur','oper','xivo','','',1);
INSERT INTO ctiprofiles VALUES(15,'[[ "parking", "dock", "fcms", "N/A" ],[ "search", "dock", "fcms", "N/A" ],[ "calls", "dock", "fcms", "N/A" ],[ "switchboard", "dock", "fcms", "N/A" ],[ "customerinfo", "dock", "fcms", "N/A" ],[ "datetime", "dock", "fcms", "N/A" ],[ "dial", "dock", "fcms", "N/A" ],[ "identity", "grid", "fcms", "0" ],[ "operator", "dock", "fcms", "N/A" ]]','switchboard,dial,presence,customerinfo,search,agents,conference,directory,features,history,fax,chitchat,database',5,'Switchboard','switchboard','xivo','','',1);


CREATE TABLE ctireversedirectories (
 id integer unsigned,
 context varchar(50),
 extensions  text NOT NULL,
 directories text NOT NULL,
 description text NOT NULL,
 deletable tinyint(1),
 PRIMARY KEY(id)
);

INSERT INTO ctireversedirectories VALUES(1,'*', '*', '["xivodir"]','Répertoires XiVO',1);


CREATE TABLE ctisheetactions (
 id integer unsigned,
 name varchar(50),
 description text NOT NULL,
 context varchar(50),
 whom varchar(50),
 extrarequests varchar(50),
 capaids text NOT NULL,
 sheet_info text,
 systray_info text,
 sheet_qtui text,
 action_info text,
 focus tinyint(1),
 deletable tinyint(1),
 PRIMARY KEY(id)
);

INSERT INTO ctisheetactions VALUES(6,'dial','','["default"]','dest','','["agentsup","agent","client"]','{"10": [ "","text","Inconnu","Appel {xivo-direction} de {xivo-calleridnum}" ],"20": [ "Numéro entrant","phone","Inconnu","{xivo-calleridnum}" ],"30": [ "Nom","text","Inconnu","{db-fullname}" ],"40": [ "Numéro appelé","phone","Inconnu","{xivo-calledidnum}" ]}','{"10": [ "","title","","Appel {xivo-direction}" ],"20": [ "","body","Inconnu","appel de {xivo-calleridnum} pour {xivo-calledidnum}" ],"30": [ "","body","Inconnu","{db-fullname} (selon {xivo-directory})" ],"40": [ "","body","","le {xivo-date}, il est {xivo-time}" ]}','','{"10": [ "","urlauto","","http://www.google.fr/search?q={xivo-calleridnum}" ]}','',1);
INSERT INTO ctisheetactions VALUES(7,'queue','','["default"]','dest','','["agentsup","agent","client"]','{"10": [ "","text","Inconnu","Appel {xivo-direction} de la File {xivo-queuename}" ],"20": [ "Numéro entrant","phone","Inconnu","{xivo-calleridnum}" ],"30": [ "Nom","text","Inconnu","{db-fullname}" ]}','{"10": [ "","title","","Appel {xivo-direction} de la File {xivo-queuename}" ],"20": [ "","body","Inconnu","appel de {xivo-calleridnum} pour {xivo-calledidnum}" ],"30": [ "","body","Inconnu","{db-fullname} (selon {xivo-directory})" ],"40": [ "","body","","le {xivo-date}, il est {xivo-time}" ]}','file:///etc/pf-xivo/ctiservers/form.ui','{}','',1);
INSERT INTO ctisheetactions VALUES(8,'custom1','','["default"]','all','','["agentsup","agent","client"]','{"10": [ "","text","Inconnu","Appel {xivo-direction} (Custom)" ],"20": [ "Numéro entrant","phone","Inconnu","{xivo-calleridnum}" ],"30": [ "Nom","text","Inconnu","{db-fullname}" ]}','{"10": [ "","title","","Appel {xivo-direction} (Custom)" ],"20": [ "","body","Inconnu","appel de {xivo-calleridnum} pour {xivo-calledidnum}" ],"30": [ "","body","Inconnu","{db-fullname} (selon {xivo-directory})" ],"40": [ "","body","","le {xivo-date}, il est {xivo-time}" ]}','','{}','',1);


CREATE TABLE ctisheetevents (
 id integer unsigned,
 agentlinked varchar(50),
 agentunlinked varchar(50),
 faxreceived varchar(50),
 incomingqueue varchar(50),
 incominggroup varchar(50),
 incomingdid varchar(50),
 dial varchar(50),
 link varchar(50),
 unlink varchar(50),
 custom text NOT NULL,
 PRIMARY KEY(id)
);

INSERT INTO ctisheetevents VALUES(1,'','','','','','','dial','','','{"example1": "custom1"}');


CREATE TABLE ctistatus (
 id integer unsigned,
 presence_id integer unsigned,
 name varchar(255),
 display_name varchar(255),
 actions varchar(255),
 color varchar(20),
 access_status varchar(255),
 deletable tinyint(1),
 PRIMARY KEY(id)
);

INSERT INTO ctistatus VALUES(1,1,'available','Disponible','enablednd(false)','#08FD20','1,2,3,4,5',1);
INSERT INTO ctistatus VALUES(2,1,'away','Sorti','enablednd(true)','#FDE50A','1,2,3,4,5',1);
INSERT INTO ctistatus VALUES(3,1,'outtolunch','Parti Manger','enablednd(true)','#001AFF','1,2,3,4,5',1);
INSERT INTO ctistatus VALUES(4,1,'donotdisturb','Ne pas déranger','enablednd(true)','#FF032D','1,2,3,4,5',1);
INSERT INTO ctistatus VALUES(5,1,'berightback','Bientôt de retour','enablednd(true)','#FFB545','1,2,3,4,5',1);

