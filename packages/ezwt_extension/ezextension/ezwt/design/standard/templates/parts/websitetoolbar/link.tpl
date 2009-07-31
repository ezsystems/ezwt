<input type="image" src="{'websitetoolbar/ezwt-icon-url.gif'ezimage('no')}" alt="{'Toggle menu link type edit.'|i18n( 'design/standard/parts/website_toolbar' )}" title="{'Toggle menu link type edit.'|i18n( 'design/standard/parts/website_toolbar' )}" id="ezwt-link-switcher" />

<script type="text/javascript">
{literal}
    YUI(YUI3_config).use('node', 'event', function(Y) {
        Y.on('domready', function() {
            Y.get('#ezwt-link-switcher').on('click', function(e) {
                Y.Node.all('.menu-item-link').each(function(n, v) {
                    var rel = n.get('rel');
                    var href = n.get('href');
                    
                    n.set('rel',  href);
                    n.set('href', rel);
                });
                e.preventDefault();
            });
        });
    });
{/literal}
</script>