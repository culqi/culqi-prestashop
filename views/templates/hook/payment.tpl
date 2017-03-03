<p class="payment_module">
	<div class="row">
		<link rel="stylesheet" href="{$module_dir|escape:'htmlall':'UTF-8'}views/css/culqi.css" type="text/css" media="all">
    <link rel="stylesheet" href="{$module_dir|escape:'htmlall':'UTF-8'}views/css/waitMe.min.css" type="text/css" media="all">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.4/jquery.min.js"></script>
    <script src="https://checkout.culqi.com/plugins/v2/"></script>
    <script type="text/javascript" defer src="{$module_dir|escape:'htmlall':'UTF-8'}views/js/waitMe.min.js"></script>

		Pague con tarjeta de crédito/debito.
    <button disabled="disabled" id="btn_pago" class="btn btn-primary center-block">Realizar Pago</button><br/>
    <p class="hide" id="showresult">
        <b id="showresultcontent"></b>
    </p>

	</div>
</p>
{literal}
<script>

    $(document).ready(function(){

      Culqi.publicKey = '{/literal}{$llave_publica|escape:'htmlall':'UTF-8'}{literal}'; //'pk_test_vzMuTHoueOMlgUPj';

      Culqi.settings({
  			title: 'Venta',
  			currency: 'PEN',
  			description: '{/literal}{$descripcion|escape:'htmlall':'UTF-8'}{literal}',
  			amount: ({/literal}{$total|escape:'htmlall':'UTF-8'}{literal})*100
      });

      $(".custom-checkbox").click(function(){
        if($(this).children().is(":checked")){
          $("#btn_pago").removeAttr("disabled");
        } else {
          $("#btn_pago").attr("disabled","disabled");
        }
      });

      $('#btn_pago').on('click', function(e) {
          $('#showresult').addClass('hide');
          Culqi.open();
          e.preventDefault();
      });

      $("#payment-confirmation > .ps-shown-by-js").children().click(function(e){
        e.preventDefault();
        e.stopPropagation();
        charge();
      });

      // Recibimos Token del Culqi.js
      function charge() {
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

    })

</script>
{/literal}
