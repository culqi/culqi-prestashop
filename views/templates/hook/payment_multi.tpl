<style type="text/css">
	.culqi-payment {
		/*padding: 30px 0px 50px 200px !important;
		background: url('https://i.imgur.com/10Nj1l0.png') 23px 22px no-repeat #fbfbfb;*/
		padding: 43px 0px 44px 97px !important;
		background: url('{$module_dir|escape:'htmlall':'UTF-8'}/logo.png') 17px 22px no-repeat #fbfbfb;	
		background-size: 62px 61px;
		
	}

	.culqi-payment-logos {
		max-width: 285px;
		margin-right: 15px;
		float: right;
		width: 98%;
	}
</style>

<div class="row">
	<div class="col-xs-12">
		<p class="payment_module">
		    <a class="culqi-payment" href="{$link->getModuleLink('culqi', 'payment', [], true)|escape:'htmlall':'UTF-8'}" title="{l s='Pagar con tarjetas de crédito/débito y más' mod='culqi'}">
		    	Pagar con Culqi
		    	<span>Pagar con tarjetas de crédito/débito y más</span>
				<img class="culqi-payment-logos" src="{$this_path}logo_cards.png" alt="" />
		    </a>
		</p>
	</div>
</div>
