<h2> News </h2>

<ul>
 {foreach from=$datas item=news name=news}
 <li><ul>
 	<li>{$news.titre}</li>
    <li>{$news.date|date_format:"%A %e %B %Y"|capitalize}</li>
    <li>{$news.type_n}</li>
    <li>{$news.description}</li>
 </ul></li>
 {/foreach}
</ul>

{foreach from=$pages item=page name=paget}
	<a href='{$url}{$page}'> Page {$page} </a>
{/foreach}



