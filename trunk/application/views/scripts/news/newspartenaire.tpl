<h2> News </h2>


 {foreach from=$datas item=news name=news}
	Partenaire {$partenaires[$news.idPartenaire].titre} <br/>
 	{$news.titre}<br/>
    {$news.date|date_format:"%A %e %B %Y"|capitalize}<br/>
    {$news.type_n}<br/>
    {$news.description}<br/>

 {/foreach}


{foreach from=$pages item=page name=paget}
	<a href='{$url}{$page}'> Page {$page} </a>
{/foreach}



