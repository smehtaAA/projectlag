<div id="content-total">
    <div class="content-total-princ">
        <div class="content-total-top"></div>
        <div class="content-total-middle">
            <div class="content-title-left"></div>
            <div class="content-title-middle content-title-middle-total"><h3>Recherche</h3></div>
            <div class="content-title-right"></div>
            <div class="content-total-text">
                {$form}

<br/><br/>
{if $recherche==1}

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
                                <td> <a href="{$baseurl}/news/index?id={$n.idNews}">{$n.titre}</a> </td>
                                <td> {$n.date|date_format:"%d / %m / %Y"} </td>
                                <td> {$n.description|truncate:50|nl2br} </td>
                            </tr>

                        {/foreach}

                    </table>

                {else}
                    <strong> News : Aucun Résultat</strong>
                {/if}

                <br/><br/>

                {if $lan != -1}
                <strong> Lans : </strong> <br/> <br/>
                    <table border="0">
                        <tr>
                            <th width="130px"> Titre </th>
                            <th width="130px"> Date </th>
                            <th width="300px"> Description </th>
                        </tr>


                        {foreach from=$lan item=l name=lan}
                            <tr>
                                <td> <a href="{$baseurl}/news/index?id={$l.idLan}">{$l.nom}</a> </td>
                                <td> {$l.datedeb|date_format:"%d / %m / %Y"} </td>
                                <td> {$l.description|truncate:50|nl2br} </td>
                            </tr>

                        {/foreach}

                    </table>

                {else}
                    <strong> Lans : Aucun Résultat</strong>
                {/if}

                <br/><br/>

                {if $forum != -1}
                <strong> Forum : </strong> <br/> <br/>
                    <table border="0">
                        <tr>
                            <th width="130px"> Titre </th>
                            <th width="130px"> Date </th>
                            <th width="300px"> Description </th>
                        </tr>


                        {foreach from=$forum item=f name=forum}
                            <tr>
                                <td> <a href="{$baseurl}/sujet/index?id={$f.idSujet}">{$f.titre}</a> </td>
                                <td> {$f.date_m|date_format:"%d / %m / %Y"} </td>
                                <td> {$f.description|truncate:50|nl2br} </td>
                            </tr>

                        {/foreach}

                    </table>

                {else}
                    <strong> Forum : Aucun Résultat</strong>
                {/if}

                <br/><br/>

                {if $newsp != -1}
                <strong> News Partenaires: </strong> <br/> <br/>
                    <table border="0">
                        <tr>
                            <th width="130px"> Titre </th>
                            <th width="130px"> Date </th>
                            <th width="300px"> Description </th>
                        </tr>


                        {foreach from=$newsp item=np name=newsp}
                            <tr>
                                <td> <a href="{$baseurl}/news/index?id={$np.idNews}">{$np.titre}</a> </td>
                                <td> {$np.date|date_format:"%d / %m / %Y"} </td>
                                <td> {$np.description|truncate:50|nl2br} </td>
                            </tr>

                        {/foreach}

                    </table>

                {else}
                    <strong> News Partenaires : Aucun Résultat</strong>
                {/if}

{/if}


            </div>
        </div>
        <div class="content-total-bottom"></div>
    </div>
</div>