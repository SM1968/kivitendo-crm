<?
// $Id: kartei.php hlindemann $
	require("inc/stdLib.php");
	include("inc/FirmenLib.php");
	include('inc/phpOpenOffice.php');
	if ($_GET["fid"]) {
		$fa=getFirmenStamm($_GET["fid"],true,"C");
		$fa["number"]=$fa["customernumber"];
	} if ($_GET["lid"]) {
		$fa=getFirmenStamm($_GET["lid"],true,"V");
		$fa["number"]=$fa["vendornumber"];
		$fa["kdtyp"]=$fa["lityp"];
	}
	$var=array();
		if ($key == "typrabatt") $val=$val*100;
	$fa["typrabatt"]= $fa["typrabatt"]*100;
	$fa["creditlimit"]= sprintf("%0.2f",$fa["creditlimit"]);
	$fa["discount"]= sprintf("%0.2f",$fa["discount"]*100);
	$fa["itime"]= db2date($fa["itime"]);
	$fa["mtime"]= db2date($fa["mtime"]);
	$doc = new phpOpenOffice();
	if (file_exists("vorlage/firmenkartei.sxw") {
		$doc->loadDocument("vorlage/firmenkartei.sxw");
	} else {
		$doc->loadDocument("vorlage/firmenkartei.odt");
	}
	$doc->parse($fa);
	$doc->download("");
	$doc->clean();

?>

