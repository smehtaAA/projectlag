<h2>{$title}</h2>

<br />

<strong> Nom : </strong> {$compte.nom|capitalize|utf8_encode} <br/>
<strong> Pr&eacute;nom : </strong> {$compte.prenom|capitalize|utf8_encode} <br/>
<strong> Ville : </strong> {$compte.ville|capitalize|utf8_encode} <br/>
<strong> Mail : </strong> {$compte.email} <br/>
<strong> T&eacute;l&eacute;phone : </strong> {$compte.phone} <br/>
<strong> Date d'inscription : </strong> {$compte.dateins|date_format:"%d / %m / %Y"}
<br/><br/>
<strong> Participations </strong>
<br/> <br/>
<table>
    <tr>
        <th align="left" width="150"> Ev&egrave;nement </th>
        <th align="center" width="130"> Date Ev&egrave;nement </th>
        <th align="center" width="130"> Date Inscription </th>
        <th align="center" width="100"> Valid&eacute; </th>
        <th align="center" width="100"> Pr&eacute;sent </th>
        <th align="center" width="150"> Mode Paiement </th>

        <th align="center" width="100"> Cotisation </th>
    </tr>

    {foreach item=l from=$lans name=l}

    <tr>
        <td align="left">{$l.nom|utf8_encode}</td>
        <td align="center">{$l.datedeb|date_format:"%d / %m / %Y"}</td>
        <td align="center">{$l.dateins|date_format:"%d / %m / %Y"}</td>
        <td align="center">{if $l.validation==0} Non {else} Oui {/if}</td>
        <td align="center">{if $l.present==0} Non {else} Oui {/if}</td>
        <td align="center">{if $l.modepaiement==1}Ch&egrave;que {elseif $l.modepaiement==2} PayPal {else} Sur place {/if}</td>
        <td align="right"> {$l.paiement} &euro;</td>

    </tr>


    {/foreach}

    <tr ><td height="20px" colspan="7"></td></tr>

    <tr>
        <td colspan="5"></td>
        <td align="right"> <strong> Total </strong> </td>
        <td align="right"> <strong> {$total} </strong> &euro; </td>
    </tr>
    


</table>

<br/><br/>
<strong> Jeux </strong>
<br/> <br/>
<table>

    <tr>
        <th width="150px">Nom</th>
        <th width="150px">Nombre d'inscriptions </th>
    </tr>

    {foreach from=$jeux item=j name=j}
    <tr>
        <td>{$j.nom}</td>
        <td align="right">{$j.num}</td>
    </tr>
    {/foreach}


</table>