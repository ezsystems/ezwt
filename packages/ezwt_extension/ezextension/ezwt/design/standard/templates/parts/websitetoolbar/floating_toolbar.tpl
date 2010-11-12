{* Move toolbar to top of page using classes and css (see websitetoolbar.tpl) *}
{literal}
<script type="text/javascript" async="async">
<!--
(function()
{
    var page = document.getElementById( 'page' );
    if ( !page ) return;

    if ( page.className )
        page.className += ' floting-wt';
    else
        page.className = 'floting-wt';
})();
//-->
</script>
{/literal}