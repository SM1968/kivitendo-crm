<!-- $Id$ -->
<html>
	<head><title></title>
	<link type="text/css" REL="stylesheet" HREF="css/main.css"></link>
	<script language="JavaScript">
	<!--
	function toggle(was1,was2) {
		document.getElementById(was1).style.display="none";
		document.getElementById(was2).style.display="block";
	}
	function sichern() {
		document.getElementById("ok").style.display="block";
	}
	function suchFa() {
		val=document.formular.name.value;
		f1=open("suchFa.php?op=1&name="+val,"suche","width=350,height=200,left=100,top=100");
	}
	//-->
	</script>
	{jcal0}
<body>
<p class="listtop">Auftragschance</p>
<span style="position:absolute; left:10px; top:50px; width:95%;">
<!-- Hier beginnt die Karte  ------------------------------------------->
<form name="formular" action="opportunity.php" method="post">
<input type="hidden" name="id" value="{id}">
<input type="hidden" name="fid" value="{fid}">
<input type="hidden" name="firma" value="{name}">
<div style="position:absolute; left:1px; width:550px; top:50px; border: 0px solid black; text-align:center;" class="normal">
	<div class="zeile">
		<span class="label" onClick='toggle("fa1","fa2");'>Firma</span>
		<span class="leftfeld pad value" style="width:450px; display:{block}" id="fa2" onClick='toggle("fa2","fa1");'>{name}</span>
		<span class="leftfeld"     style="width:450px; display:{none};" id="fa1">
			<input type="text" size="40" name="name" value="{name}" onChange="sichern()"> 
		<a href="javascript:suchFa();"><img src="image/suchen_kl.png" border="0" title="Firma suchen" ></a>
		</span>
	</div>
	<div class="zeile">
		<span class="label" onClick='toggle("ti1","ti2");'>Schlagzeile</span>
		<span class="leftfeld pad value" style="width:450px; display:{block}" onClick='toggle("ti2","ti1");' id="ti2">{title}</span>
		<span class="leftfeld"     style="width:450px; display:{none};" id="ti1">
			<input type="text" size="55" name="title" value="{title}" onChange="sichern()">
		</span>
	</div>
	<div class="zeile">
		<span class="label" onClick='toggle("be1","be2");'>Betrag</span>
		<span class="leftfeld pad value" style="width:450px; display:{block}" onClick='toggle("be2","be1");' id="be2">{betrag}</span>
		<span class="leftfeld"     style="width:450px; display:{none};" id="be1">
			<input type="text" size="10" name="betrag" value="{betrag}" onChange="sichern()"> &euro;
		</span>
	</div>
	<div class="zeile">
		<span class="label" onClick='toggle("zi1","zi2");'>Zieldatum</span>
		<span class="leftfeld pad value" style="width:450px; display:{block}" onClick='toggle("zi2","zi1");' id="zi2">{zieldatum}</span>
		<span class="leftfeld"     style="width:450px; display:{none};" id="zi1">
			<input type="text" size="10" name="zieldatum" id="zieldatum" value="{zieldatum}" onChange="sichern()"> tt.mm.jjjj {jcal1}
		</span>
	</div>
	<div class="zeile">
		<span class="label">Chance</span>
		<span class="leftfeld"><select name="chance" onChange="sichern()">
			<option value="" {csel}>---</option>
			<option value="1" {csel1}>10%</option>
			<option value="2" {csel3}>20%</option>
			<option value="3" {csel3}>30%</option>
			<option value="4" {csel4}>40%</option>
			<option value="5" {csel5}>50%</option>
			<option value="6" {csel6}>60%</option>
			<option value="7" {csel7}>70%</option>
			<option value="8" {csel8}>80%</option>
			<option value="9" {csel9}>90%</option>
			<option value="10" {csel10}>100%</option>
			</select>
		</span>
	</div>
	<div class="zeile">
		<span class="label">Status</span>
		<span class="leftfeld"><select name="status" onChange="sichern()">
			<option value="" {ssel}>---</option>
			<option value="1" {ssel1}>Neu</option>
			<option value="2" {ssel2}>Wert-Angebot</option>
			<option value="3" {ssel3}>Entscheidungsfindung</option>
			<option value="4" {ssel4}>bedarf Analyse</option>
			<option value="5" {ssel5}>Gewonnen</option>
			<option value="6" {ssel6}>Aufgeschoben</option>
			<option value="7" {ssel7}>wieder offen</option>
			<option value="8" {ssel8}>Verloren</option>
			</select>
		</span>
	</div>
	<div class="zeile">
		<span class="label" onClick='toggle("no1","no2");'>Notiz</span>
		<span class="leftfeld pad value" style="width:450px; display:{block}" onClick='toggle("no2","no1");' id="no2">
			{notxt}
		</span>
		<span class="leftfeld" style="width:350px; display:{none};" id="no1">
			<textarea name="notiz" cols="70" rows="10" onChange="sichern()">{notiz}</textarea>
		</span>
	</div>
	<div class="zeile">
		<span class="label"></span>
		<span class="leftfeld" style="width:350px; display:{none};" id="ok">
			<input type="image" src="image/suchen_kl.png" alt='Suchen' title='Suchen' name="suchen" value="suchen" style="visibility:{search};"> &nbsp;
			<input type='image' src='image/save_kl.png' alt='Sichern' title='Sichern' name='save' value='neu' style="visibility:{save};"> &nbsp; 
			{msg}
		</span>
	</div>

</div>
<span style="display:{block};">
	<a href="firma1.php?id={fid}"><img src="image/addressbook.png" border="0" alt="Kundenstammdaten" title="Kundenstammdaten"></a>
	<a href="opportunity.php?fid={fid}"><img src="image/listen.png" border="0" alt="Chancen eines Kunden" title="Chancen eines Kunden"></a>
	<a href="opportunity.php"><img src="image/new.png" border="0" alt="Neu/Suche" title="Neu/Suche"></a>
</span>				
</form>
<!-- Hier endet die Karte ------------------------------------------->
</span>
{jcal2}
</body>
</html>
