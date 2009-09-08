<h2>{$titre}</h2>

<br /><br />
<ul>
{foreach from=$datas key=myId item=i name=foo}
	<li> 
    	<h4>{$smarty.foreach.foo.index+1} - {$i.titre}</h4>
    	{$i.description}
    </li>
{/foreach}
</ul>