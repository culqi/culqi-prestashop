<h2>{l s='Resumen del pedido' mod='culqi'}</h2> {assign var='current_step' value='payment'} {include file="$tpl_dir./order-steps.tpl"} {if isset($nbProducts) && $nbProducts
<=0 } <p class="warning">{l s='Tu carrito de compras está vacío.' mod='culqi'}</p>
    {else} {if isset($payment_error)}
    <p class="warning culqi_error">{$payment_error}</p>
    {/if}
    <h3>{l s='Pago con tarjeta de crédito o débito' mod='culqi'}</h3> {*
    <form id="pay" action="{$link->getModuleLink('culqi', 'validation', [], true)|escape:'html'}" method="post">*}
        <p style="margin-top:20px;">
            Usted ha elegido pagar con tarjeta de crédito o débito. Solo cuenta con 10 minutos para realizar el pago, de lo contrario este expirará.
        </p>
        <p style="margin-top:20px;">
            - {l s='El monto total a cancelar es deeeee:' mod='culqi'}
            <span id="amount" class="price"><b>{displayPrice price=$total}</b></span>
        </p>
        <p style="margin-top:20px;">
            <b>{l s='Por favor confirme su pedido haciendo clic en el botón.' mod='culqi'}</b>
        </p>
        <p style="margin-top:20px; display:block; margin: 0 auto; text-align: center;" class="cart_navigation" id="cart_navigation">
            <button id="btn_pago" class="culqi_btn_ok">Realizar Pago</button>
            <a style="line-height: 30px;" href="{$link->getPageLink('order', true, NULL, " step=3 ")|escape:'html'}" class="culqi_btn_cancel button_large">{l s='Cancelar' mod='culqi'}</a>
        </p>

        <p class="hide" id="showresult" style="margin-top:20px;">
            <b id="showresultcontent"></b>
        </p>

    {/if}

        {literal}
        <script>

            var $j = jQuery.noConflict();

            Culqi.codigoComercio = '{/literal}{$codigo_comercio}{literal}';

            Culqi.configurar({
              nombre: 'Venta',
              orden: '{/literal}{$orden}{literal}',
              moneda: 'PEN',
              descripcion: '{/literal}{$descripcion}{literal}',
              monto: ({/literal}{$total}{literal})*100,
              guardar: false
            });

            $('#btn_pago').on('click', function(e) {
                $('#showresult').addClass('hide');
                Culqi.abrir();
                e.preventDefault();
            });

            // Recibimos Token del Culqi.js
            function culqi() {
              if(Culqi.token) {
                $(document).ajaxStart(function(){
                  run_waitMe();
                });
                $.ajax({
                    url: fnReplace("{/literal}{$link->getModuleLink('culqi', 'chargeajax', [], true)|escape:'html'}{literal}"),
                    data: {
                      ajax: true,
                      action: 'displayAjax',
                      token_id: Culqi.token.id
                    },
                    type: "POST",
                    success: function(response) {
                      var data = JSON.parse(response);
                      if(data.response_code === 'venta_exitosa'){
                        showResult('green',data.user_message);
                      }
                      if(data.object === 'error'){
                        showResult('red',data.user_message);
                      }
                      $(document).ajaxComplete(function(){
                        $j('body').waitMe('hide');
                      });
                    }
                });
              }
            }

            function run_waitMe(){
              $j('body').waitMe({
                effect: 'orbit',
                text: 'Procesando pago...',
                bg: 'rgba(255,255,255,0.7)',
                color:'#28d2c8'
              });
            }

            function showResult(style,message){
              $('#showresult').removeClass('hide');
              $('#showresultcontent').addClass(style);
              $('#showresultcontent').html(message);
            }


            /*function redirect() {
                var url = fnReplace("{/literal}{$link->getModuleLink('culqi', 'postpayment', [], true)|escape:'html'}{literal}");
                location.href = url;
            };*/

            /*function returnRedirect() {
                var url = fnREplace("{/literal}{$link->getPageLink('order', true, NULL, "
                step = 3 ")|escape:'html'}{literal}");
                location.href = url;
            }*/

            /*function repayment(respuesta) {
                var url = fnReplace("{/literal}{$link->getModuleLink('culqi', 'payment', [] , true)|escape:'html'}{literal}");
                var redirUrl = "";
                if (respuesta != "") {
                    redirUrl = url + "?code=" + respuesta;
                } else {
                    redirUrl = url;
                }
                location.href = redirUrl;
            }*/

            function fnReplace(url) {
                return url.replace(/&amp;/g, '&');
            }

            /*function culqi() {
                var urlResponse = fnReplace("{/literal}{$link->getModuleLink('culqi', 'validation', [], true)|escape:'html'}{literal}");
                console.log(urlResponse);

                if (Culqi.respuesta == "checkout_cerrado") {
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
            };*/

        </script>
        {/literal}
