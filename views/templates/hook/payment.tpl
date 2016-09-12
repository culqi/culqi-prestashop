<style type="text/css">
	.culqi-payment {
		padding: 30px 0px 50px 200px !important;
		background: url('http://i.imgur.com/LjiIq9g.png') 23px 22px no-repeat #fbfbfb;
	}
</style>

<div class="row">
	<div class="col-xs-12">
		<p class="payment_module">
		    <a class="culqi-payment" href="{$link->getModuleLink('culqi', 'payment', [], true)|escape:'html'}" title="{l s='Pagar con tarjeta de crédito o débito' mod='culqi'}">
		    	Pagar con Tarjeta
		    	<span>Pague con tarjeta de crédito/debito.</span>		       
		    </a>
		</p>
	</div>
</div>
