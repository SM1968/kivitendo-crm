<?php

require_once __DIR__.'/../inc/ajax2function.php';


function newContact( $data ){
    $data = ( array ) json_decode( $data );
    //wenn id == 0 neuen Datensatz, sonst Update
    $data['id'] ? $rs = $GLOBALS['dbh']->update( 'contact_events', array( 'cause', 'calldate','caller_id', 'contact_reference', 'employee', 'cause_long', 'type_of_contact', 'inout' ),
            array( $data['cause'], $data['calldate'], $data['caller_id'], 0, $_SESSION['loginCRM'], $data['cause_long'], $data['type_of_contact'], $data['inout'] ), "id =" .$data['id'])
        :   $rs = $GLOBALS['dbh']->insert( 'contact_events', array( 'cause', 'calldate','caller_id', 'contact_reference', 'employee', 'cause_long', 'type_of_contact', 'inout' ),
            array( $data['cause'], $data['calldate'], $data['caller_id'], 0, $_SESSION['loginCRM'], $data['cause_long'], $data['type_of_contact'], $data['inout'] ) );
    echo 1;
}

function getData(){
    //alle Datensätze bereitstellen
    $rs = $GLOBALS[ 'dbh' ]->getAll( 'SELECT * FROM contact_events', true );
    echo $rs;
}

function getSearch($data){
    writeLog($data);
    $sw=$data["sw"];
    $Q=$data["Q"];
    $fid=$data["fid"];
    $sql="select calldate, cause, id, caller_id, contact_reference from contact_events where ( cause ilike '%$sw%' or cause_long ilike '%$sw%') ";
    $sql.="and (caller_id in (select cp_id from contacts where cp_cv_id=$fid) or caller_id=$fid)";
    $rs=$GLOBALS['dbh']->getAll($sql." order by contact_reference,calldate desc");
    writeLog($rs);
    echo json_encode($rs);
}

function openInvoice( $data ){
    $sql = "SELECT * FROM ar WHERE customer_id = " .$data. " AND amount > paid";
    $rs = $GLOBALS['dbh']->getOne( $sql );
    if($rs) {
        echo 1;
    }
    else echo 0;
}

?>