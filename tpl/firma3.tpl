<!-- $Id$ -->
<html>
	<head><title></title>
	<link type="text/css" REL="stylesheet" HREF="css/main.css"></link>
	<link type="text/css" REL="stylesheet" HREF="css/tabcontent.css"></link>
	<script language="JavaScript">
	<!--
	function showM (month) {
		Frame=eval("parent.main_window");
		uri="firma3.php?Q={Q}&jahr={JAHR}&monat=" + month + "&fid=" + {FID};
		Frame.location.href=uri;
	}
	//-->
	</script>
<body>
<p class="listtop">Detailansicht {FAART}</p>
<div style="position:absolute; top:44px; left:10px;  width:770px;">
	<ul id="maintab" class="shadetabs">
	<li><a href="{Link1}">Kundendaten</a><li>
	<li><a href="{Link2}">Ansprechpartner</a></li>
	<li class="selected"><a href="{Link3}" id="aktuell">Ums&auml;tze</a></li>
	<li><a href="{Link4}">Dokumente</a></li>
	</ul>
</div>

<span style="position:absolute; left:10px; top:67px; width:99%;">
<!-- Hier beginnt die Karte  ------------------------------------------->
<div style="position:absolute; left:0px; top:0px; width:450px; border:1px solid black" class="fett">
	{Name} &nbsp; {customernumber}<br />
	{Plz} {Ort}
</div>
<span style="position:absolute; left:470px; top:7px;">[<a href="opportunity.php?fid={FID}">Auftragschancen</a>]</span>
<div style="position:absolute; left:1px; top:45px; width:99%;text-align:center;" class="normal">
	Nettoums&auml;tze &uuml;ber 12 Monate 
	[<a href='firma3.php?fid={FID}&jahr={JAHRZ}'>Fr&uuml;her</a>] [<a href='firma3.php?fid={FID}&jahr={JAHRV}'>{JAHRVTXT}</a>]
	<div style="float:left; width:210px; text-align:left; " >
		<table>
			<tr>
				<th class="smal" width="10%">Monat</th>
				<th class="smal"></th><th class="smal">Umsatz</th>
				<th class="smal">Angebot</td><td width="10%"></td>
			</tr>
<!-- BEGIN Liste -->
			<tr onMouseover="this.bgColor='#FF0000';" onMouseout="this.bgColor='{LineCol}';" bgcolor="{LineCol}" onClick="showM('{Month}');">
				<td class="smal">{Month}</td>
				<td class="smal">{Rcount}</td><td class="smal re">{RSumme}</td>
				<td class="smal re">{ASumme}</td><td class="smal">{Curr}</td>
			</tr>
<!-- END Liste -->
		</table>
	</div>
	<div style="float:left; text-align:right; width:520px;" class="fett">
		<img src="{IMG}" width="500" height="280" title="Umsatzdaten der letzten 12 Monate"><br /><br />
	</div>
</div>
<!-- Hier endet die Karte ------------------------------------------->
</span>
</body>
</html>
