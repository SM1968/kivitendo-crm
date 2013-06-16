<script language="JavaScript" type="text/javascript">
	function OpenIOQ (src,id,type) {
		if 	    (src=="C"&&type=="inv") { uri="../is.pl?action=edit&id=" + id }
		else if (src=="V"&&type=="inv") { uri="../ap.pl?action=edit&id=" + id }
		else if (src=="C"&&type=="quo") { uri="../oe.pl?action=edit&type=sales_quotation&vc=customer&id=" + id }
		else if (src=="V"&&type=="quo") { uri="../oe.pl?action=edit&type=sales_quotation&vc=vendor&id=" + id }
		else if (src=="C"&&type=="ord") { uri="../oe.pl?action=edit&type=sales_order&vc=customer&id=" + id }
		else if (src=="V"&&type=="ord") { uri="../oe.pl?action=edit&type=sales_order&vc=vendor&id=" + id }
     	window.location.href=uri;
	}

    $(document).ready(
       	$(function() {
      	    $("#result_ioq")
         	    .tablesorter({widthFixed: true, widgets: ['zebra']})
                .tablesorterPager({container: $("#pager_tab"), size: 15, positionFixed: false})
                
		})
	);  
</script>
<?php
/****************************************************************************************
*** Erzeugt eine Tabelle mit offenen bzw. allen Aufträgen, Angeboten oder Rechungen   ***
****************************************************************************************/

//!!!!!!!!!ToDo: bgCol, Tablesorter reparieren
// Warum funzt der TableSorter nicht mehr nach dem zweitem Klick auf einem der Reiter????

include ("../inc/crmLib.php");
include ("../inc/stdLib.php");
$rs = getIOQ($_GET['fid'],$_GET['Q'],$_GET["type"],false);
echo "<div><table id='result_ioq' class='tablesorter'>\n"; 
echo "<thead><tr><th>".translate('.:date:.','firma')."</th><th>".translate('.:first position:.','firma')."</th><th>"
     .translate('.:amount:.','firma')."</th><th>".translate('.:number:.','firma')." </th></tr></thead>\n<tbody>\n";
$i=0; 
if ($rs) 
    foreach($rs as $row) { 
        echo "<tr onClick='OpenIOQ(\"".$_GET['Q']."\",".$row["id"].",\"".$_GET['type']."\");'>". 
             "<td>".$row["date"]."</td><td>".$row["description"]."</td>". 
             "<td align='right'>".$row["amount"]."</td><td>".$row["number"]."</td></tr>\n"; 
        $i++; 
    } 
echo "</tbody></table>\n</div>"; 
?>

<div id="pager_tab" class="pager" style='position:absolute;'>
	<img src="<?php echo $_SESSION['baseurl']; ?>crm/jquery-ui/plugin/Table/addons/pager/icons/first.png" class="first">
  	<img src="<?php echo $_SESSION['baseurl']; ?>crm/jquery-ui/plugin/Table/addons/pager/icons/prev.png" class="prev">
    <img src="<?php echo $_SESSION['baseurl']; ?>crm/jquery-ui/plugin/Table/addons/pager/icons/next.png" class="next">
    <img src="<?php echo $_SESSION['baseurl']; ?>crm/jquery-ui/plugin/Table/addons/pager/icons/last.png" class="last">
    <select class="pagesize" id="pagesize">
        <option value="10">10</option>
        <option value="15" selected>15</option>
        <option value="20">20</option>
        <option value="25">25</option>
        <option value="30">30</option>
	</select>
</div>    
