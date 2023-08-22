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
</style>

<div class="row">
	<div class="col-xs-12">
		<p class="payment_module">
		    <a class="culqi-payment" href="{$link->getModuleLink('culqi', 'payment', [], true)|escape:'htmlall':'UTF-8'}" title="{l s='Pagar con tarjetas de crédito/débito y más' mod='culqi'}">
		    	<span>Pagar con Culqi</span>
		    	<span>Pagar con tarjetas de crédito/débito y más</span>
				<img class="culqi-payment-logos" src="{$this_path}cards.svg" alt="" />
		    </a>
		</p>
	</div>
</div>
