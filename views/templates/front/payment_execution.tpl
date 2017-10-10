<script type="text/javascript" defer src="{$this_path|escape:'htmlall':'UTF-8'}views/js/waitMe.min.js"></script>

{capture name=path}
    <a href="{$link->getPageLink('order', true, NULL, "step=3")|escape:'html':'UTF-8'}" title="{l s='Volver al resumen del pedido' mod='culqi'}">{l s='Go back to the Checkout' mod='culqi'}</a><span class="navigation-pipe">{$navigationPipe}</span>{l s='Culqi' mod='culqi'}
{/capture}

{assign var='current_step' value='payment'}
{include file="$tpl_dir./order-steps.tpl"}


<h2>{l s='Resumen del pedido' mod='culqi'}</h2>

{if isset($nbProducts) && $nbProducts<=0 }
    <p class="warning">{l s='Tu carrito de compras está vacío.' mod='culqi'}</p>
{else}
    {if isset($payment_error)}
        <p class="warning culqi_error">{$payment_error|escape:'htmlall':'UTF-8'}</p>
    {/if}
    
    <h3>{l s='Pago con tarjeta de crédito o débito' mod='culqi'}</h3>
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

<script>
    Culqi.publicKey = "{$codigo_comercio|escape:'htmlall':'UTF-8'}";

    Culqi.settings({
        title: 'Venta',
        currency: "{$currency->iso_code|escape:'htmlall':'UTF-8'}",
        description: "{$descripcion|escape:'htmlall':'UTF-8'}",
        amount: parseInt({$total|escape:'intval'})
    });

    $('#btn_pago').on('click', function(e) {
        $('#showresult').addClass('hide');
        Culqi.open();
        e.preventDefault();
    });

    // Recibimos Token del Culqi.js
    function culqi() {
      if(Culqi.token) {

        var installments = (Culqi.token.metadata.installments == undefined) ? 1 : Culqi.token.metadata.installments;
        
        $(document).ajaxStart(function(){
            run_waitMe();
        });
        
        $(document).ajaxComplete(function(){
            $('body').waitMe('hide');
        });
        
        $.ajax({
            url: "{$link->getModuleLink('culqi', 'chargeajax', [], true)}",
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
                    
                    console.log(result);
                    
                    if(result.object === 'charge'){
                        $('body').waitMe('hide');
                        showResult('green', result.outcome.user_message);
                        
                        $.ajax({
                            url: "/modules/culqi/controllers/front/storeLog.php",
                            data: {
                                "data" : result,
                                "id_cart": "{$cart->id}",
                                "id_customer": "{$cart->id_customer}"
                            },
                            type: "POST",
                            dataType: 'json',
                            success: function(res) {
                                console.log(res);
                                if(res.status)
                                    location.href = "{$link->getModuleLink('culqi', 'postpayment', ['id_cart' => $cart->id], true)}";
                            }
                        });
                    }
                    if(result.object === 'error'){
                      $('body').waitMe('hide');
                      showResult('red', result.user_message);
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
    
</script>