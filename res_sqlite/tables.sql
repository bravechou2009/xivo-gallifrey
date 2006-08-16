# Tables for res_sqlite.so.

# RealTime static table.
CREATE TABLE ast_config (
 id INTEGER PRIMARY KEY,
 filename VARCHAR(128) NOT NULL,
 category VARCHAR(128) NOT NULL,
 commented INT(11) NOT NULL DEFAULT '0',
 var_name VARCHAR(128) NOT NULL,
 var_val VARCHAR(128) NOT NULL
);

CREATE INDEX ast_config_filename_commented ON ast_config(filename, commented);

# CDR table (this table is automatically created if non existent).
#CREATE TABLE ast_cdr (
# id INTEGER PRIMARY KEY,
# clid VARCHAR(80) NOT NULL DEFAULT '',
# src VARCHAR(80) NOT NULL DEFAULT '',
# dst VARCHAR(80) NOT NULL DEFAULT '',
# dcontext VARCHAR(80) NOT NULL DEFAULT '',
# channel VARCHAR(80) NOT NULL DEFAULT '',
# dstchannel VARCHAR(80) NOT NULL DEFAULT '',
# lastapp VARCHAR(80) NOT NULL DEFAULT '',
# lastdata VARCHAR(80) NOT NULL DEFAULT '',
# start CHAR(19) NOT NULL DEFAULT '0000-00-00 00:00:00',
# answer CHAR(19) NOT NULL DEFAULT '0000-00-00 00:00:00',
# end CHAR(19) NOT NULL DEFAULT '0000-00-00 00:00:00',
# duration INT(11) NOT NULL DEFAULT '0',
# billsec INT(11) NOT NULL DEFAULT '0',
# disposition INT(11) NOT NULL DEFAULT '0',
# amaflags INT(11) NOT NULL DEFAULT '0',
# accountcode VARCHAR(20) NOT NULL DEFAULT '',
# uniqueid VARCHAR(32) NOT NULL DEFAULT '',
# userfield VARCHAR(255) NOT NULL DEFAULT ''
#);

# SIP RealTime table.
CREATE TABLE ast_sip (
 id INTEGER PRIMARY KEY,
 name VARCHAR(80) NOT NULL,
 commented INT(11) NOT NULL DEFAULT '0',
 accountcode VARCHAR(20),
 amaflags VARCHAR(13),
 callgroup VARCHAR(10),
 callerid VARCHAR(80),
 canreinvite CHAR(3),
 context VARCHAR(80),
 defaultip VARCHAR(15),
 dtmfmode VARCHAR(7),
 fromuser VARCHAR(80),
 fromdomain VARCHAR(80),
 fullcontact VARCHAR(80),
 host VARCHAR(31) NOT NULL,
 insecure VARCHAR(4),
 language CHAR(2),
 mailbox VARCHAR(50),
 md5secret VARCHAR(80),
 nat VARCHAR(5) NOT NULL DEFAULT 'no',
 deny VARCHAR(95),
 permit VARCHAR(95),
 mask VARCHAR(95),
 pickupgroup VARCHAR(10),
 port VARCHAR(5) NOT NULL,
 qualify CHAR(3),
 restrictcid CHAR(1),
 rtptimeout CHAR(3),
 rtpholdtimeout CHAR(3),
 secret VARCHAR(80),
 type VARCHAR(6) NOT NULL DEFAULT 'friend',
 username VARCHAR(80) NOT NULL,
 disallow VARCHAR(100),
 allow VARCHAR(100),
 musiconhold VARCHAR(100),
 regseconds INT(11) NOT NULL DEFAULT '0',
 ipaddr VARCHAR(15) NOT NULL,
 regexten VARCHAR(80) NOT NULL,
 cancallforward CHAR(3),
 setvar VARCHAR(100) NOT NULL
);

CREATE UNIQUE INDEX ast_sip_name ON ast_sip(name);
