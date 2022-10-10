<style type="text/css">
	.culqi-payment {
		padding: 43px 0px 44px 97px !important;
		background: url('{$module_dir|escape:'htmlall':'UTF-8'}/logo.png') 17px 22px no-repeat #fbfbfb;	
		background-size: 62px 61px;
		
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
