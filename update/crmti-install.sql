﻿/****************************************************************************************************************
*** Legt Tabellen für die CRMTI an und erzeugt alle nötigen Funktionen ******************************************                                   
*** Version 1.0.1 geschrieben MAi/2011 von Ronny Kumke ronny@lxcars.de ******************************************
****************************************************************************************************************/

DROP TABLE IF EXISTS crmti CASCADE;;
CREATE TABLE crmti(																-- Telephone Integration
	crmti_id 				SERIAL PRIMARY KEY,
	crmti_init_time		timestamp with time zone DEFAULT NOW(),	-- Zeitpunt des Anrufes
	crmti_end_time			timestamp with time zone DEFAULT NOW(),	-- Zeitpunk Anrufende
	crmti_src				varchar(75),										-- Anrufquelle
	crmti_dst				varchar(75),										-- Anrufziel
	crmti_caller_id		int,													-- id des Telefonierenden
	crmti_caller_typ		char,													-- Kunde, Kieferant, Kontakt
	crmti_direction		varchar,												-- Richtung
	crmti_status			varchar(20)											-- Anrufstatus
);;
INSERT INTO crmti (crmti_src, crmti_dst) VALUES ('INSTALL.TXT','LESEN');;
CREATE OR REPLACE FUNCTION kuerze( INT, TEXT )
RETURNS text AS $$ 
-- Kürzt die Telefonummer von rechts auf n Stellen
-- (0049, +49, 0)-Problematik
DECLARE
	laenge INT;
BEGIN
  	laenge = length( $2 );
  	IF laenge <= $1 THEN
  		RETURN $2;
  	ELSE
   	RETURN substring( $2, laenge  - $1 + 1 );
  	END IF;
END; $$ LANGUAGE 'plpgsql' WITH (iscachable);;;


CREATE OR REPLACE FUNCTION SucheNummer( varchar(75) )
 	RETURNS record AS $$
-- Sucht die Telefonnummer in den LxO-Tabellen und gibt Namen (falls gefunden) sonst Nummer zurück 
-- ToDo Dynamische SQL-Abfrage mit EXECUTE statt des riesigen SELECT-Blocks verwenden
DECLARE
 	telnum ALIAS FOR $1;
  	myname text;
  	result record;
  	format text;
