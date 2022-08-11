<script type="text/javascript" defer src="{$this_path|escape:'htmlall':'UTF-8'}views/js/waitMe.min.js"></script>
<script type="text/javascript" defer src="{$this_path|escape:'htmlall':'UTF-8'}views/js/culqi-3ds.min_old.js"></script>
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

{literal}

<script type="module">
    /**
     * @license
     * three.js - JavaScript 3D library
     * Copyright 2016 The three.js Authors
     *
     * Permission is hereby granted, free of charge, to any person obtaining a copy
     * of this software and associated documentation files (the "Software"), to deal
     * in the Software without restriction, including without limitation the rights
     * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
     * copies of the Software, and to permit persons to whom the Software is
     * furnished to do so, subject to the following conditions:
     *
     * The above copyright notice and this permission notice shall be included in
     * all copies or substantial portions of the Software.
     *
     * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
     * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
     * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
     * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
     * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
     * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
     * THE SOFTWARE.
     */
    Culqi3DS.options = {
        closeModalAction: () => window.location.reload(true), // ACTION CUANDO SE CIERRA EL MODAL
    };

    window.addEventListener("message", async function (event) {

        if (event.origin === window.location.origin) {
            const { parameters3DS, error } = event.data;
            console.log('data3ds');
            console.log(event.data);
            if (parameters3DS) {
                console.log(Culqi);
                var token = Culqi.token.id;
                var email = Culqi.token.email;
                console.log('Se ha creado un token: ' + token);

                $(document).ajaxStart(function(){
                    run_waitMe();
                });
                $(document).ajaxComplete(function(){
                    $('body').waitMe('hide');
                });

                var installments = (Culqi.token.metadata.installments == undefined) ? 0 : Culqi.token.metadata.installments;
                console.log('installments:::', installments);

                $.ajax({
                    url: fnReplace("{/literal}{$link->getModuleLink('culqi', 'chargeajax', [], true)|escape:'htmlall':'UTF-8'}{literal}"),
                    data: {
                        ajax: true,
                        action: 'displayAjax',
                        token_id: Culqi.token.id,
                        installments: installments,
                        email: Culqi.token.email,
                        device: device,
                        parameters3DS: parameters3DS
                    },
                    type: "POST",
                    dataType: 'json',
                    success: function(data, textStatus, xhr) {
                        console.log('statuscode::',xhr.status);
                        console.log('data:::', data);
                        console.log('xCulqi:::', Culqi);
                        var result = "";

                        if(data.constructor == String) {
                            result = JSON.parse(data);
                        }
                        if(data.constructor == Object) {
                            result = JSON.parse(JSON.stringify(data));
                        }
                        if(result.object === 'charge') {
                            var card_number = result['source']['card_number'];
                            var card_brand = result['source']['iin']['card_brand'] + ' ' + result['source']['iin']['card_category'] + ' ' + result['source']['iin']['card_type'];
                            //console.log('result:::', result['source']['iin']['card_brand'] + ' ' + result['source']['iin']['card_category'] + ' ' + result['source']['iin']['card_type']);
                            showResult('green',result['user_message']);

                            var url = fnReplace("{/literal}{$link->getModuleLink('culqi', 'postpayment', [], true)|escape:'htmlall':'UTF-8'}{literal}");
                            location.href = url + '?card_number=' + card_number + '&card_brand=' + card_brand;

                        }
                        if(result.object === 'error') {
                            $('body').waitMe('hide');
                            $('#showresult').show();
                            Culqi.close();
                            showResult('red',result['user_message']);
                        }

                    },
                    error: function(error, textStatus, xhr) {
                        showResult('red',error['user_message']);
                        $('#showresult').show();
                        Culqi.close();
                        console.log('error:::', error);
                    }
                });
            }

            if (error) {
                console.log('error3DS:::');
                console.log(error);
            }
        }
    }, false );

    // GENERAR DEVICE ID (INVOCAR APENAS SE DE AL BOTON PAGAR Y ABRA EL CULQI CHECKOUT)
    var device = await Culqi3DS.generateDevice();

    $(document).ready(function() {
        var validateButtonOrder = setInterval(function(){
            $('input[type=radio]').each(function(){
                if($(this).data('module-name')=='culqi' && $(this).is(':checked')){
                    $('div#payment-confirmation').hide();
                }else{
                    $('div#payment-confirmation').show();
                }
            })
        }, 100);

        Culqi.publicKey = '{/literal}{$llave_publica|escape:'htmlall':'UTF-8'}{literal}';
        Culqi.useClasses = true;
        Culqi.init();

        console.log('{/literal}{$llave_publica|escape:'htmlall':'UTF-8'}{literal}');
        generateOrder();


        /* Culqi.settings({
            title: 'Nombre del comercio',
            currency: 'PEN', // 'USD'
            amount: 1500,
            order: 'ord_live_mQjOSWvYKnNgotsY', // esto es solo si se tiene habilitada la opción de billeteras, agentes y/o cuetealo
            culqiCliente: 'woocomerce', //Enviar el CMS
            culqiClienteVersion: '10.2', //Enviar la versión del CMS
        }); */

        Culqi.options({
            lang: 'auto',
            paymentMethods: {
                tarjeta: {/literal}{$tarjeta|escape:'htmlall':'UTF-8'}{literal},
                bancaMovil: {/literal}{$banca_movil|escape:'htmlall':'UTF-8'}{literal},
                agente: {/literal}{$agente|escape:'htmlall':'UTF-8'}{literal},
                billetera: {/literal}{$billetera|escape:'htmlall':'UTF-8'}{literal},
                cuotealo: {/literal}{$cuetealo|escape:'htmlall':'UTF-8'}{literal}
            },
            style: {
                bannerColor: '{/literal}{$color_pallete[0]|escape:'htmlall':'UTF-8'}{literal}',
                imageBanner: '',
                buttonBackground: '{/literal}{$color_pallete[1]|escape:'htmlall':'UTF-8'}{literal}',
                menuColor: '{/literal}{$color_pallete[1]|escape:'htmlall':'UTF-8'}{literal}',
                linksColor: '{/literal}{$color_pallete[1]|escape:'htmlall':'UTF-8'}{literal}',
                buttontext: '{/literal}{$color_pallete[0]|escape:'htmlall':'UTF-8'}{literal}',
                priceColor: '{/literal}{$color_pallete[1]|escape:'htmlall':'UTF-8'}{literal}',
                logo: '{/literal}{$url_logo|escape:'htmlall':'UTF-8'}{literal}'
            }
        });

        $('#payment-confirmation > .ps-shown-by-js > button').click(function(e) {
            var myPaymentMethodSelected = $('.payment-options').find("input[data-module-name='culqi']").is(':checked');
            if(myPaymentMethodSelected) {
                Culqi.createToken();
                return false;
            }

        });
    });

    $('#buyButton').on('click', function(e) {
        // Abre el formulario con las opciones de Culqi.settings
        Culqi.open();
        $('#showresult').hide();
        e.preventDefault();
    });

    function generateOrder() {

        $.ajax({
            url: fnReplace("{/literal}{$link->getModuleLink('culqi', 'generateorder', [], true)|escape:'htmlall':'UTF-8'}{literal}"),
            data: {  },
            type: "POST",
            dataType: 'json',
            success: function(response) {
                console.log('response:::', response);
                Culqi.settings({
                    title: '{/literal}{$commerce|escape:'htmlall':'UTF-8'}{literal}',
                    currency: '{/literal}{$currency|escape:'htmlall':'UTF-8'}{literal}',
                    amount: {/literal}{$total|escape:'htmlall':'UTF-8'}{literal},
                    order: response,
                    culqiclient: 'pretashop',
                    culqiclientversion: '{/literal}{$psversion|escape:'htmlall':'UTF-8'}{literal}',
                });

                console.log(Culqi);
            },
            error: function(error){
                console.log('error:::', error);
                $('#showresult').show();
                Culqi.settings({
                    title: '{/literal}{$commerce|escape:'htmlall':'UTF-8'}{literal}',
                    currency: '{/literal}{$currency|escape:'htmlall':'UTF-8'}{literal}',
                    amount: {/literal}{$total|escape:'htmlall':'UTF-8'}{literal},
                    //order: 'ord_live_mQjOSWvYKnNgotsY', // esto es solo si se tiene habilitada la opción de billeteras, agentes y/o cuetealo
                    culqiclient: 'pretashop',
                    culqiclientversion: '{/literal}{$psversion|escape:'htmlall':'UTF-8'}{literal}',
                });
            }
        });

    }

    function run_waitMe() {
        $('body').waitMe({
            effect: 'orbit',
            text: 'Procesando pago...',
            bg: 'rgba(255,255,255,0.7)',
            color:'#28d2c8'
        });
    }

    function showResult(style,message) {
        $('#showresult').removeClass('hide');
        $('#showresultcontent').attr('class', '');
        $('#showresultcontent').addClass(style);
        $('#showresultcontent').html(message);
    }

    function fnReplace(url) {
        return url.replace(/&amp;/g, '&');
    }

    function redirect() {

        if (Culqi.order) {
            var codigocip = Culqi.order['payment_code'];
            var url = fnReplace("{/literal}{$link->getModuleLink('culqi', 'postpaymentpending', [], true)|escape:'htmlall':'UTF-8'}{literal}");
            //location.href = url + '?transaction_id=' + codigocip;
        } else if (Culqi.token) {
            var url = fnReplace("{/literal}{$link->getModuleLink('culqi', 'postpayment', [], true)|escape:'htmlall':'UTF-8'}{literal}");
            //location.href = url;
        }

    }

    // Process to Pay
    function culqi() {

        console.log('yCulqi:::', Culqi);

        if(Culqi.order) {

            $(document).ajaxStart(function(){
                run_waitMe();
            });
            $(document).ajaxComplete(function(){
                $('body').waitMe('hide');
            });
            if(Culqi.token==null){
                var id = setInterval(function(){
                    if(!Culqi.isOpen){
                        clearInterval(id);
                        var orderid = Culqi.order['id'];
                        var url = fnReplace("{/literal}{$link->getModuleLink('culqi', 'postpaymentpending', [], true)|escape:'htmlall':'UTF-8'}{literal}");
                        location.href = url + '?transaction_id=' + orderid;
                        //break;
                    }
                }, 1000);
            }else{
                var orderid = Culqi.order['id'];
                var url = fnReplace("{/literal}{$link->getModuleLink('culqi', 'postpaymentpending', [], true)|escape:'htmlall':'UTF-8'}{literal}");
                location.href = url + '?transaction_id=' + orderid;
            }
        } else if (Culqi.token) {

            var token = Culqi.token.id;
            var email = Culqi.token.email;
            console.log(email)
            console.log('Se ha creado un token: ' + token);

            $(document).ajaxStart(function(){
                run_waitMe();
            });
            $(document).ajaxComplete(function(){
                $('body').waitMe('hide');
            });

            var installments = (Culqi.token.metadata.installments == undefined) ? 0 : Culqi.token.metadata.installments;
            console.log('installments:::', installments);

            $.ajax({
                url: fnReplace("{/literal}{$link->getModuleLink('culqi', 'chargeajax', [], true)|escape:'htmlall':'UTF-8'}{literal}"),
                data: {
                    ajax: true,
                    action: 'displayAjax',
                    token_id: Culqi.token.id,
                    installments: installments,
                    email: Culqi.token.email,
                    device: device
                },
                type: "POST",
                dataType: 'json',
                success: function(data, textStatus, xhr) {
                    console.log('statuscode::',xhr.status);
                    console.log('data:::', data);
                    console.log('xCulqi:::', Culqi);
                    if(data.action_code=='REVIEW'){
                        Culqi.close();
                        Culqi3DS.settings = {
                            charge: {
                                currency: '{/literal}{$currency|escape:'htmlall':'UTF-8'}{literal}',
                                totalAmount: {/literal}{$total|escape:'htmlall':'UTF-8'}{literal},
                                returnUrl: "{/literal}{$BASE_URL|escape:'htmlall':'UTF-8'}{literal}" //URL DEL CHECKOUT DEL COMERCIO
                            },
                            card: {
                                email: email,
                            }
                        };
                        console.log('abriendo3DS');
                        console.log("{/literal}{$BASE_URL|escape:'htmlall':'UTF-8'}{literal}");
                        Culqi3DS.initAuthentication(token);
                    }else{
                        var result = "";

                        if(data.constructor == String) {
                            result = JSON.parse(data);
                        }
                        if(data.constructor == Object) {
                            result = JSON.parse(JSON.stringify(data));
                        }
                        if(result.object === 'charge') {
                            var card_number = result['source']['card_number'];
                            var card_brand = result['source']['iin']['card_brand'] + ' ' + result['source']['iin']['card_category'] + ' ' + result['source']['iin']['card_type'];
                            //console.log('result:::', result['source']['iin']['card_brand'] + ' ' + result['source']['iin']['card_category'] + ' ' + result['source']['iin']['card_type']);
                            showResult('green',result['user_message']);
                            //$('#payment-confirmation > .ps-shown-by-js > button').prop("disabled",true);
                            //redirect();

                            var id = setInterval(function(){
                                console.log('result:::', result);
                                if(!Culqi.isOpen){
                                    clearInterval(id);
                                    var url = fnReplace("{/literal}{$link->getModuleLink('culqi', 'postpayment', [], true)|escape:'htmlall':'UTF-8'}{literal}");
                                    location.href = url + '?card_number=' + card_number + '&card_brand=' + card_brand;
                                }
                            }, 1000);

                        }
                        if(result.object === 'error') {
                            $('body').waitMe('hide');
                            $('#showresult').show();
                            Culqi.close();
                            showResult('red',result['user_message']);
                        }
                    }
                },
                error: function(error, textStatus, xhr) {
                    console.log('error:::', error);
                    showResult('red',error['user_message']);
                    $('#showresult').show();
                    Culqi.close();
                }
            });
        } else {

            console.log(Culqi.error);
            console.log('error token');
            $('body').waitMe('hide');
            if(Culqi.error) {
                showResult('red',Culqi.error.user_message);
            }
        }

    }
    window.culqi = culqi;

</script>

{/literal}
        
        




        
