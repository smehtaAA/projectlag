<div id="content-total">
    <div class="content-total-princ">
        <div class="content-total-top"></div>
        <div class="content-total-middle">
            <div class="content-title-left"></div>
            <div class="content-title-middle content-title-middle-total"><h3>{$message|utf8_encode}</h3></div>
            <div class="content-title-right"></div>
            <div class="content-total-text">
                <h3>Exception information:</h3> 
                <p> 
                    <b>Message:</b>{$exceptionM|utf8_encode}
                </p> 
            
                <h3>Stack trace:</h3> 
                <pre>{$exceptionT|utf8_encode}</pre> 
            
                <h3>Request Parameters:</h3> 
                <pre>{$request|utf8_encode}</pre> 
            </div>
        </div>
        <div class="content-total-bottom"></div>
    </div>
</div>