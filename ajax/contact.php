<?php

require_once __DIR__.'/../inc/ajax2function.php';

function newContact( $data ){
//    writeLog($data);
    $data = ( array ) json_decode( $data );
    writeLog($data);
    $rs = $GLOBALS['dbh']->insert( 'contact_events', array( 'calldate','caller_id', 'cause', 'contact_reference', 'employee', 'cause_long', 'type_of_contact', 'inout' ), array( $data['calldate'], $data['caller_id'], $data['cause'], 0, $data['employee'], $data['cause_long'], $data['type_of_contact'], $data['inout'] ) );
    writeLog( $rs );
    echo 1;
}

/*function getRow($data){
    //Datensatz mit bestimmter id bereitstellen
    writeLog($data);
    $data = (array) json_decode($data);
    $id = $data["id"];
    writeLog($id);
    $rs = $GLOBALS[ 'dbh' ]->getAll( 'SELECT * contact_events where (id ='.$id.')', true );
    writeLog( $rs );
    echo $rs;

}
*/
function getData(){
    //alle Datensätze bereitstellen
    $rs = $GLOBALS[ 'dbh' ]->getAll( 'SELECT * FROM contact_events', true );
//    $rs = $GLOBALS[ 'dbh' ]->getAll( 'SELECT * contact_events', true );
    writeLog( $rs );
    echo $rs;

}


?>