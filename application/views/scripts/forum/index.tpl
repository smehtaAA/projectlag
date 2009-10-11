<div id="content-total">
	{foreach from=$categories item=cat name=cat}

    <div class="content-princ-total">
        <div class="content-total-top"></div>
        <div class="content-total-middle">
            <div class="content-title-left"></div>
            <div class="content-title-middle content-title-middle-total"><h3>{$cat.titre}</h3></div>
            <div class="content-title-right"></div>
            <div class="content-total-text">
            <table border=1>
            <tr height="35px" bgcolor="#555555">
            	<th width="450px"> Forum </th>
                <th width="50px"> Sujets </th>
                <th width="75px"> R&eacute;ponses </th>
                <th width="240px" > Dernier message </th>
            </tr>
            
            	{foreach from=$sscat[$cat.idCategorie] item=sc name=sc}
            		<tr height="40px">
                    	<td><span class="rouge"><strong>{$sc.titre}</strong></span> <br/> {$sc.description}</td>
                        <td align="center">{$nb[$sc.idSousCategorie].nb_sujets}</td>
                        <td align="center">{$nb[$sc.idSousCategorie].nb_reponses}</td>
                        <td></td>
                    </tr>
            	{/foreach}
            </table>
            </div>
        </div>
        <div class="content-total-bottom"></div>
    </div>
    {/foreach}
</div>