BEGIN
 	format := '99999999999999999';
  	IF telnum !~ '[0-9]' THEN 
 		SELECT INTO result 0 AS id, telnum::varchar(75) AS name, 'Y'::char AS typ;
     	return result;
 	END IF;
 	SELECT INTO result id, name::varchar(75), 'C'::char AS typ FROM (SELECT id, name, to_number(phone, format)::char(16) AS p, to_number(phone, format)::char(16) AS f, char_length(to_number(phone, format)::char(16)) AS l, char_length(to_number(phone, format)::char(16)) AS l1, char_length(to_number(telnum, format)::char(16)) AS lt FROM customer WHERE phone !='') AS xyz WHERE kuerze(lt,xyz.p) LIKE kuerze(l,to_number(telnum, format)::char(16))||'%';
 	IF result.name != '' THEN return result; END IF;
  	SELECT INTO result id, name::varchar(75), 'C'::char AS typ FROM (SELECT id, name, to_number(fax, format)::char(16) AS p, to_number(fax, format)::char(16) AS f, char_length(to_number(fax, format)::char(16)) AS l, char_length(to_number(fax, format)::char(16)) AS l1, char_length(to_number(telnum, format)::char(16)) AS lt FROM customer WHERE fax !='') AS xyz WHERE kuerze(lt,xyz.p) LIKE kuerze(l,to_number(telnum, format)::char(16))||'%';
	IF result.name != '' THEN return result; END IF;
	SELECT INTO result id, name AS name, 'V'::char AS typ FROM (SELECT id, name, to_number(phone, format)::char(16) AS p, to_number(phone, format)::char(16) AS f, char_length(to_number(phone, format)::char(16)) AS l, char_length(to_number(phone, format)::char(16)) AS l1, char_length(to_number(telnum, format)::char(16)) AS lt FROM vendor WHERE phone !='') AS xyz WHERE kuerze(lt,xyz.p) LIKE kuerze(l,to_number(telnum, format)::char(16))||'%';
	IF result.name != '' THEN return result; END IF;
	SELECT INTO result id, name, 'V'::char AS typ FROM (SELECT id, name, to_number(fax, format)::char(16) AS p, to_number(fax, format)::char(16) AS f, char_length(to_number(fax, format)::char(16)) AS l, char_length(to_number(fax, format)::char(16)) AS l1, char_length(to_number(telnum, format)::char(16)) AS lt FROM vendor WHERE fax !='') AS xyz WHERE kuerze(lt,xyz.p) LIKE kuerze(l,to_number(telnum, format)::char(16))||'%';
	IF result.name != '' THEN return result; END IF;
	SELECT INTO result id, name, 'K'::char AS typ FROM (SELECT cp_id AS id, (cp_givenname||' '||cp_name)::varchar(75) AS name, to_number(cp_phone1, format)::char(16) AS p, to_number(cp_phone1, format)::char(16) AS f, char_length(to_number(cp_phone1, format)::char(16)) AS l, char_length(to_number(cp_phone1, format)::char(16)) AS l1, char_length(to_number(telnum, format)::char(16)) AS lt FROM contacts WHERE cp_phone1 !='') AS xyz WHERE kuerze(lt,xyz.p) LIKE kuerze(l,to_number(telnum, format)::char(16))||'%';
	IF result.name != '' THEN return result; END IF;
	SELECT INTO result id, name, 'K'::char AS typ FROM (SELECT cp_id AS id, (cp_givenname||' '||cp_name)::varchar(75) AS name, to_number(cp_phone2, format)::char(16) AS p, to_number(cp_phone2, format)::char(16) AS f, char_length(to_number(cp_phone2, format)::char(16)) AS l, char_length(to_number(cp_phone2, format)::char(16)) AS l1, char_length(to_number(telnum, format)::char(16)) AS lt FROM contacts WHERE cp_phone2 !='') AS xyz WHERE kuerze(lt,xyz.p) LIKE kuerze(l,to_number(telnum, format)::char(16))||'%';
	IF result.name != '' THEN return result; END IF;
	SELECT INTO result id, name, 'K'::char AS typ FROM (SELECT cp_id AS id, (cp_givenname||' '||cp_name)::varchar(75) AS name, to_number(cp_mobile1, format)::char(16) AS p, to_number(cp_mobile1, format)::char(16) AS f, char_length(to_number(cp_mobile1, format)::char(16)) AS l, char_length(to_number(cp_mobile1, format)::char(16)) AS l1, char_length(to_number(telnum, format)::char(16)) AS lt FROM contacts WHERE cp_mobile1 !='') AS xyz WHERE kuerze(lt,xyz.p) LIKE kuerze(l,to_number(telnum, format)::char(16))||'%';
   IF result.name != '' THEN return result; END IF;
	SELECT INTO result id, name, 'K'::char AS typ FROM (SELECT cp_id AS id, (cp_givenname||' '||cp_name)::varchar(75) AS name, to_number(cp_mobile2, format)::char(16) AS p, to_number(cp_mobile2, format)::char(16) AS f, char_length(to_number(cp_mobile2, format)::char(16)) AS l, char_length(to_number(cp_mobile2, format)::char(16)) AS l1, char_length(to_number(telnum, format)::char(16)) AS lt FROM contacts WHERE cp_mobile2 !='') AS xyz WHERE kuerze(lt,xyz.p) LIKE kuerze(l,to_number(telnum, format)::char(16))||'%';
	IF result.name != '' THEN return result; END IF;
	SELECT INTO result id, name, 'K'::char AS typ FROM (SELECT cp_id AS id, (cp_givenname||' '||cp_name)::varchar(75) AS name, to_number(cp_privatphone, format)::char(16) AS p, to_number(cp_privatphone, format)::char(16) AS f, char_length(to_number(cp_privatphone, format)::char(16)) AS l, char_length(to_number(cp_privatphone, format)::char(16)) AS l1, char_length(to_number(telnum, format)::char(16)) AS lt FROM contacts WHERE cp_privatphone !='') AS xyz WHERE kuerze(lt,xyz.p) LIKE kuerze(l,to_number(telnum, format)::char(16))||'%';
	IF result.name != '' THEN return result; END IF;
	SELECT INTO result id, name, 'K'::char AS typ FROM (SELECT cp_id AS id, (cp_givenname||' '||cp_name)::varchar(75) AS name, to_number(cp_fax, format)::char(16) AS p, to_number(cp_fax, format)::char(16) AS f, char_length(to_number(cp_fax, format)::char(16)) AS l, char_length(to_number(cp_fax, format)::char(16)) AS l1, char_length(to_number(telnum, format)::char(16)) AS lt FROM contacts WHERE cp_fax !='') AS xyz WHERE kuerze(lt,xyz.p) LIKE kuerze(l,to_number(telnum, format)::char(16))||'%';
	IF result.name != '' THEN return result; END IF;
	SELECT INTO result 0 AS id, telnum::varchar(75) AS name, 'X'::char AS typ;
	return result;
