
<script type="text/javascript" defer src="{$this_path|escape:'htmlall':'UTF-8'}views/js/waitMe.min.js"></script>
{$timestamp = time()}
<script type="text/javascript" defer src="{$this_path|escape:'htmlall':'UTF-8'}views/brands/mastercard/mc-sonic.min.js?_={$timestamp}"></script>
<script type="text/javascript" defer src="{$this_path|escape:'htmlall':'UTF-8'}views/brands/visa/visa-sensory-branding.js?_={$timestamp}"></script>
<script>
const modulePath = "{$this_path|escape:'htmlall':'UTF-8'}views/brands";
const run_waitMe = (bg='rgba(0,0,0, 0.7)') => {
    $('body').waitMe({
        effect: 'bounce',
        text: 'Cargando. Espere por favor',
        bg: bg,
        color: '#ffffff'
    });
}
</script>
<script type="text/javascript" defer src="{$this_path|escape:'htmlall':'UTF-8'}views/js/brand-handle.js?_={$timestamp}"></script>

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
            const {parameters3DS, error} = event.data;
            if (parameters3DS) {
                var token = Culqi.token.id;
                var email = Culqi.token.email;

                $(document).ajaxStart(function () {
                    run_waitMe();
                });
                $(document).ajaxComplete(function () {
                });

                var installments = (Culqi.token.metadata == undefined || Culqi.token.metadata.installments == undefined) ? 0 : Culqi.token.metadata.installments;

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
                    success: function (data, textStatus, xhr) {
                        console.log('data:::', data);
                        var result = "";

                        if (data.constructor == String) {
                            result = JSON.parse(data);
                        }
                        if (data.constructor == Object) {
                            result = JSON.parse(JSON.stringify(data));
                        }
                        if (result.object === 'charge') {
                            var card_number = result['source']['card_number'];
                            var card_brand = result['source']['iin']['card_brand'] + ' ' + result['source']['iin']['card_category'] + ' ' + result['source']['iin']['card_type'];
                            var chargeid = result['id'];
                            var brand = result['source']['iin']['card_brand']
                            showResult('green', result['user_message']);                            

                            var url = fnReplace("{/literal}{$link->getModuleLink('culqi', 'postpayment', [], true)|escape:'htmlall':'UTF-8'}{literal}");
                            var success_url = url + '?card_number=' + card_number + '&card_brand=' + card_brand + '&orderid=' + orderid + '&chargeid=' + chargeid;
                            
                            if (brand.toUpperCase() == "MASTERCARD") {
                                fnMcSonic(success_url);
                            } else if (brand.toUpperCase() == "VISA") {
                                fnBrandvisa(success_url);
                            } else {
                                location.href = success_url;
                            }
                        }
                        if (result.object === 'error') {
                            $('body').waitMe('hide');
                            $('#showresult').show();
                            Culqi.close();
                            showResult('red', result['user_message']);
                        }

                    },
                    error: function (error, textStatus, xhr) {
                        showResult('red', error['user_message']);
                        $('#showresult').show();
                        console.log('error:::', error);
                        e.preventDefault();
                    },
                    beforeSend: function () {
                        run_waitMe();
                    }
                });
            }

            if (error) {
                showResult('red', error);
                $('#showresult').show();
                $('body').waitMe('hide');
                Culqi.close();
                console.log(error);

            }
        }
    }, false);

    // GENERAR DEVICE ID (INVOCAR APENAS SE DE AL BOTON PAGAR Y ABRA EL CULQI CHECKOUT)
    Culqi3DS.publicKey = "{/literal}{$llave_publica|escape:'htmlall':'UTF-8'}{literal}";
