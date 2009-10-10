<div id="content-total">
	
    <div class="content-total-princ">
        <div class="content-total-top"></div>
        <div class="content-total-middle">
            <div class="content-title-left"></div>
            <div class="content-title-middle content-title-middle-total"><h3>Local Arena Games</h3></div>
            <div class="content-title-right"></div>
            <div class="content-total-text">
     			
				<p style="font-size:14px"><span class="rouge">Local Arena Games</span> est une association loi 1901 &agrave; but non lucratif cr&eacute;&eacute;e en 2009. Son si&egrave;ge social est bas&eacute; &agrave; Mont Notre Dame dans l'Aisne (02220).</p> <br/> 
                <p style="font-size:14px">Cette assocation a pour but :
                	<ul style="font-size:14px">
                    	<li> d'offrir la possibilit&eacute; &agrave; des joueurs ou passion&eacute;s de se r&eacute;unir autour d'un r&eacute;seau local en les faisant b&eacute;n&eacute;ficier de conditions optimales. </li>
                        <li> de promouvoir l'informatique et les jeux vid&eacute;os par le biais d'&eacute;v&eacute;nements et de publications. </li>
                        
                    </ul>
                </p> <br/>
                <p style="font-size:14px"> L'association agit notamment dans l'Aisne en r&eacute;alisant des &eacute;v&eacute;nements dans le salle Poniatowsky de Mont Notre Dame. Il s'agit d'un village situ&eacute; entre Soissons et Reims. Ce gymnase nous permet d'accueillir jusqu'&agrave; un maximum de 100 personnes. Nous avons &eacute;galement la possibilit&eacute; de r&eacute;aliser diff&eacute;rentes activit&eacute;s tel qu'un coin restauration ou encore des session de jeux sur console (DDR, Bowling, ..) </p> <br/>
                <p style="font-size:14px"> La LAG est &agrave; votre disposition pour toutes questions ou demande sur la r&eacute;alisation d'&eacute;v&eacute;venements. </p>

             
            </div>
        </div>
        <div class="content-total-bottom"></div>
    </div>


    <div class="content-total-princ">
        <div class="content-total-top"></div>
        <div class="content-total-middle">
            <div class="content-title-left"></div>
            <div class="content-title-middle content-title-middle-total"><h3>{$titre}</h3></div>
            <div class="content-title-right"></div>
            <div class="content-total-text">
     			{foreach from=$staffs name=staff item=s}
                <div class="staff-personne">
                    <h4><span class="rouge">{$s.nom}</span></h4>
                    <br />
                    {foreach from=$comptes[$s.idStaff] name=compte item=c}
                        <img src="{$base_url}/images/staff/{$c.prenom|lower}.jpg" align="right" alt="{$c.nom|capitalize} {$c.prenom}" title="{$c.nom} {$c.prenom}" />
                        &nbsp;&nbsp;<strong>Nom :</strong> {$c.nom|upper} {$c.prenom} <br/>
                        &nbsp;&nbsp<strong>Pseudo :</strong> {$c.login|capitalize} <br/>
                        &nbsp;&nbsp<strong>Age : </strong> {$datedujour-$c.datenaissance}<br/>
                        &nbsp;&nbsp<strong>Mail : </strong> {$c.email} <br/>
                        &nbsp;&nbsp<strong>Msn : </strong> {$c.msn} <br/>
                        &nbsp;&nbsp<strong>Site : </strong> {$c.site} <br/>
                        &nbsp;&nbsp<strong>Description : </strong> {$c.description} <br/>
                    {/foreach}
                </div>
                {/foreach}
             
            </div>
        </div>
        <div class="content-total-bottom"></div>
    </div>
</div>