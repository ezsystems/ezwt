{def $custom_templates = ezini( 'CustomTemplateSettings', 'CustomTemplateList', 'websitetoolbar.ini' )
     $include_in_view = ezini( 'CustomTemplateSettings', 'IncludeInView', 'websitetoolbar.ini' )}

<!-- eZ website toolbar: START -->

<div id="ezwt">
<div id="ezwt-content" class="float-break">

<!-- eZ website toolbar content: START -->

{include uri='design:parts/websitetoolbar/logo.tpl'}

<form method="post" action={concat( 'content/versionview/', $object.id, '/', $version.version, '/', $language, '/', $from_language )|ezurl}>

<div id="ezwt-editaction" class="ezwt-actiongroup">
{if or( and( eq( $version.status, 0 ), $is_creator, $object.can_edit ),
                  and( eq( $object.status, 2 ), $object.can_edit ) )}
    <input type="submit" class="defaultbutton" name="EditButton" value="{'Edit'|i18n( 'design/standard/content/view/versionview' )}" />
    <input type="submit" class="button" name="PreviewPublishButton" value="{'Publish'|i18n( 'design/standard/content/view/versionview' )}" />
{else}
    <input type="submit" disabled="disabled" class="button-disabled" name="EditButton" value="{'Edit'|i18n( 'design/standard/content/view/versionview' )}" />
    <input type="submit" disabled="disabled" class="button-disabled" name="PreviewPublishButton" value="{'Publish'|i18n( 'design/standard/content/view/versionview' )}" />
{/if}
</div>

<div id="ezwt-versionaction" class="ezwt-actiongroup">
{if $object.versions|count|gt( 1 )}
    <input class="ezwt-input-image" type="image" src={"websitetoolbar/ezwt-icon-versions.png"|ezimage} name="VersionsButton" title="{'Manage versions'|i18n('design/standard/content/edit')}" />
{else}
    <input class="ezwt-input-image disabled" disabled="disabled" type="image" src={"websitetoolbar/ezwt-icon-versions.png"|ezimage} name="VersionsButton" title="{'Manage versions'|i18n('design/standard/content/edit')}" />
{/if}
</div>



{* Custom templates inclusion *}
{def $custom_view_templates = array()}
{foreach $custom_templates as $custom_template}
    {if is_set( $include_in_view[$custom_template] )}
        {def $views = $include_in_view[$custom_template]|explode( ';' )}
        {if $views|contains( 'versionview' )}
            {set $custom_view_templates = $custom_view_templates|append( $custom_template )}
        {/if}
        {undef $views}
    {/if}
{/foreach}

{if $custom_view_templates}
<div id="ezwt-miscaction" class="ezwt-actiongroup">
{foreach $custom_view_templates as $custom_template}
    {include uri=concat( 'design:parts/websitetoolbar/', $custom_template, '.tpl' )}
{/foreach}
</div>
{/if}


</form>

{include uri='design:parts/websitetoolbar/help.tpl'}

<!-- eZ website toolbar content: END -->

</div>
</div>

{include uri='design:parts/websitetoolbar/floating_toolbar.tpl'}

<!-- eZ website toolbar: END -->