//    var device = await Culqi3DS.generateDevice();
    const device_aux = Promise.resolve(Culqi3DS.generateDevice());
    device_aux.then(value => {
      $('#buyButton').on('click', function (e) {
            $('#buyButton').attr('disabled', true);
            generateOrder(e, value);
      });
    }).catch(err => {
      console.log(err);
    });
    var orderid = '';

    $(document).ready(function () {
        var validateButtonOrder = setInterval(function () {
            $('input[type=radio]').each(function () {
                if ($(this).data('module-name') == 'culqi' && $(this).is(':checked')) {
                    $('div#payment-confirmation').hide();
                } else {
                    $('div#payment-confirmation').show();
                }
            })
        }, 100);

        $('#payment-confirmation > .ps-shown-by-js > button').click(function (e) {
            var myPaymentMethodSelected = $('.payment-options').find("input[data-module-name='culqi']").is(':checked');
            if (myPaymentMethodSelected) {
                Culqi.createToken();
                return false;
            }

        });
    });

    var Culqi = null

    function setCheckout() {
        const publicKey = setPublicKey();
        const config = setConfig();
        
        Culqi = new CulqiCheckout(publicKey, config);
        Culqi.culqi = culqi
        Culqi.open();
    }

    function setConfig() {
        const settings = setSetting();
        const client = setClient();
        const options = setOptions();
        const appearance = setAppearance();


        const config = {
            settings,
            client,
            options,
            appearance
        };

        return config
    }

    function setPublicKey() {
        return '{/literal}{$llave_publica|escape:'htmlall':'UTF-8'}{literal}';
    }

    function setSetting() {
        const setting = {
            title: '{/literal}{$commerce|escape:'htmlall':'UTF-8'}{literal}',
            currency: '{/literal}{$currency|escape:'htmlall':'UTF-8'}{literal}',
            amount:  {/literal}{$total|escape:'htmlall':'UTF-8'}{literal},
            culqiclient: 'prestashop',
            culqiclientversion:'{/literal}{$psversion|escape:'htmlall':'UTF-8'}{literal}',
            culqipluginversion: '{/literal}{$culqipluginversion|escape:'htmlall':'UTF-8'}{literal}'
        }

        // Agregar el orden si existe
        if (orderid != '') {
            setting.order = orderid;
        }

        // Agregar llave publica si existe
        if('{/literal}{$rsa_id|escape:'htmlall':'UTF-8'}{literal}' && `{/literal}{$rsa_pk|escape:'htmlall':'UTF-8'}{literal}`) {            
            setting.xculqirsaid = '{/literal}{$rsa_id|escape:'htmlall':'UTF-8'}{literal}';
            setting.rsapublickey = `{/literal}{$rsa_pk|escape:'htmlall':'UTF-8'}{literal}`;
        }

        return setting;
    }

    function setClient() {
        const client = {
            email: '{/literal}{$email|escape:'htmlall':'UTF-8'}{literal}' 
        };

        return client;
    }

    function setPaymentMethods() {
        const paymentMethods = {
            tarjeta: {/literal}{$tarjeta|escape:'htmlall':'UTF-8'}{literal},
            yape: {/literal}{$yape|escape:'htmlall':'UTF-8'}{literal},
            billetera: {/literal}{$billetera|escape:'htmlall':'UTF-8'}{literal},
            bancaMovil: {/literal}{$banca_movil|escape:'htmlall':'UTF-8'}{literal},
            agente: {/literal}{$agente|escape:'htmlall':'UTF-8'}{literal},
            cuotealo: {/literal}{$cuetealo|escape:'htmlall':'UTF-8'}{literal},
        }

        return paymentMethods;
    }

    function setOptions() {
        const paymentMethods = setPaymentMethods();

        const options = {
            lang: 'auto',
            installments: true,
            modal: true,
            paymentMethods,
            paymentMethodsSort: Object.keys(paymentMethods)
        }
        return options;
    }

    function setAppearance() {
        const appearence = {
            theme: "default",
            hiddenCulqiLogo: false,
            hiddenBannerContent: false,
            hiddenBanner: false,
            hiddenToolBarAmount: false,
            menuType: "sidebar", // sidebar / sliderTop / select
            logo: '{/literal}{$url_logo|escape:'htmlall':'UTF-8'}{literal}'
        }

        const colorPositionOne = '{/literal}{$color_pallete[0]|escape:'htmlall':'UTF-8'}{literal}';
        const colorPositionTwo = '{/literal}{$color_pallete[1]|escape:'htmlall':'UTF-8'}{literal}';
        if (colorPositionOne != '' && colorPositionTwo != '') {
            const defaultStyle = {};
            defaultStyle.bannerColor = colorPositionOne;
            defaultStyle.buttonBackground = colorPositionTwo;
            defaultStyle.menuColor = colorPositionTwo
            defaultStyle.linksColor = colorPositionTwo;
            defaultStyle.priceColor = colorPositionTwo;

            appearence.defaultStyle = defaultStyle;
        }

        return appearence;
    }

    function generateOrder(e, device) {
        window.device = device;
        if ({/literal}{$banca_movil|escape:'htmlall':'UTF-8'}{literal} || {/literal}{$agente|escape:'htmlall':'UTF-8'}{literal} || {/literal}{$billetera|escape:'htmlall':'UTF-8'}{literal} || {/literal}{$cuetealo|escape:'htmlall':'UTF-8'}{literal}) {
            $.ajax({
                url: fnReplace("{/literal}{$link->getModuleLink('culqi', 'generateorder', [], true)|escape:'htmlall':'UTF-8'}{literal}"),
                data: {},
                type: "POST",
                dataType: 'json',
                success: function (response) {
                    console.log('Se genero una orden:::', response);
                    orderid = response;
                    setCheckout()
                    $('#buyButton').removeAttr('disabled');
                    $('#showresult').hide();
                    e.preventDefault();
                },
                error: function (error) {
                    console.log('Error al generar orden :::', error);
                    $('#showresult').show();
                    orderid = ''
                    setCheckout()
                    $('#buyButton').removeAttr('disabled');
                    $('#showresult').hide();
                    e.preventDefault();
                }
            });
        } else {
            $('#showresult').show();
            console.log('No se genero orden');
            orderid = ''
            setCheckout()
            $('#buyButton').removeAttr('disabled');
            $('#showresult').hide();
            e.preventDefault();
        }
    }

    function showResult(style, message) {

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
        var ps_order_id = '';

        if (Culqi.order) {

            $(document).ajaxStart(function () {
            });

            $(document).ajaxComplete(function () {
            });

            var culqi_order_id = Culqi.order.id;

            $.ajax({
                url: fnReplace("{/literal}{$link->getModuleLink('culqi', 'registersale', [], true)|escape:'htmlall':'UTF-8'}{literal}"),
                data: {order_id: culqi_order_id},
                type: "POST",
                dataType: 'json',
                success: function (response) {
                    console.log('response:::', response);
                    ps_order_id = response;

                },
                error: function (error) {
                    console.log('error:::', error);
                    e.preventDefault();
                }
            });

            var id = setInterval(function () {
                if (!Culqi.isOpen) {
                    run_waitMe();
                    clearInterval(id);
                    var orderid = culqi_order_id;
                    var url = fnReplace("{/literal}{$link->getModuleLink('culqi', 'postpaymentpending', [], true)|escape:'htmlall':'UTF-8'}{literal}");
                    location.href = url + '?ps_order_id=' + ps_order_id;
                }
            }, 1000);


        } else if (Culqi.token) {
            Culqi.close();
            run_waitMe();
            var token = Culqi.token.id;
            var email = Culqi.token.email;

            $(document).ajaxStart(function () {
            });
            $(document).ajaxComplete(function () {
            });

            var installments = (Culqi.token.metadata == undefined || Culqi.token.metadata.installments == undefined) ? 0 : Culqi.token.metadata.installments;
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
                success: function (data, textStatus, xhr) {
                    console.log('data:::', data);
                    if (data.action_code == 'REVIEW') {
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
                        Culqi3DS.initAuthentication(token);
                    } else {

                        var result = "";

                        if (data.constructor == String) {
                            result = JSON.parse(data);
                        }
                        if (data.constructor == Object) {
                            result = JSON.parse(JSON.stringify(data));
                        }
                        console.log('result.object:::', result.object);
                        if (result.object === 'charge') {
                            run_waitMe();
                            var card_number = result['source']['card_number'];
                            var card_brand = result['source']['iin']['card_brand'] + ' ' + result['source']['iin']['card_category'] + ' ' + result['source']['iin']['card_type'];
                            var chargeid = result['id'];
                            var brand = result['source']['iin']['card_brand']
                            showResult('green', result['user_message']);

                            var url = fnReplace("{/literal}{$link->getModuleLink('culqi', 'postpayment', [], true)|escape:'htmlall':'UTF-8'}{literal}");
                            var success_url = url + '?card_number=' + card_number + '&card_brand=' + card_brand + '&orderid=' + orderid + '&chargeid=' + chargeid;
                            console.log("Marca de tarjeta: " + result['source']['iin']['card_brand']);

                            if (brand.toUpperCase() == "MASTERCARD") {
                                fnMcSonic(success_url);
                            } else if (brand.toUpperCase() == "VISA") {
                                fnBrandvisa(success_url);
                            } else {
                                location.href = success_url;
                            }

                        }
                        if (result.object === 'error') {
                            $('body').waitMe('hide');
                            Culqi.close();
                            showResult('red', result['user_message']);
                            $('#showresult').show();
                        }
                    }
                },
                error: function (error, textStatus, xhr) {
                    console.log('error:::', error);
                    $('body').waitMe('hide');
                    $('#showresult').show();
                    Culqi.close();
                }
            });


        } else {
            $('body').waitMe('hide');
            if (Culqi.error) {
                showResult('red', Culqi.error.user_message);
            }
        }

    }
</script>


{/literal}