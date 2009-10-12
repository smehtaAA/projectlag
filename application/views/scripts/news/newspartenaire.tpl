<h2> News </h2>


 {foreach from=$datas item=news name=news}
	Partenaire {$partenaires[$news.idPartenaire].titre} <br/>
 	{$news.titre|utf8_encode}<br/>
    {$news.date|date_format:"%A %e %B %Y"|capitalize}<br/>
    {$news.type_n|utf8_encode}<br/>
    {$news.description|utf8_encode|nl2br}<br/>

 {/foreach}


{foreach from=$pages item=page name=paget}
	<a href='{$url}{$page}'> Page {$page} </a>
{/foreach}



