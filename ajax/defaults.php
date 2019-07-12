<?php
require_once __DIR__.'/../inc/ajax2function.php';

function saveDefaults( $data ){
  $GLOBALS['dbh']->query( 'DELETE FROM crmdefaults WHERE employee = -1' );
  echo $GLOBALS['dbh']->insertMultiple( 'crmdefaults', $data );
}

function getDefaults(){
  $sql = "SELECT key, COALESCE( val , '' ) AS val FROM crmdefaults"; //NULL to ''
  echo $GLOBALS['dbh']->getALL( $sql, TRUE ); //as json
}
?>