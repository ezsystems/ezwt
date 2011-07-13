var eZWTSortDD = function() {
    var ret = {};

    ret.sort_order = 1;
    ret.enabled = false;
    ret.CONFIG = {};
    
    var setupSortChangeEvent = function( Y )
    {
        Y.one('#ezwt-sort-field').on('change', function( e )
        {
            var select = e.target, selectedIndex = select.get('selectedIndex');

            if( select.get('options').item(selectedIndex).get('value') == 8 )
            {
                if ( ret.enabled )
                {
                    Y.one('#ezwt-automatic-update-container').removeClass('hide');
                    if ( !Y.one('#ezwt-automatic-update').get('checked') )
                        Y.one('#ezwt-update-priority').set('disabled', false).replaceClass('button-disabled', 'button');
                }
            }
            else
            {
                if ( ret.enabled )
                {
                    Y.one('#ezwt-automatic-update-container').addClass('hide');
                    Y.one('#ezwt-update-priority').set('disabled', true).replaceClass('button', 'button-disabled');
                }
            }
        });
        Y.all('#ezwt-sort-list input.ezwt-priority-input').on('change', function( e )
        {
            // signal in gui that user needs to save this
            Y.one('#ezwt-update-priority').replaceClass('button', 'defaultbutton');
        });
    };
    
    var yCallback = function(Y)
    {
        setupSortChangeEvent( Y );

        Y.one('#ezwt-automatic-update').on('click', function(e)
        {
            if(e.target.get('checked'))
                Y.one('#ezwt-update-priority').set('disabled', true).replaceClass('button', 'button-disabled');
            else
                Y.one('#ezwt-update-priority').set('disabled', false).replaceClass('button-disabled', 'button');
        });
        
        var ioCallback = function(id, o)
        {
            if (o.responseText !== undefined)
            {
            }
        }
        
        Y.DD.DDM.on('drop:over', function(e)
        {
            var drag = e.drag.get('node'),
                drop = e.drop.get('node');

            if (drop.get('tagName').toLowerCase() === 'tr') {

                if (!goingUp) {
                    var dropSibling = drop.get('nextSibling');
                    if (!dropSibling) {
                        drop.get('parentNode').append(drag);
                    } else {
                        drop.get('parentNode').insertBefore(drag, dropSibling);
                    }
                } else {
                    drop.get('parentNode').insertBefore(drag, drop);
                }
                e.drop.sizeShim();
            }
        });

        Y.DD.DDM.on('drag:drag', function(e)
        {
            var y = e.target.lastXY[1];

            if (y < lastY)
            {
                goingUp = true;
            }
            else
            {
                goingUp = false;
            }
            lastY = y;
        });

        Y.DD.DDM.on('drag:start', function(e)
        {
            var drag = e.target;

            drag.get('node').setStyle('opacity', '.25');
            drag.get('dragNode').set('innerHTML', drag.get('node').get('innerHTML'));
            drag.get('dragNode').setStyles({
                opacity: '.5',
                borderColor: drag.get('node').getStyle('borderColor'),
                backgroundColor: drag.get('node').getStyle('backgroundColor')
            });
        });

        Y.DD.DDM.on('drag:end', function(e)
        {
            var drag = e.target, dragPriority = drag.get('node').one('input.ezwt-priority-input');

            drag.get('node').setStyles({
                visibility: '',
                opacity: '1'
            });

            // TODO: Exit if order has not changed (draged by mistake for instance) to not set priority when not needed

            var autoUpdate = Y.one('#ezwt-automatic-update').get('checked');

            if ( autoUpdate )
                var sortOrder = Y.one('#ezwt-sort-order').get('value') === '1';
            else
                var sortOrder = ret.sort_order;

            // sortOrder: desc: 0, asc: 1
            // updateToIndex: set priority on all nodes up until this index
            var priority = sortOrder ? -2 : 2, updateToIndex = 0, inputs = Y.all('#ezwt-sort-list input.ezwt-priority-input');
            inputs.each(function(node, i)
            {
                // Only set priority on nodes up until last node with priority
                if ( node.get('value') !== '0' )
                    updateToIndex = i;
                // Or up until dragged node
                else if ( node.compareTo( dragPriority ) )
                    updateToIndex = i;
            });
            priority = priority * ( updateToIndex + 1 );
            inputs.each(function(node, i)
            {
                if ( i > updateToIndex )
                    return;

                node.set('value', priority);
                if ( sortOrder )
                    priority += 2;
                else
                    priority -= 2;
            });
            
            if( autoUpdate )
            {
                Y.io.ez('ezwt::updatepriority', {on: {success: ioCallback}, form: { id: 'ezwt-sort-form', upload: false }, method: 'POST'});
            }
            else
            {
                // signal in gui that user needs to save this
                Y.one('#ezwt-update-priority').replaceClass('button', 'defaultbutton');
            }
        });

        Y.DD.DDM.on('drag:drophit', function(e)
        {
            var drop = e.drop.get('node'), drag = e.drag.get('node');

            if ( drop.get('tagName').toLowerCase() !== 'tr' )
            {
                if ( !drop.contains(drag) )
                {
                    drop.appendChild( drag );
                }
            }
        });

        var goingUp = false, lastY = 0;
        var dragdropList = Y.Node.all('tr.ezwt-sort-dragable').addClass('ezwt-sort-drag-handler');
        dragdropList.each(function(v, k)
        {
            var dd = new Y.DD.Drag({
                node: v
            }).plug( Y.Plugin.DDProxy, {
                moveOnEnd: false
            }).plug( Y.Plugin.DDConstrained, {
                constrain2node: '#ezwt-sort-list'
            });
        });

        dragdropList.each(function(v, k)
        {
            var tar = new Y.DD.Drop({
                node: v
            });
        });
    }
    
    ret.init = function()
    {
        if ( document.getElementById('ezwt-sort-field').value == 8 )
        {
            YUI(YUI3_config).use('node', 'io-ez', 'io-form', 'dd-constrain', 'dd-proxy', 'dd-drop', yCallback );
            ret.sort_order = document.getElementById('ezwt-sort-order').value === '1';
            ret.enabled = true;
        }
        else
        {
            YUI(YUI3_config).use('node', setupSortChangeEvent );
        }
    }

    return ret;
}();
