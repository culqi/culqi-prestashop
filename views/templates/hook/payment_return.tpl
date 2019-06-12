<style type="text/css">
	.font-enhancement {
		font-size: 1.1em;
	}
</style>

{if $status == 'ok'}
<div class="font-enhancement">
	<p>{l s='Tu pago ha sido procesado satisfactoriamente.' sprintf=$shop_name mod='culqi'}
		{l s=' Adicionalmente, te hemos enviado un correo electrónico con la información de la compra que acabas de realizar.' mod='culqi'}
		<br /><br /><strong>{l s='Tu orden será enviada en el tiempo estimado de entrega.' mod='culqi'}</strong>
		<br /><br />{l s='Si tienes alguna consulta, comunícate con nosotros' mod='culqi'}.
	</p>
</div>
{elseif $status == 'pending'}
    <div class="font-enhancement">
	<p>{l s='¡Solo falta un paso! Tu pago esta en espera de ser pagado, no te olvides pagar con el codigo de pago (CIP) antes del tiempo de expiración en agentes/bancos o por banca móvil.' sprintf=$shop_name mod='culqi'}
		{l s=' Adicionalmente, te hemos enviado un correo electrónico con la información de la compra que acabas de realizar.' mod='culqi'}
	
	</p>
</div>

{else}
<p class="warning">
	{l s='Ha ocurrido un error con tu pago:' mod='culqi'}
</p>
{/if}
