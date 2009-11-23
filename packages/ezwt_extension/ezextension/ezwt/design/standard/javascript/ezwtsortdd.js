var eZWTSortDD = function() {
    var ret = {};
    
    ret.enabled = false;
    ret.CONFIG = {};
    
    var setupSortChangeEvent = function( Y )
    {
        Y.get('#ezwt-sort-field').on('change', function( e )
        {
            var select = e.target, selectedIndex = select.get('selectedIndex');

            if( select.get('options').item(selectedIndex).get('value') == 8 )
            {
                Y.get('#ezwt-sort-order').set('disabled', true);

                if ( ret.enabled )
                {
                    Y.get('#ezwt-automatic-update-container').removeClass('hide');
                    if ( !Y.get('#ezwt-automatic-update').get('checked') )
                        Y.get('#ezwt-update-priority').set('disabled', false).replaceClass('button-disabled', 'button');
                }

                if( Y.get('#ezwt-sort-order-asc') === null )
                {
                    select.get('parentNode').appendChild( Y.Node.create('<input id="ezwt-sort-order-asc" type="hidden" name="SortingOrder" value="1" />') );
                }
            }
            else
            {
                Y.get('#ezwt-sort-order').set('disabled', false);

                if ( ret.enabled )
                {
                    Y.get('#ezwt-automatic-update-container').addClass('hide');
                    Y.get('#ezwt-update-priority').set('disabled', true).replaceClass('button', 'button-disabled');
                }

                if(Y.get('#ezwt-sort-order-asc') !== null)
                {
                    select.get('parentNode').removeChild(Y.get('#ezwt-sort-order-asc'));
                }
            }
        });
    };
    
    var yCallback = function(Y)
    {
        setupSortChangeEvent( Y );

        Y.get('#ezwt-automatic-update').on('click', function(e)
        {
            if(e.target.get('checked'))
                Y.get('#ezwt-update-priority').set('disabled', true).replaceClass('button', 'button-disabled');
            else
                Y.get('#ezwt-update-priority').set('disabled', false).replaceClass('button-disabled', 'button');
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
                    drop = drop.get('nextSibling');
                }
                drop.get('parentNode').insertBefore(drag, drop);
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
            var drag = e.target;

            drag.get('node').setStyles({
                visibility: '',
                opacity: '1'
            });
            
            var priority = 0;
            Y.all('#ezwt-sort-list input.ezwt-priority-input').each(function(i, v)
            {
                i.set('value', priority);
                priority += 10;
            });
            
            if( Y.get('#ezwt-automatic-update').get('checked') )
            {
                Y.io.ez('ezwt::updatepriority', {on: {success: ioCallback}, form: { id: 'ezwt-sort-form', upload: false }, method: 'POST'});
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
            ret.enabled = true;
        }
        else
        {
            YUI(YUI3_config).use('node', setupSortChangeEvent );
        }
    }

    return ret;
}();
