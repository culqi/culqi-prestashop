<script type="text/javascript" defer src="{$this_path|escape:'htmlall':'UTF-8'}views/js/waitMe.min.js"></script>
<h2>{l s='Resumen del pedido' mod='culqi'}</h2> {assign var='current_step' value='payment'} {include file="$tpl_dir./order-steps.tpl"} {if isset($nbProducts) && $nbProducts
<=0 } <p class="warning">{l s='Tu carrito de compras está vacío.' mod='culqi'}</p>
    {else} {if isset($payment_error)}
    <p class="warning culqi_error">{$payment_error|escape:'htmlall':'UTF-8'}</p>
    {/if}
    <h3>{l s='Pago con tarjeta de crédito o débito' mod='culqi'}</h3> {*
    <form id="pay" action="{$link->getModuleLink('culqi', 'validation', [], true)|escape:'htmlall':'UTF-8'}" method="post">*}
        <p style="margin-top:20px;">
            Usted ha elegido pagar con tarjeta de crédito o débito. Solo cuenta con 10 minutos para realizar el pago, de lo contrario este expirará.
        </p>
        <p style="margin-top:20px;">
            - {l s='El monto total a cancelar es de:' mod='culqi'}
            <span id="amount" class="price"><b>{displayPrice price=$total}</b></span>
        </p>
        <p style="margin-top:20px;">
            <b>{l s='Por favor confirme su pedido haciendo clic en el botón.' mod='culqi'}</b>
        </p>
        <p style="margin-top:20px; display:block; margin: 0 auto; text-align: center;" class="cart_navigation" id="cart_navigation">
            <button id="btn_pago" class="culqi_btn_ok">Realizar Pago</button>
            <a style="line-height: 30px;" href="{$link->getPageLink('order', true, NULL, " step=3 ")|escape:'htmlall':'UTF-8'}" class="culqi_btn_cancel button_large">{l s='Cancelar' mod='culqi'}</a>
        </p>

        <p class="hide" id="showresult" style="margin-top:20px;">
            <b id="showresultcontent"></b>
        </p>

    {/if}
         
        {if $multipayment_enable}
            {literal}
            <script>  

                console.log('Multipagos habilitados');

                Culqi.publicKey = '{/literal}{$codigo_comercio|escape:'htmlall':'UTF-8'}{literal}';

                Culqi.settings({
                    title: '{/literal}{$shop_name|escape:'htmlall':'UTF-8'}{literal}',  
                    currency: '{/literal}{$currency|escape:'htmlall':'UTF-8'}{literal}',
                    description: '{/literal}{$descripcion|escape:'htmlall':'UTF-8'}{literal}',
                    amount: ({/literal}{$total|escape:'htmlall':'UTF-8'}{literal})*100,            
                    order: '{/literal}{$order_id|escape:'htmlall':'UTF-8'}{literal}'   
                });

                $('#btn_pago').on('click', function(e) {
                    $('#showresult').addClass('hide');
                    Culqi.open();
                    e.preventDefault();
                });

                // Recibimos Token del Culqi.js
                function culqi() {
                    if(Culqi.token) {
                        $(document).ajaxStart(function(){
                            run_waitMe();
                        });
                        $(document).ajaxComplete(function(){
                            $('body').waitMe('hide');
                        });
                        var installments = (Culqi.token.metadata.installments == undefined) ? 1 : Culqi.token.metadata.installments;
                        $.ajax({
                            url: fnReplace("{/literal}{$link->getModuleLink('culqi', 'chargeajax', [], true)|escape:'htmlall':'UTF-8'}{literal}"),
                            data: {
                            ajax: true,
                            action: 'displayAjax',
                            token_id: Culqi.token.id,
                            installments: installments
                            },
                            type: "POST",
                            dataType: 'json',
                            success: function(data) {
                            if(data === "Error de autenticación") {
                                $('body').waitMe('hide');
                                showResult('red',data + ": verificar si su Llave Secreta es la correcta");
                            } else {
                                var result = "";
                                if(data.constructor == String){
                                    result = JSON.parse(data);
                                }
                                if(data.constructor == Object){
                                    result = JSON.parse(JSON.stringify(data));
                                }
                                if(result.object === 'charge'){
                                $('body').waitMe('hide');
                                showResult('green',result.outcome.user_message); 
                                Culqi.close();
                                redirect();
                                }
                                if(result.object === 'error'){
                                $('body').waitMe('hide');
                                showResult('red',result.user_message);

                                }
                            }
                            }
                        });
                    }  else if (Culqi.order) {  

                        $(document).ajaxStart(function(){
                            run_waitMe();
                        });
                        $(document).ajaxComplete(function(){
                            $('body').waitMe('hide');
                        });

                        console.log("Order confirmada"); 
                        
                        $.ajax({
                            url: fnReplace("{/literal}{$link->getModuleLink('culqi', 'orderajax', [], true)|escape:'htmlall':'UTF-8'}{literal}"),
                            cache : false,
                            data: {
                                ajax: true,
                                action: 'displayAjax',
                                order_id: Culqi.order.id
                            },
                            type: "POST",
                            dataType: 'json',
                            success: function(data) {  

                                if(data === "Error") {
                                    $('body').waitMe('hide');
                                    showResult('red',data + ", intente nuevamente o más tarde.");
                                } else {
                                    var result = "";
                                    if(data.constructor == String){
                                        result = JSON.parse(data);
                                    }
                                    if(data.constructor == Object){
                                        result = JSON.parse(JSON.stringify(data));
                                    }
                                    if(result.object === 'order'){
                                        $('body').waitMe('hide'); 
                                        console.log('Redirigiendo....');
                                        redirectPending();
                                    }
                                    if(result.object === 'error'){
                                    $('body').waitMe('hide');
                                    }
                                } 
                                
                            }, 
                            
                            error: function(error){

                                $('body').waitMe('hide');
                                showResult('red',"Ocurrió un problema al procesar la orden, intente nuevamente o más tarde.");
                            }
                        });

                    } 
                    else if (Culqi.closeEvent){
                        console.log(Culqi.closeEvent);               
                    }
                    else {
                        $('body').waitMe('hide');
                        showResult('red',Culqi.error.user_message);
                    }
                }

                function run_waitMe() {
                $('body').waitMe({
                    effect: 'orbit',
                    text: 'Procesando pago...',
                    bg: 'rgba(255,255,255,0.7)',
                    color:'#28d2c8'
                });
                }

                function showResult(style,message){
                $('#showresult').removeClass('hide');
                $('#showresultcontent').attr('class', '');
                $('#showresultcontent').addClass(style);
                $('#showresultcontent').html(message);
                }

                function redirect() {
                    var url = fnReplace("{/literal}{$link->getModuleLink('culqi', 'postpayment', [], true)|escape:'htmlall':'UTF-8'}{literal}");
                    location.href = url;
                }; 

                function redirectPending() {
                    var url = fnReplace("{/literal}{$link->getModuleLink('culqi', 'postpendingpayment', [], true)|escape:'htmlall':'UTF-8'}{literal}");
                    location.href = url;
                };

                function fnReplace(url) {
                    return url.replace(/&amp;/g, '&');
                }

            </script>
            {/literal} 
        {else}
             {literal}
                <script>

                    Culqi.publicKey = '{/literal}{$codigo_comercio|escape:'htmlall':'UTF-8'}{literal}';

                    Culqi.settings({
                        title: '{/literal}{$shop_name|escape:'htmlall':'UTF-8'}{literal}',  
                        currency: '{/literal}{$currency|escape:'htmlall':'UTF-8'}{literal}',
                        description: '{/literal}{$descripcion|escape:'htmlall':'UTF-8'}{literal}',
                        amount: ({/literal}{$total|escape:'htmlall':'UTF-8'}{literal})*100          
                    });

                    $('#btn_pago').on('click', function(e) {
                        $('#showresult').addClass('hide');
                        Culqi.open();
                        e.preventDefault();
                    });

                    // Recibimos Token del Culqi.js
                    function culqi() {
                    if(Culqi.token) {
                        $(document).ajaxStart(function(){
                            run_waitMe();
                        });
                        $(document).ajaxComplete(function(){
                            $('body').waitMe('hide');
                        });
                        var installments = (Culqi.token.metadata.installments == undefined) ? 1 : Culqi.token.metadata.installments;
                        $.ajax({
                            url: fnReplace("{/literal}{$link->getModuleLink('culqi', 'chargeajax', [], true)|escape:'htmlall':'UTF-8'}{literal}"),
                            data: {
                            ajax: true,
                            action: 'displayAjax',
                            token_id: Culqi.token.id,
                            installments: installments
                            },
                            type: "POST",
                            dataType: 'json',
                            success: function(data) {
                            if(data === "Error de autenticación") {
                                $('body').waitMe('hide');
                                showResult('red',data + ": verificar si su Llave Secreta es la correcta");
                            } else {
                                var result = "";
                                if(data.constructor == String){
                                    result = JSON.parse(data);
                                }
                                if(data.constructor == Object){
                                    result = JSON.parse(JSON.stringify(data));
                                }
                                if(result.object === 'charge'){
                                $('body').waitMe('hide');
                                showResult('green',result.outcome.user_message);
                                redirect();
                                }
                                if(result.object === 'error'){
                                $('body').waitMe('hide');
                                showResult('red',result.user_message);

                                }
                            }
                            }
                        });
                    } else {
                        $('body').waitMe('hide');
                        showResult('red',Culqi.error.user_message);
                    }
                    }

                    function run_waitMe() {
                    $('body').waitMe({
                        effect: 'orbit',
                        text: 'Procesando pago...',
                        bg: 'rgba(255,255,255,0.7)',
                        color:'#28d2c8'
                    });
                    }

                    function showResult(style,message){
                    $('#showresult').removeClass('hide');
                    $('#showresultcontent').attr('class', '');
                    $('#showresultcontent').addClass(style);
                    $('#showresultcontent').html(message);
                    }

                    function redirect() {
                        var url = fnReplace("{/literal}{$link->getModuleLink('culqi', 'postpayment', [], true)|escape:'htmlall':'UTF-8'}{literal}");
                        location.href = url;
                    };

                    function fnReplace(url) {
                        return url.replace(/&amp;/g, '&');
                    }

                </script>
             {/literal}  

        {/if}
        
        




        
