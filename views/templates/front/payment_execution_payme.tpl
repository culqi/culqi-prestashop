<!-- <link rel="stylesheet" href="{$this_path|escape:'htmlall':'UTF-8'}views/css/waitMe.min.css" type="text/css" media="all"> -->

<script type="text/javascript" defer src="{$this_path|escape:'htmlall':'UTF-8'}views/js/waitMe.min.js"></script>

 <script type="text/javascript" defer src="{$enviroment_3ds|escape:'htmlall':'UTF-8'}"></script> 



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
            <span id="amount" class="price"><b>{displayPrice price=$totalShow}</b></span>
        </p>
        <p style="margin-top:20px;">
            <b>{l s='Por favor confirme su pedido haciendo clic en el botón.' mod='culqi'}</b>
        </p>
        <p style="margin-top:20px; display:block; margin: 0 auto; text-align: center;" class="cart_navigation" id="cart_navigation">
            <button id="buyButton" class="culqi_btn_ok">Realizar Pago</button>
            <a style="line-height: 30px;" href="{$link->getPageLink('order', true, NULL, " step=3 ")|escape:'htmlall':'UTF-8'}" class="culqi_btn_cancel button_large">{l s='Cancelar' mod='culqi'}</a>
        </p>

        <p id="showresult" class="text-center" style="margin-top: 2em; text-align: center; display: none;">
			<b id="showresultcontent" class="text-danger" style="color:red; font-size: 13px;"></b>
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
            console.log('data3ds58');
            console.log(event.data);
            if (parameters3DS) {
                console.log(Culqi);
                var token = Culqi.token.id;
                var email = Culqi.token.email;
                console.log('Se ha creado un token: ' + token);

                $(document).ajaxStart(function(){
                    console.log('run_waitMe 67');
                    run_waitMe();
                });
                $(document).ajaxComplete(function(){
                    //console.log('close loading 71');
                    //$('body').waitMe('hide');
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
                        console.log('result.object:::101', result.object);
                        if(result.object === 'charge') {
                            console.log('mostrando loading');
                            //console.log('run_waitMe 105');
                            //run_waitMe();
                            var card_number = result['source']['card_number'];
                            var card_brand = result['source']['iin']['card_brand'] + ' ' + result['source']['iin']['card_category'] + ' ' + result['source']['iin']['card_type'];
                            var chargeid = result['id'];
                            console.log('result:::', result['source']['iin']['card_brand'] + ' ' + result['source']['iin']['card_category'] + ' ' + result['source']['iin']['card_type']);
                            showResult('green',result['user_message']);

                            var url = fnReplace("{/literal}{$link->getModuleLink('culqi', 'postpayment', [], true)|escape:'htmlall':'UTF-8'}{literal}");
                            location.href = url + '?card_number=' + card_number + '&card_brand=' + card_brand + '&orderid='+ orderid + '&chargeid=' + chargeid;
                            //console.log('se redirigio a la otra pagina FIN');

                            //NO
                            //console.log('y aqui va la url');
                            //console.log(url + '?card_n1umber=' + card_number + '&card_brand=' + card_brand + '&orderid='+ orderid + '&chargeid=' + chargeid);

                        }
                        if(result.object === 'error') {
                            console.log('close loading 121');
                            $('body').waitMe('hide');
                            $('#showresult').show();
                            Culqi.close();
                            showResult('red',result['user_message']);
                        }

                    },
                    error: function(error, textStatus, xhr) {
                        showResult('red',error['user_message']);
                        $('#showresult').show();
                        //Culqi.close();
                        console.log('error:::', error);
                        e.preventDefault();
                    },
                    beforeSend: function(){
                        console.log('run_waitMe 135');
                        run_waitMe();
                    }
                });
            }

            if (error) {
                console.log('error3DS:::');
                showResult('red',error);
                $('#showresult').show();
                console.log('close loading 147');
                $('body').waitMe('hide');
                Culqi.close();
                console.log(error);

            }
        }
    }, false );

    // GENERAR DEVICE ID (INVOCAR APENAS SE DE AL BOTON PAGAR Y ABRA EL CULQI CHECKOUT)
    Culqi3DS.publicKey = "{/literal}{$llave_publica|escape:'htmlall':'UTF-8'}{literal}";
    var device = await Culqi3DS.generateDevice();
    var orderid = '';

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
            installments: true,
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
        $('#buyButton').attr('disabled', true);
        generateOrder(e);
    }); 

    function generateOrder(e) {
        console.log('{/literal}{$psversion|escape:'htmlall':'UTF-8'}{literal}');
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
                    culqiclient: 'prestashop',
                    culqiclientversion: '{/literal}{$psversion|escape:'htmlall':'UTF-8'}{literal}',
                });
                orderid = response;
                console.log(Culqi);
                $('#buyButton').removeAttr('disabled');
                Culqi.open();
                $('#showresult').hide();
                e.preventDefault();
            },
            error: function(error){
                console.log('error:::', error);
                $('#showresult').show();
                Culqi.settings({
                    title: '{/literal}{$commerce|escape:'htmlall':'UTF-8'}{literal}',
                    currency: '{/literal}{$currency|escape:'htmlall':'UTF-8'}{literal}',
                    amount: {/literal}{$total|escape:'htmlall':'UTF-8'}{literal},
                    //order: 'ord_live_mQjOSWvYKnNgotsY', // esto es solo si se tiene habilitada la opción de billeteras, agentes y/o cuetealo
                    culqiclient: 'prestashop',
                    culqiclientversion: '{/literal}{$psversion|escape:'htmlall':'UTF-8'}{literal}',
                });
                orderid = 'ungenereted';
                $('#buyButton').removeAttr('disabled');
                Culqi.open();
                $('#showresult').hide();
                e.preventDefault();
            }
        });

    }

    function showResult(style,message) {

        var new_message = ''

        if (message == '') {
            new_message = 'ERROR CULQI';
        } else {
            new_message = message;
        }

        $('#showresult').removeClass('hide');
        $('#showresultcontent').attr('class', '');
        $('#showresultcontent').addClass(style);
        $('#showresultcontent').html(new_message);
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
        var ps_order_id = '';

        if(Culqi.order) {

            $(document).ajaxStart(function(){
                //run_waitMe();
            });

            $(document).ajaxComplete(function(){
                //$('body').waitMe('hide');
            });

            //console.log('loading 311');
            //run_waitMe();

            var culqi_order_id = Culqi.order.id;
            console.log('culqi_order_id:::', culqi_order_id);
            console.log('aqui se registra la venta');

            $.ajax({
                url: fnReplace("{/literal}{$link->getModuleLink('culqi', 'registersale', [], true)|escape:'htmlall':'UTF-8'}{literal}"),
                data: { order_id: culqi_order_id },
                type: "POST",
                dataType: 'json',
                success: function(response) {
                    console.log('response:::', response);
                    ps_order_id = response;

                },
                error: function(error){
                    console.log('error:::', error);
                    e.preventDefault();
                }
            });


            if(Culqi.token==null){
                var id = setInterval(function(){
                    if(!Culqi.isOpen){
                        console.log('loading 339');
                        run_waitMe();
                        clearInterval(id);
                        var orderid = Culqi.order['id'];
                        var url = fnReplace("{/literal}{$link->getModuleLink('culqi', 'postpaymentpending', [], true)|escape:'htmlall':'UTF-8'}{literal}");
                        location.href = url + '?ps_order_id=' + ps_order_id;
                        //break;
                    }
                }, 1000);
            }else{
                var orderid = Culqi.order['id'];
                var url = fnReplace("{/literal}{$link->getModuleLink('culqi', 'postpaymentpending', [], true)|escape:'htmlall':'UTF-8'}{literal}");
                location.href = url + '?ps_order_id=' + ps_order_id;
            }
        } else if (Culqi.token) {
            Culqi.close();
            run_waitMe();
            var token = Culqi.token.id;
            var email = Culqi.token.email;
            console.log(email)
            console.log('Se ha creado un token: ' + token);

            $(document).ajaxStart(function(){
                //console.log('run_waitMe 349');
                //run_waitMe();
            });
            $(document).ajaxComplete(function(){
                //console.log('close loading 360');
                //$('body').waitMe('hide');
            });

            var installments = (Culqi.token.metadata.installments == undefined) ? 0 : Culqi.token.metadata.installments;
            console.log('installments:::', installments);

            console.log('aqui se registra la venta');

            console.log('ps_order_id:::', ps_order_id);
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
                    console.log('data.action_code:::', data.action_code);
                    if(data.action_code=='REVIEW'){
                        $('body').waitMe('hide');
                        Culqi3DS.settings = {
                            charge: {
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
                        console.log('result.object:::', result.object);
                        if(result.object === 'charge') {
                            console.log('mostrando loading');
                            console.log('run_waitMe 405');
                            run_waitMe();
                            var card_number = result['source']['card_number'];
                            var card_brand = result['source']['iin']['card_brand'] + ' ' + result['source']['iin']['card_category'] + ' ' + result['source']['iin']['card_type'];
                            var chargeid = result['id'];
                            //console.log('result:::', result['source']['iin']['card_brand'] + ' ' + result['source']['iin']['card_category'] + ' ' + result['source']['iin']['card_type']);
                            showResult('green',result['user_message']);
                            //$('#payment-confirmation > .ps-shown-by-js > button').prop("disabled",true);
                            //redirect();

                            //var id = setInterval(function(){
                            //console.log('result:::', result);
                            //if(!Culqi.isOpen){
                            //clearInterval(id);

                            var url = fnReplace("{/literal}{$link->getModuleLink('culqi', 'postpayment', [], true)|escape:'htmlall':'UTF-8'}{literal}");
                            location.href = url + '?card_number=' + card_number + '&card_brand=' + card_brand + '&orderid='+ orderid + '&chargeid=' + chargeid;
                            //}
                            //}, 1000);

                        }
                        if(result.object === 'error') {
                            console.log('close loading 436');
                            $('body').waitMe('hide');
                            Culqi.close();
                            showResult('red',result['user_message']);
                            $('#showresult').show();
                        }
                    }
                },
                error: function(error, textStatus, xhr) {
                    console.log('error:::434', error);
                    console.log('close loading 446');
                    $('body').waitMe('hide');
                    $('#showresult').show();
                    Culqi.close();
                }
            });






        } else {

            console.log(Culqi.error);
            console.log('error token');
            console.log('close loading 462')
            $('body').waitMe('hide');
            if(Culqi.error) {
                showResult('red',Culqi.error.user_message);
            }
        }

    }
    window.culqi = culqi;


    function run_waitMe() {
        //console.log('run_waitMe');
        $('body').waitMe({
            effect: 'bounce',
            text: 'Cargando. Espere por favor',
            bg: 'rgba(0,0,0, 0.7)',
            color:'#ffffff'
        });
    }
</script>
{/literal}


        
        




        
