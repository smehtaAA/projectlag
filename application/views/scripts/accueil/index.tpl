<h2> Accueil </h2>


{if $lan != -1}
<div>
Info Lan <br/>
{$lan.nom}<br/>
{$lan.datedeb|date_format:"%d/%m/%Y a %H:%M"}<br/>
{$lan.adresse}<br/>
{$nb_inscrits} inscrits
</div>
{/if}

<br/>

<div>
News <br/>
{foreach from=$news item=new name=new}
	<img src="{$base_url}/images/news/{$new.img}" /> <br />
    {$new.titre}<br />
    {$new.date|date_format:"%A %e %B %Y"|capitalize}<br />
    {$new.type_n}<br />
    {$new.description}<br /><br />
{/foreach}

Pages - 
{foreach from=$pages item=page name=paget}
   [<a href='{$url}{$page}'>{$page}</a>] 
{/foreach}
</div>

<br/>
<br/>

<div>
News PArtenaire <br/>
{foreach from=$newsp item=newp name=newp}
    {$newp.titre}<br />
    {$newp.date|date_format:"%A %e %B %Y"|capitalize}<br />
    {$newp.type_n}<br />
    {$newp.description}<br /><br />
{/foreach}
</div>