<h2>{$titre}</h2>


{foreach from=$staffs name=staff item=s}

	{if $multistaff[$s.idStaff]==true}
		{foreach from=$staffcomptes[$s.idStaff] name=sc item=sc}
        	{$sc.nom}
        {/foreach}
    {else}
		{$s.nom}
    {/if}    
        <br/>
{/foreach}