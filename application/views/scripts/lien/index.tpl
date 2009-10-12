<h2> Liens </h2>

<ul>
 {foreach from=$datas item=lien name=lien}
 <li><ul>
 	<li>{$lien.titre|utf8_encode}</li>
    <li><a href="http://{$lien.lien}">{$lien.lien}</a></li>
 </ul></li>
 {/foreach}
</ul>

{foreach from=$pages item=page name=paget}
	<a href='{$url}{$page}'> Page {$page} </a>
{/foreach}
