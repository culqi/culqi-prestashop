<div class="row culqi_payment">

		<link rel="stylesheet" href="{$module_dir|escape:'htmlall':'UTF-8'}views/css/culqi.css" type="text/css" media="all">
    <link rel="stylesheet" href="{$module_dir|escape:'htmlall':'UTF-8'}views/css/waitMe.min.css" type="text/css" media="all">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.4/jquery.min.js"></script>
    <script src="http://checkout.culqi.com/v2"></script>
    <script type="text/javascript" defer src="{$module_dir|escape:'htmlall':'UTF-8'}views/js/waitMe.min.js"></script>

		<div class="row">

			<div class="col-md-3">
			</div>

			<div class="col-md-6">

				<form>

					<div class="form-group">
						<label>Email</label>
						<input type="text" placeholder="username@culqi.com" class="form-control" size="25" data-culqi="card[email]" id="card[email]" />
					</div>

					<div class="form-group">
						<label>Numero Tarjeta</label>
						<input type="text" placeholder="411111******1111" size="16" class="form-control" data-culqi="card[number]" id="card[number]" />
					</div>

					<div class="row">

						<div class="col-md-4">

							<div class="form-group">
									<label>CVV</label>
									<input type="text" placeholder="OOO" size="4" class="form-control" data-culqi="card[cvv]" id="card[cvv]" placeholder />
							</div>

						</div>

						<div class="col-md-4">

							<div class="form-group">
								<label>Mes exp.</label>
								<input type="text" placeholder="MM" size="2" class="form-control" data-culqi="card[exp_month]" id="card[exp_month]" />
							</div>

						</div>

						<div class="col-md-4">

							<div class="form-group">
								<label>Año exp.</label>
								<input type="text" placeholder="YYYY" size="2" class="form-control" data-culqi="card[exp_year]" id="card[exp_year]"/>
							</div>

						</div>

					</div>

				</form>

				<p class="hide" id="showresult">
		        <b id="showresultcontent"></b>
		    </p>

			</div>

			<div class="col-md-3">
			</div>

		</div>

		<br/>

</div>

{literal}
<script>

$(document).ready(function() {

	Culqi.publicKey = '{/literal}{$llave_publica|escape:'htmlall':'UTF-8'}{literal}';
	Culqi.init();

	$('#payment-confirmation > .ps-shown-by-js > button').click(function(e) {
		var myPaymentMethodSelected = $('.payment-options').find("input[data-module-name='culqi']").is(':checked');

		if(myPaymentMethodSelected) {
				Culqi.createToken();
				culqi();
				return false;
		}

	});				

});

// Process to Pay
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
	    //$('body').waitMe('hide');
	    showResult('green',result.outcome.user_message);
									//$('body').waitMe('show');
									$('#payment-confirmation > .ps-shown-by-js > button').prop("disabled",true);
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
				if(Culqi.error) {
					showResult('red',Culqi.error.user_message);
				}
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

function showResult(style,message) {
$('#showresult').removeClass('hide');
$('#showresultcontent').attr('class', '');
$('#showresultcontent').addClass(style);
$('#showresultcontent').html(message);
}

function redirect() {
  var url = fnReplace("{/literal}{$link->getModuleLink('culqi', 'postpayment', [], true)|escape:'htmlall':'UTF-8'}{literal}");
  location.href = url;
}

function fnReplace(url) {
  return url.replace(/&amp;/g, '&');
}

</script>
{/literal}
