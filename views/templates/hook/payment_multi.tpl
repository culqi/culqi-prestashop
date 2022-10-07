<style type="text/css">
	.culqi-payment {
		padding: 30px 0px 50px 140px !important;
		background: url('https://raw.githubusercontent.com/culqi/culqi-prestashop/prestashop1.6-checkoutv4-js3DS-imagen2/views/templates/hook/cards.png') -8px 22px no-repeat #fbfbfb;*/
	}
</style>

<div class="row">
	<div class="col-xs-12">
		<p class="payment_module">
		    <a class="culqi-payment" href="{$link->getModuleLink('culqi', 'payment', [], true)|escape:'htmlall':'UTF-8'}" title="{l s='Pagar con tarjetas de crédito/débito y más' mod='culqi'}">
		    	Pagar con Culqi
		    	<span>Pagar con tarjetas de crédito/débito y más</span>
		    </a>
		</p>
	</div>
</div>
