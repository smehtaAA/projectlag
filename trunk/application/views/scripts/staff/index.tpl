<div id="content-total">
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