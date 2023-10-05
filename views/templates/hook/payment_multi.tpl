<style type="text/css">
	.culqi-payment {
		padding: 43px 0px 44px 97px !important;
		background: url('{$module_dir|escape:'htmlall':'UTF-8'}/culqi-logo.svg') 17px 22px no-repeat #fbfbfb;	
		background-size: 104px 24px;
    	background-position: left center;
		display: flex !important;
		align-items: center;
		justify-content: space-between;
		padding: 30px 0px 30px 97px !important;
	}

	.culqi-payment-logos {
		width: 285px;
		margin-right: 15px;		
		max-width: 75%;
	}

	.culqi-text-logos {
		!important border: 0px;
    	!importanttop: 0; 
    	!important position: absolute;
	}
</style>
<script>

$(document).ready(function() {

var tarjeta = '{$tarjeta}';
var banca_movil = '{$banca_movil}';
var yape = '{$yape}';
var billetera = '{$billetera}';
var agente = '{$agente}';
var cuetealo = '{$cuetealo}';
const anchorElement = document.querySelector('#culqi-payment-logo');	
var txt_general = 'Acepta pagos con ';
var txt = '';
var txtPE = '';
if(tarjeta == 'true'){
 	const image = document.createElement('img');
    image.className = 'culqi-payment-logos';    
    image.src = '{$this_path}cards.svg';
    image.alt = '';
	image.style.width = '130px';
    anchorElement.appendChild(image);
	txt = txt + 'tarjetas de débito y crédito ';
}
if(yape == 'true'){
	const image = document.createElement('img');
    image.className = 'culqi-payment-logos';    
    image.src = '{$this_path}yape.svg';
    image.alt = '';
	image.style.width = '20px';
    anchorElement.appendChild(image);
	txt = txt + ' ,Yape';
}
if(banca_movil == 'true' || billetera == 'true' || agente == 'true' || cuetealo == 'true'){
	const image = document.createElement('img');
    image.className = 'culqi-payment-logos';   
    image.src = '{$this_path}pagoefectivo.svg';
    image.alt = '';
	image.style.width = '20px';
    anchorElement.appendChild(image);
	txt = txt + ' Cuotéalo BCP y PagoEfectivo';
    txtPE = ' (billeteras móviles, agentes y bodegas)';
}
 
    txt = txt_general + txt + txtPE;
    txt = txt + '.';
    document.getElementById('mensaje').innerText = txt;

   
});

</script>

<div class="row">
	<div class="col-xs-12">
		<p class="payment_module">		
		    <a  id="texto" class="culqi-payment" href="{$link->getModuleLink('culqi', 'payment', [], true)|escape:'htmlall':'UTF-8'}" title="{l s='Pagar con tarjetas de crédito/débito y más' mod='culqi'}">
				<span id="mensaje" style = "width: 40%;margin-right:5px;margin-left:5px;"> </span>
				<span id="culqi-payment-logo"> </span>
		    </a>
		</p>
	</div>
</div>