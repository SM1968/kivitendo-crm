<?php
require_once __DIR__.'/../inc/ajax2function.php';
require_once __DIR__.'/../inc/stdLib.php';

function getTerminalCustomerData( $customer_id = 0 ){
  $result = getDefaults( array( 'ec_terminal_ip-adress', 'ec_terminal_port','ec_terminal_passwd'), FALSE );
  if( $customer_id ){
    $sql = "SELECT greeting || ' ' || name AS name FROM customer WHERE id = $customer_id";
    $customer = $GLOBALS['dbh']->getOne( $sql );
    $result = array_merge( $result, $customer );
  }
  echo ( json_encode( $result ) );
}
?>