END; $$ LANGUAGE 'plpgsql' WITH (iscachable);;;


CREATE OR REPLACE FUNCTION CallIn( text, text )
	RETURNS text AS $$
-- Für eingehende Anrufe, Sucht in src und gibt den Namen zurück, speichert
DECLARE
	src ALIAS FOR $1;
	dst ALIAS FOR $2;
	result record;
	lastid int;
BEGIN
	result := SucheNummer( src );
  	INSERT INTO crmti ( crmti_src, crmti_caller_id, crmti_caller_typ, crmti_dst, crmti_direction ) VALUES ( result.name, result.id, result.typ, dst, 'E') RETURNING crmti_id INTO lastid;
  	DELETE FROM crmti WHERE crmti_id  < lastid -25;
   IF result.typ != 'X' THEN
		insert into telcall ( calldate, bezug, cause, caller_id, kontakt, inout ) values ( CURRENT_TIMESTAMP, 0, 'Eingehender Anruf zu[r|m] '||dst, result.id, 'T','i' );
  	END IF;
return result.name;
END; $$ LANGUAGE 'plpgsql';;;



CREATE OR REPLACE FUNCTION CallOut( text, text )
	RETURNS text AS $$
-- Für ausgehende Anrufe 
DECLARE
 	src ALIAS FOR $1;
 	dst ALIAS FOR $2;
 	result record;
	lastid int;
BEGIN
	result := SucheNummer( dst );
	INSERT INTO crmti ( crmti_src, crmti_dst, crmti_caller_typ, crmti_caller_id, crmti_direction  ) VALUES ( src, result.name, result.typ, result.id, 'A' ) RETURNING crmti_id INTO lastid;
	DELETE FROM crmti WHERE crmti_id  < lastid -25;
	IF result.typ != 'X' THEN
		INSERT INTO telcall ( calldate, bezug, cause, caller_id, kontakt, inout ) values ( CURRENT_TIMESTAMP, 0, 'Ausgehender Anruf vo[n|m] '||src, result.id, 'T', 'o' );
	END IF;
return '1';
END; $$ LANGUAGE 'plpgsql';;;

