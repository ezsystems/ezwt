<?php
/**
 * fetch function implementation file for eZ Websitetoolbar
 *
 * @copyright Copyright (C) 1999-2011 eZ Systems AS. All rights reserved.
 * @license http://ez.no/licenses/gnu_gpl GNU GPLv2
 *
 */

class ezwtFunctionCollection
{
    /**
     * Fetch if current user can use website toolbar
     * Used by fetch( 'websitetoolbar', 'can_use', hash( 'class_id', $class_id ) ) template function
     *
     * @param int $classID ID of content class
     * @return bool
     */
    function canUse( $classID )
    {
        $currentUser = eZUser::currentUser();
        $userHasAccess = $currentUser->hasAccessTo( 'websitetoolbar', 'use' );

        if ( $userHasAccess['accessWord'] == 'no' )
            return array( 'result' => false );

        $contentClass = eZContentClass::fetch( (int) $classID );
        if ( !$contentClass instanceof eZContentClass )
            return array( 'result' => false );

        $availableForCurrentClass = false;
        $userFunctions = new eZUserFunctionCollection();
        $policies = $userFunctions->fetchUserRole( $currentUser->attribute( 'contentobject_id' ) );

        foreach ( $policies['result'] as $policy )
        {
            if ( $policy['moduleName'] == 'websitetoolbar' && $policy['functionName'] == 'use' && is_array( $policy['limitation'] ) )
            {
                if ( in_array( (int) $classID, $policy['limitation'][0]->allValues() ) )
                    $availableForCurrentClass = true;
            }
            else if ( ( $policy['moduleName'] == '*' && $policy['functionName'] == '*' && $policy['limitation'] == '*' ) ||
                      ( $policy['moduleName'] == 'websitetoolbar' && $policy['functionName'] == '*' && $policy['limitation'] == '*' ) ||
                      ( $policy['moduleName'] == 'websitetoolbar' && $policy['functionName'] == 'use' && $policy['limitation'] == '*' ) )
            {
                $availableForCurrentClass = true;
            }
        }

        return array( 'result' => $availableForCurrentClass );
    }
}

?>
