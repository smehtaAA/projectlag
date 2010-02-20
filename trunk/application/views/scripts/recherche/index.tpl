<div id="content-total">
    <div class="content-total-princ">
        <div class="content-total-top"></div>
        <div class="content-total-middle">
            <div class="content-title-left"></div>
            <div class="content-title-middle content-title-middle-total"><h3>Recherche</h3></div>
            <div class="content-title-right"></div>
            <div class="content-total-text">
                <strong> R&eacute;sultats de votre recherche : {$query} </strong>
                <br/> <br/>

                {if $news != -1}
                <strong> News : </strong> <br/> <br/>
                    <table border="0">
                        <tr>
                            <th width="130px"> Titre </th>
                            <th width="130px"> Date </th>
                            <th width="300px"> Description </th>
                        </tr>


                        {foreach from=$news item=n name=news}
                            <tr>
                                <td> <a href="{$baseurl}/news/index?id={$n.idNews}">{$n.titre|utf8_encode}</a> </td>
                                <td> {$n.date|date_format:"%d / %m / %Y"} </td>
                                <td> {$n.description|utf8_encode|truncate:50|nl2br} </td>
                            </tr>

                        {/foreach}

                    </table>

                {else}
                    <strong> News : Aucun Résultat</strong>
                {/if}


            </div>
        </div>
        <div class="content-total-bottom"></div>
    </div>
</div>