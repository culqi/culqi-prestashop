# culqi-prestashop

### Pasos para la integración del Módulo de Culqi

#### 1. Registrarse en Culqi   `<link>` : <https://www.culqi.com/>

Así podras tener acceso al ambiente de pruebas de Culqi `<link>` : <https://integ-panel.culqi.com/>
donde encontraras tus llaves `<link>` : <https://integ-panel.culqi.com/#/desarrollo/llaves/> 

`Llave publica: pk_test_xxxxxxxxxxxxxx`

`Llave privada: sk_test_xxxxxxxxxxxxxx`

#### 2. Descargar el módulo de Culqi 2.3.2

`<link>` : <https://github.com/culqi/culqi-prestashop/releases/tag/v2.3.2>  

- Baja este repositorio como .zip.
- Descomprime el archivo .zip. Esto debe resultar en una nueva carpeta.
- **¡IMPORTANTE!** Renombra la carpeta a `culqi`.

![Imgur](https://i.imgur.com/dMjMefw.png)

#### 3. Subir el Módulo de Culqi en tu administrador de Prestashop 1.6

##### 3.1
![Imgur](https://i.imgur.com/XjXttCZ.png)

##### 3.2
![Imgur](https://i.imgur.com/woSOBjJ.png)

#### 4. Configurar el Módulo de Culqi en tu administrador de Prestashop 1.6

##### 4.1
![Imgur](https://i.imgur.com/Hsb6I6N.png)

##### 4.2
![Imgur](https://i.imgur.com/Gdu165f.png)

##### 4.3
![Imgur](https://i.imgur.com/jEFeQUu.png)
> Aquí van tus llaves que mencionamos en el paso 1 ( Registrarse en Culqi ).

### Finalmente debes tener a Culqi como pasarela de pago de esta manera:

![Imgur](https://i.imgur.com/c1jWqnh.png)

> Debes usar las tarjetas de prueba que Culqi te ofrece para hacer las pruebas necesarias

`<link>` : <https://culqi.com/docs/#/desarrollo/tarjetas/> 

### Pase a producción:

#### 1. Cumplir con los requisitos técnicos

`<link>` : < https://culqi.com/docs/#/desarrollo/produccion/> 

#### 2. Activar comercio desde tu panel de integración de Culqi

![Imgur](https://i.imgur.com/wVOz6cc.png)

> Si tienes más dudas con respecto al procesos de "Activación de comercio" escríbenos a unete@culqi.com

Cuando te envien los accesos a tu panel de producción de Culqi debes reemplazar
tus llaves de pruebas por tus llaves de producción como en el paso 4.2 

`Llave publica: pk_live_xxxxxxxxxxxxxx`

`Llave privada: sk_live_xxxxxxxxxxxxxx`

> En el ambiente de producción podrás comenzar a usar tarjetas reales.


Si tienes dudas de Integración escríbenos a https://culqi.com/soporte

> El soporte para Prestashop 1.7 esta en el siguiente [repositorio](https://github.com/culqi/culqi-prestashop-1.7)
