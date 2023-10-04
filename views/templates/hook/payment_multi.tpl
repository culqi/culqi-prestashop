<style type="text/css">
	.culqi-payment {
		padding: 43px 0px 44px 97px !important;
		background: url('{$module_dir|escape:'htmlall':'UTF-8'}/culqi-logo.svg') 17px 22px no-repeat #fbfbfb;	
		background-size: 104px 24px;
    	background-position: left center;
		display: flex !important;
		align-items: center;
		justify-content: right;
		padding: 30px 0px 30px 97px !important;
	}
	.culqi-payment span {
		display: none !important;
	}

	.culqi-payment-logos {
		width: 285px;
		margin-right: 15px;
		float: right;
		max-width: 75%;
	}

	.culqi-text-logos {
		border: 0px;
    	top: 0; 
    	position: absolute;
	}
</style>
<script>

$(document).ready(function() {

console.log("hola");
console.log('{$this_test}');
console.log("tarjeta");
console.log('{$tarjeta}');
console.log("YAPE2");
console.log('{$yape}');
console.log("banca_movil2");
console.log('{$banca_movil}');


var tarjeta = '{$tarjeta}';
var banca_movil = '{$banca_movil}';
var yape = '{$yape}';
var billetera = '{$billetera}';
var agente = '{$agente}';
var cuetealo = '{$cuetealo}';
const anchorElement = document.querySelector('.culqi-payment');	
var txt_general = 'Acepta pagos con ';
var txt = '';
var txtPE = '';
if(tarjeta == 'true'){
	console.log("tarjeta" + tarjeta);
 	const image = document.createElement('img');
    image.className = 'culqi-payment-logos';
    image.dataset.test = '{$this_test}';
    image.src = '{$this_path}cards.svg';
    image.alt = '';
	image.style.width = '30%';
    anchorElement.appendChild(image);
	txt = txt + 'tarjetas de débito y crédito';
}
if(yape == 'true'){
	console.log("yape" + yape);
	const image = document.createElement('img');
    image.className = 'culqi-payment-logos';
    image.dataset.test = '{$this_test}';
    image.src = '{$this_path}yape.svg';
    image.alt = '';
	image.style.width = '5%';
    anchorElement.appendChild(image);
	txt = txt + ' Yape';
}
if(banca_movil == 'true' || billetera == 'true' || agente == 'true' || cuetealo == 'true'){
	console.log("billetera" + billetera);
	const image = document.createElement('img');
    image.className = 'culqi-payment-logos';
    image.dataset.test = '{$this_test}';
    image.src = '{$this_path}pagoefectivo.svg';
    image.alt = '';
	image.style.width = '5%';
    anchorElement.appendChild(image);
	txt = txt + 'Cuotéalo BCP y PagoEfectivo';
    txtPE = ' (billeteras móviles, agentes y bodegas)';
}
    txt = '<strong>' + txt +'</strong>';
    txt = txt_general + txt + txtPE;
    txt = txt + '.';
    //document.getElementById('texto').innerText = txt;

   
});

</script>

<div class="row">
	<div class="col-xs-12">
		<p class="payment_module">		
		    <a  id="texto" class="culqi-payment" href="{$link->getModuleLink('culqi', 'payment', [], true)|escape:'htmlall':'UTF-8'}" title="{l s='Pagar con tarjetas de crédito/débito y más' mod='culqi'}">
		    	    	
		    </a>
			<a class = "culqi-text-logos">Pagar con Culqi</a>		
		</p>
	</div>
</div>