<?php
/**
 * fetch function definition file for eZ Websitetoolbar
 *
 * @copyright Copyright (C) 1999-2011 eZ Systems AS. All rights reserved.
 * @license http://ez.no/licenses/gnu_gpl GNU GPLv2
 *
 */

$FunctionList = array();

$FunctionList['can_use'] = array( 'name'            => 'can_use',
                                  'call_method'     => array( 'class' => 'ezwtFunctionCollection', 'method' => 'canUse' ),
                                  'parameter_type'  => 'standard',
                                  'parameters'      => array( array( 'name'     => 'class_id',
                                                                     'type'     => 'integer',
                                                                     'required' => true ) ) );

?>
