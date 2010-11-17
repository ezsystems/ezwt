{def $custom_templates = ezini( 'CustomTemplateSettings', 'CustomTemplateList', 'websitetoolbar.ini' )
     $include_in_view = ezini( 'CustomTemplateSettings', 'IncludeInView', 'websitetoolbar.ini' )}

<!-- eZ website toolbar: START -->

<div id="ezwt">
<div id="ezwt-content" class="float-break">

<!-- eZ website toolbar content: START -->

{include uri='design:parts/websitetoolbar/logo.tpl'}

<div id="ezwt-editaction" class="ezwt-actiongroup">
    <input class="defaultbutton" type="submit" name="PublishButton" value="{'Send for publishing'|i18n( 'design/standard/content/edit' )}" title="{'Publish the contents of the draft that is being edited. The draft will become the published version of the object.'|i18n( 'design/standard/content/edit' )}" />
    <input class="button" type="submit" name="StoreButton" value="{'Store draft'|i18n( 'design/standard/content/edit' )}" title="{'Store the contents of the draft that is being edited and continue editing. Use this button to periodically save your work while editing.'|i18n( 'design/standard/content/edit' )}" />
    <input class="button" type="submit" name="StoreExitButton" value="{'Store draft and exit'|i18n( 'design/standard/content/edit' )}" title="{'Store the draft that is being edited and exit from edit mode. Use when you need to exit your work and return later to continue.'|i18n( 'design/standard/content/edit' )}" />
    <input class="button" type="submit" name="DiscardButton" value="{'Discard draft'|i18n( 'design/standard/content/edit' )}" onclick="return window.confirmDiscard ? confirmDiscard( '{'Are you sure you want to discard the draft?'|i18n( 'design/standard/content/edit' )|wash(javascript)}' ): true;" title="{'Discard the draft that is being edited. This will also remove the translations that belong to the draft (if any).'|i18n( 'design/standard/content/edit' ) }" />
</div>

<div id="ezwt-versionaction" class="ezwt-actiongroup">
    <input class="ezwt-input-image" type="image" src={"websitetoolbar/ezwt-icon-versions.png"|ezimage} name="VersionsButton" title="{'Manage versions'|i18n('design/standard/content/edit')}" />
    <input class="ezwt-input-image" type="image" src={"websitetoolbar/ezwt-icon-preview.png"|ezimage} name="PreviewButton" title="{'Preview'|i18n('design/standard/content/edit')}" />

{if $object.status|eq(0)}
    <select name="FromLanguage" class="disabled" disabled="disabled">
    <option value=""{if $from_language|not} selected="selected"{/if}> {'Translate from'|i18n( 'design/standard/content/edit' )}</option>
    </select>
    <input class="ezwt-input-image disabled" disabled="disabled" type="image" src={"websitetoolbar/ezwt-icon-translation-disabled.png"|ezimage} name="FromLanguageButton" title="{'Translate'|i18n( 'design/standard/content/edit' )}" />
{else}
    <select name="FromLanguage">
    <option value=""{if $from_language|not} selected="selected"{/if}> {'Translate from'|i18n( 'design/standard/content/edit' )}</option>

    {foreach $object.languages as $lang}
    <option value="{$lang.locale}"{if $lang.locale|eq($from_language)} selected="selected"{/if}>
    {$lang.name|wash}
    </option>
    {/foreach}
    </select>
    <input class="ezwt-input-image" type="image" src={"websitetoolbar/ezwt-icon-translation.png"|ezimage} name="FromLanguageButton" title="{'Translate'|i18n( 'design/standard/content/edit' )}" />
{/if}
</div>


{* Custom templates inclusion *}
{def $custom_view_templates = array()}
{foreach $custom_templates as $custom_template}
    {if is_set( $include_in_view[$custom_template] )}
        {def $views = $include_in_view[$custom_template]|explode( ';' )}
        {if $views|contains( 'edit' )}
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

{include uri='design:parts/websitetoolbar/help.tpl'}

<!-- eZ website toolbar content: END -->

</div>
</div>

{include uri='design:parts/websitetoolbar/floating_toolbar.tpl'}

<!-- eZ website toolbar: END -->