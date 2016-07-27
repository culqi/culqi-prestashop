<style type="text/css">
	.culqi-payment {
		padding: 30px 0px 50px 200px !important;
		background: url('https://placeholdit.imgix.net/~text?txtsize=20&txt=CARDS&w=160&h=65') 23px 22px no-repeat #fbfbfb;
	}
</style>

<div class="row">
	<div class="col-xs-12">
		<p class="payment_module">
		    <a class="culqi-payment" href="{$link->getModuleLink('culqi', 'payment', [], true)|escape:'html'}" title="{l s='Pagar con tarjeta de crédito o débito' mod='culqi'}">
		    	Pagar con tarjeta
		    	<span>Puedes utilizar cualquier tarjeta de crédito o débito VISA, Mastercard, American Express o Diners Club.</span>		       
		    </a>
		</p>
	</div>
</div>