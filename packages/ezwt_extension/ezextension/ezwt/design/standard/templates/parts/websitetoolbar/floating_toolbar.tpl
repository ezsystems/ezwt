{* Move toolbar to top of page using classes and css (see websitetoolbar.tpl) *}
{literal}
<script type="text/javascript">
<!--
(function()
{
    var body = document.body, ezwt = document.getElementById( 'ezwt' );
    if ( !ezwt ) return;

    if ( body.className )
        body.className += ' floting-wt';
    else
        body.className = 'floting-wt';

    // Force width for ie6 as it inherits width from contex instead of view
    if ( body.className.indexOf( 'ie6' ) !== -1 )
        ezwt.style.width = body.offsetWidth + 'px';

    // Set padding on header / body based on height of toolbar
    var page = document.getElementById( 'page' )
    if ( page )
        page.getElementsByTagName('div')[0].style.paddingTop = ezwt.offsetHeight + 'px';
    else
        body.style.paddingTop = ezwt.offsetHeight + 'px';
})();
//-->
</script>
{/literal}
