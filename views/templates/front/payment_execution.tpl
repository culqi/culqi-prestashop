<style type="text/css">
    .culqi_error {
        background-color: #B70F26;
        width: auto;
        height: auto;
        text-align: left;
        margin: 0 auto;
        font-weight: 700;
        display: flex;
        justify-content: center;
        align-items: center;
        color: white;
        font-size: 1.1em;
        vertical-align: middle;
    }
    
    .culqi_btn_ok {
        width: 120px !important;
        height: 40px !important;
        background: green !important;
        color: white !important;
        border: 0px !important;
        text-align: center !important;
    }
    
    .culqi_btn_cancel {
        width: 120px !important;
        height: 40px !important;
        background: gray !important;
        color: white !important;
        border: 0px !important;
        text-align: center !important;
    }
    #left_column {
        display: none !important;
    }
    #center_column {
        width: 100% !important;
    }

</style>

{literal}
<script src="{/literal}{$ambiente_basepath}{literal}/api/v1/culqi.js"></script>
{/literal} {capture name=path}
<a href="{$link->getPageLink('order', true, NULL, " step=3 ")|escape:'html':'UTF-8'}" title="{l s='Regresar' mod='culqi'}">{l s='Checkout' mod='culqi'}</a><span class="navigation-pipe">{$navigationPipe}</span>{l s='Pago con tarjeta' mod='culqi'} {/capture}

<h2>{l s='Resumen del pedido' mod='culqi'}</h2> {assign var='current_step' value='payment'} {include file="$tpl_dir./order-steps.tpl"} {if isset($nbProducts) && $nbProducts
<=0 } <p class="warning">{l s='Tu carrito de compras está vacío.' mod='culqi'}</p>
    {else} {if isset($payment_error)}
    <p class="warning culqi_error">{$payment_error}</p>
    {/if}
    <h3>{l s='Pago con tarjeta de crédito o débito' mod='culqi'}</h3> {*
    <form action="{$link->getModuleLink('culqi', 'validation', [], true)|escape:'html'}" method="post">*}
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
            <input type="button" id="btn_pago" class="culqi_btn_ok" value="Realizar Pago" />
            <a style="line-height: 30px;" href="{$link->getPageLink('order', true, NULL, " step=3 ")|escape:'html'}" class="culqi_btn_cancel button_large">{l s='Cancelar' mod='culqi'}</a>
        </p>

        {/if} {literal}
        <script>
            checkout.codigo_comercio = '{/literal}{$codigo_comercio}{literal}';
            checkout.informacion_venta = '{/literal}{$informacion_venta}{literal}';

            $('#btn_pago').on('click', function(e) {
                checkout.abrir();
                e.preventDefault();
            });

            function redirect() {
                var url = fnReplace("{/literal}{$link->getModuleLink('culqi', 'postpayment', [], true)|escape:'html'}{literal}");
                location.href = url;
            };

            function returnRedirect() {
                var url = fnREplace("{/literal}{$link->getPageLink('order', true, NULL, "
                step = 3 ")|escape:'html'}{literal}");
                location.href = url;
            }

            function repayment(respuesta) {
                var url = fnReplace("{/literal}{$link->getModuleLink('culqi', 'payment', [] , true)|escape:'html'}{literal}");
                var redirUrl = "";
                if (respuesta != "") {
                    redirUrl = url + "?code=" + respuesta;
                } else {
                    redirUrl = url;
                }
                location.href = redirUrl;
            }

            function fnReplace(url) {
                return url.replace(/&amp;/g, '&');
            }

            function culqi(checkout) {
                var urlResponse = fnReplace("{/literal}{$link->getModuleLink('culqi', 'validation', [], true)|escape:'html'}{literal}");
                console.log(urlResponse)
                if (checkout.respuesta == "checkout_cerrado") {
                    repayment(window.btoa(unescape(encodeURIComponent("Se cerró el checkout, por favor intente nuevamente."))));
                } else if (checkout.respuesta == "venta_expirada") {
                    repayment(window.btoa(unescape(encodeURIComponent("La venta expiró, por favor intente nuevamente."))));
                } else {
                    $.ajax({
                        url: urlResponse,
                        type: "POST",
                        data: {
                            respuesta: checkout.respuesta
                        },
                        success: function(data) {
                            var res = JSON.parse(data);
                            if (res.codigo_respuesta == "venta_exitosa") {
                                checkout.cerrar();
                                redirect();
                            } else {
                                checkout.cerrar();
                                repayment(window.btoa(unescape(encodeURIComponent(res.mensaje_respuesta_usuario))));
                            }
                        }
                    });
                }
            };

        </script>
        {/literal}
