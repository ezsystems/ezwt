<input type="image" disabled="disabled" class="ezwt-input-image disabled" src="{'websitetoolbar/ezwt-icon-url.png'ezimage('no')}" alt="{'Toggle menu link type edit.'|i18n( 'design/standard/parts/website_toolbar' )}" title="{'Toggle menu link type edit.'|i18n( 'design/standard/parts/website_toolbar' )}" id="ezwt-link-switcher" />

<script type="text/javascript">
{literal}
(function( d )
{
    addEvent( window, 'load', function(){
        var link = d.getElementById('ezwt-link-switcher');
        link.disabled = false;
        link.className = 'ezwt-input-image';

        addEvent( link, 'click', function( e ){
            e = e || window.event;
            if( e.preventDefault ) e.preventDefault();
            else e.returnValue = false;
            var links = getByClass( d, 'menu-item-link' );
            for (var i = 0, l = links.length; i < l; i++)
            {
                var rel = links[i].getAttribute('rel'), href = links[i].getAttribute('href'), target = links[i].getAttribute('target'), rev = links[i].getAttribute('rev');
                links[i].setAttribute('rel',  href );
                links[i].setAttribute('href', rel );
                links[i].setAttribute('target', rev ? rev : '' );
                links[i].setAttribute('rev', target ? target : '' );
            }
            return false;
        });
    });

    function getByClass( n, className )
    {
        if (n.getElementsByClassName)
          return n.getElementsByClassName(className);

        var hits = [], els = n.getElementsByTagName("*");
        for (var i = 0, l = els.length; i < l; i++)
        {
            if ( els[i].className && ( ' ' + els[i].className + ' ').indexOf( ' ' + className + ' ' ) !== -1 )
                hits.push( els[i] );
        }
        return hits;
    }

    function addEvent( n, trigger, handler )
    {
        if ( n.addEventListener ) n.addEventListener( trigger, handler, true );
        else if ( n.attachEvent ) n.attachEvent( 'on' + trigger, handler );
    }
})( document );
{/literal}
</script>