CREATE OR REPLACE FUNCTION UpdateCaller()
-- Updatet crmti wenn Telefonnummer zugeordnet wurde oder sich der Kundenname geändert hat (total wichtig...
    RETURNS TRIGGER AS $$
DECLARE 
    result record;
    test record;
BEGIN  
   FOR test IN SELECT crmti_id, crmti_src, crmti_dst, crmti_caller_typ, crmti_direction, crmti_caller_id FROM crmti REVERSE LOOP  
	IF test.crmti_direction = 'E' THEN 
	    IF test.crmti_src ~ '[0-9]' THEN 
	     result := SucheNummer( test.crmti_src );
	     UPDATE crmti SET crmti_src = result.name, crmti_caller_id = result.id, crmti_caller_typ = result.typ WHERE crmti_id = test.crmti_id;
	   ELSEIF test.crmti_caller_typ = 'C ' THEN
	        --UPDATE crmti SET crmti_src = (SELECT name FROM customer WHERE id = crmti_caller_id) WHERE crmti_caller_id = test.;
	      	SELECT INTO result name FROM (SELECT name FROM customer WHERE id = test.crmti_caller_id ) AS name;
	      	UPDATE crmti SET crmti_src = result.name WHERE crmti_id = test.crmti_id;
	   ELSEIF test.crmti_caller_typ = 'V' THEN
	      	SELECT INTO result name FROM (SELECT name FROM vendor WHERE id = test.crmti_caller_id )AS name;
	      	UPDATE crmti SET crmti_src = result.name WHERE crmti_id = test.crmti_id;
	   ELSEIF test.crmti_caller_typ = 'P' THEN
	 	SELECT INTO result name FROM (SELECT (cp_givenname||' '||cp_name)::varchar(75) AS name FROM contacts WHERE id = test.crmti_caller_id) AS name;
	 	UPDATE crmti SET crmti_src = result.name WHERE crmti_id = test.crmti_id;
	   END IF;
	     				
	     /*toDo tellcall insert*/
	
	END IF;
	IF test.crmti_direction = 'A' THEN 
	  IF test.crmti_dst ~ '[0-9]' THEN 
	     result := SucheNummer( test.crmti_dst );
	     UPDATE crmti SET crmti_dst = result.name, crmti_caller_id = result.id, crmti_caller_typ = result.typ WHERE crmti_id = test.crmti_id;  
	   ELSEIF test.crmti_caller_typ = 'C ' THEN
	      	SELECT INTO result name FROM (SELECT name FROM customer WHERE id = test.crmti_caller_id ) AS name;
	      	UPDATE crmti SET crmti_dst = result.name WHERE crmti_id = test.crmti_id;
	   ELSEIF test.crmti_caller_typ = 'V' THEN
	      	SELECT INTO result name FROM (SELECT name FROM vendor WHERE id = test.crmti_caller_id )AS name;
	      	UPDATE crmti SET crmti_dst = result.name WHERE crmti_id = test.crmti_id;
	   ELSEIF test.crmti_caller_typ = 'P' THEN
	 	SELECT INTO result name FROM (SELECT (cp_givenname||' '||cp_name)::varchar(75) AS name FROM contacts WHERE id = test.crmti_caller_id) AS name;
	 	UPDATE crmti SET crmti_dst = result.name WHERE crmti_id = test.crmti_id;
           END IF;
	     				
	     /*toDo tellcall insert*/
	END IF;    
   END LOOP;
 RETURN new;
END; $$ LANGUAGE 'plpgsql';;;

DROP TRIGGER IF EXISTS TriggerUpdateCaller ON customer;;
DROP TRIGGER IF EXISTS TriggerUpdateCaller ON vendor;;
DROP TRIGGER IF EXISTS TriggerUpdateCaller ON contacts;;
CREATE TRIGGER TriggerUpdateCaller AFTER INSERT OR UPDATE ON customer FOR EACH ROW EXECUTE PROCEDURE UpdateCaller();;
CREATE TRIGGER TriggerUpdateCaller AFTER INSERT OR UPDATE ON vendor FOR EACH ROW EXECUTE PROCEDURE UpdateCaller();;
CREATE TRIGGER TriggerUpdateCaller AFTER INSERT OR UPDATE ON contacts FOR EACH ROW EXECUTE PROCEDURE UpdateCaller();;

