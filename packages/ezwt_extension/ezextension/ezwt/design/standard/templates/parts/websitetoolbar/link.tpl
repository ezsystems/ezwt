<input type="image" class="ezwt-input-image hide" src="{'websitetoolbar/ezwt-icon-url.png'ezimage('no')}" alt="{'Toggle menu link type edit.'|i18n( 'design/standard/parts/website_toolbar' )}" title="{'Toggle menu link type edit.'|i18n( 'design/standard/parts/website_toolbar' )}" id="ezwt-link-switcher" />

{ezscript_require( 'ezjsc::yui3' )}
<script type="text/javascript">
{literal}
    if ( window.YUI !== undefined ) YUI( YUI3_config ).use('node', function(Y) {
        Y.on('contentready', function() {
            Y.get('#ezwt-link-switcher').removeClass('hide').on('click', function(e) {
                Y.Node.all('.menu-item-link').each(function(n, v) {
                    var rel = n.get('rel'), href = n.get('href');
                    n.set('rel',  href);
                    n.set('href', rel);
                });
                e.preventDefault();
            });
        }, '#ezwt-link-switcher' );
    });
{/literal}
</script>