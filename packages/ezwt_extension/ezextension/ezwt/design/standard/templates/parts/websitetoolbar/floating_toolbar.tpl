{* Move toolbar to top of page using classes and css (see websitetoolbar.tpl) *}
{literal}
<script type="text/javascript">
<!--
(function()
{
    var page = document.getElementById( 'page' );
    if ( !page ) return;

    if ( page.className )
        page.className += ' floting-wt';
    else
        page.className = 'floting-wt';

    // Force width for ie6 as it inherits width from contex instead of view
    if ( document.body.className.indexOf( 'ie6' ) !== -1 )
        document.getElementById( 'ezwt' ).style.width = document.body.offsetWidth + 'px';
})();
//-->
</script>
{/literal}
