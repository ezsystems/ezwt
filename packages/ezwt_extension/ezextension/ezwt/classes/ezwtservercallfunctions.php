<?php

/**
 * Implements methods called remotely by sending XHR calls
 * 
 */
class ezwtServerCallFunctions
{
    /**
     * Updating priority sorting for given node
     * 
     * @param mixed $args
     * @return array
     */
    public static function updatePriority( $args )
    {
        $http = eZHTTPTool::instance();

        if ( !$http->hasPostVariable('ContentNodeID') 
                || !$http->hasPostVariable('PriorityID')
                    || !$http->hasPostVariable('Priority') )
        {
            return array();
        }

        $contentNodeID = $http->postVariable('ContentNodeID');
        $priorityArray = $http->postVariable('Priority');
        $priorityIDArray = $http->postVariable('PriorityID');
        
        if ( eZOperationHandler::operationIsAvailable( 'content_updatepriority' ) )
        {
            $operationResult = eZOperationHandler::execute( 'content', 'updatepriority',
                                                             array( 'node_id' => $contentNodeID,
                                                                    'priority' => $priorityArray,
                                                                    'priority_id' => $priorityIDArray ), null, true );
        }
        else
        {
            eZContentOperationCollection::updatePriority( $contentNodeID, $priorityArray, $priorityIDArray );
        }

        if ( $http->hasPostVariable( 'ContentObjectID' ) )
        {
            $objectID = $http->postVariable( 'ContentObjectID' );
            eZContentCacheManager::clearContentCache( $objectID );
        }
    }
}

?>