<style>
    #woocommerce_culqi_login_button {
        background: #ffffff;
        border: 1px solid #d4d8dd;
        box-sizing: border-box;
        border-radius: 4px;
        display: inline-flex;
        justify-content: center;
        align-items: center;
        padding: 12px 18px;
        margin-left: 20px;
        cursor: pointer;
    }

    #woocommerce_culqi_login_button > div {
        display: flex;
        align-items: center;
    }

    #woocommerce_culqi_login_button span {
        font-family: "Archivo", sans-serif;
        font-style: normal;
        font-weight: 600;
        font-size: 14.22px;
        line-height: 20px;
        color: #3e4b61;
        margin-left: 10px;
    }

    .modal {
        position: fixed;
        top: 0;
        left: 0;
        z-index: 1055;
        display: none;
        width: 100%;
        height: 100%;
        overflow-x: hidden;
        overflow-y: auto;
        outline: 0;
        background: rgba(0,0,0,0.5);
    }

    .modal-dialog {
        position: relative;
        width: auto;
        margin: 0.5rem;
        pointer-events: none;
    }
    .modal.fade .modal-dialog {
        transition: transform 0.3s ease-out;
        transform: translate(0, -50px);
    }
    @media (prefers-reduced-motion: reduce) {
        .modal.fade .modal-dialog {
            transition: none;
        }
    }
    .modal.show .modal-dialog {
        transform: none;
    }

    .modal.modal-static .modal-dialog {
        transform: scale(1.02);
    }

    .modal-dialog-scrollable {
        height: calc(100% - 1rem);
    }
    .modal-dialog-scrollable .modal-content {
        max-height: 100%;
        overflow: hidden;
    }
    .modal-dialog-scrollable .modal-body {
        overflow-y: auto;
    }

    .modal-dialog-centered {
        display: flex;
        align-items: center;
        min-height: calc(100% - 1rem);
    }

    .modal-content {
        position: relative;
        display: flex;
        flex-direction: column;
        width: 100%;
        pointer-events: auto;
        background-color: #fff;
        background-clip: padding-box;
        border: 1px solid rgba(0, 0, 0, 0.2);
        border-radius: 0.3rem;
        outline: 0;
    }

    .modal-backdrop {
        position: fixed;
        top: 0;
        left: 0;
        z-index: 1050;
        width: 100vw;
        height: 100vh;
        background-color: #000;
    }
    .modal-backdrop.fade {
        opacity: 0;
    }
    .modal-backdrop.show {
        opacity: 0.5;
    }

    .modal-header {
        display: flex;
        flex-shrink: 0;
        align-items: center;
        justify-content: space-between;
        padding: 1.5rem 1.5rem 1rem 1.5rem;
        /* border-bottom: 1px solid #dee2e6; */
        border-top-left-radius: calc(0.3rem - 1px);
        border-top-right-radius: calc(0.3rem - 1px);
    }
    .modal-header .btn-close {
        padding: 0.5rem 0.5rem;
        margin: -0.5rem -0.5rem -0.5rem auto;
    }

    .modal-title {
        margin-bottom: 0;
        line-height: 1.5;
    }

    .modal-body {
        position: relative;
        flex: 1 1 auto;
        padding: 0rem 1.5rem;
    }

    .modal-footer {
        display: flex;
        flex-wrap: wrap;
        flex-shrink: 0;
        align-items: center;
        justify-content: flex-end;
        padding: 1.5rem;
        /* border-top: 1px solid #dee2e6; */
        border-bottom-right-radius: calc(0.3rem - 1px);
        border-bottom-left-radius: calc(0.3rem - 1px);
    }
    .modal-footer > * {
        margin: 0.25rem;
    }

    @media (min-width: 576px) {
        .modal-dialog {
            max-width: 500px;
            margin: 1.75rem auto;
        }

        .modal-dialog-scrollable {
            height: calc(100% - 3.5rem);
        }

        .modal-dialog-centered {
            min-height: calc(100% - 3.5rem);
        }

        .modal-sm {
            max-width: 300px;
        }
    }

    .modal-title {
        font-family: "Archivo", sans-serif;
        font-style: normal;
        font-weight: normal;
        font-size: 14.22px;
        line-height: 20px;
        color: #3e4b61;
    }

    .modalListLabel {
        font-family: "Lexend Deca", sans-serif;
        font-style: normal;
        font-weight: normal;
        font-size: 20.25px;
        line-height: 28px;
        text-align: center;
        color: #1f263e;
        text-align: center;
        display: block;
    }

    .modalListDesc {
        font-family: "Archivo", sans-serif;
        font-style: normal;
        font-weight: normal;
        font-size: 14.22px;
        line-height: 20px;
        text-align: center;
        color: #3e4b61;
        display: block;
        max-width: 250px;
        margin: 0 auto;
    }

    .merchant_item {
        background: #ffffff;
        border-bottom: solid 2px #e7e9ec;
        padding: 8px 26px;
        cursor: pointer;
        display: flex;
        align-items: center;
        justify-content: space-between;
    }

    .merchant_logo {
        /* background: #763383; */
        background: #00a19b;
        border-radius: 3px;
        display: flex;
        justify-content: center;
        align-items: center;
        width: 42px;
        height: 42px;
    }

    .merchant_name {
        font-family: "Archivo", sans-serif;
        font-style: normal;
        font-weight: 600;
        font-size: 16px;
        line-height: 24px;
        color: #1f263e;
    }

    .listaselect {
        max-height: 40vh;
        overflow: auto;
    }


    .control-label {
        text-align: left !important;
    }

    .bootstrap label {
        font-weight: normal !important;
    }

    /* OLANDA CSS TOOLTIP */

    #form-culqi-settings tbody th{
    position: relative;
    }

    /*== start of code for tooltips ==*/
    .tool {
    cursor: help;
    padding-left: 10PX;
    position: absolute;
    /* right: 0;  */
    }


    /*== common styles for both parts of tool tip ==*/
    .tool::before,
    .tool::after {
    left: 50%;
    opacity: 0;

    position: absolute;
    z-index: -100;
    }
    .tool::after {
        bottom: 30px!important;
    }

    .tool:hover::before,
    .tool:focus::before,
    .tool:hover::after,
    .tool:focus::after {
    opacity: 1;
    transform: scale(1) translateY(0);
    z-index: 100;
    }


    /*== pointer tip ==*/
    .tool::before {
    border-style: solid;
    border-width: 1em 0.75em 0 0.75em;
    border-color: #3E474F transparent transparent transparent;
    bottom: 100%;
    content: "";
    margin-left: -0.5em;
    transition: all .65s cubic-bezier(.84,-0.18,.31,1.26), opacity .65s .5s;
    transform:  scale(.6) translateY(-90%);
    }

    .tool:hover::before,
    .tool:focus::before {
    transition: all .65s cubic-bezier(.84,-0.18,.31,1.26) .2s;
    }


    /*== speech bubble ==*/
    .tool::after {
    background: #3E474F;
    border-radius: .25em;
    bottom: 180%;
    color: #EDEFF0;
    content: attr(data-tip);
    margin-left: -8.75em;
    padding: 1em;
    transition: all .65s cubic-bezier(.84,-0.18,.31,1.26) .2s;
    transform:  scale(.6) translateY(50%);
    width: 17.5em;
    }

    .tool:hover::after,
    .tool:focus::after  {
    transition: all .65s cubic-bezier(.84,-0.18,.31,1.26);
    }

    @media (max-width: 760px) {
    .tool::after {
        font-size: .75em;
        margin-left: -5em;
        width: 10em;
    }
    }

    /* CSS SWITCH*/

    .can-toggle {
    position: relative;
    }
    .can-toggle *, .can-toggle *:before, .can-toggle *:after {
    box-sizing: border-box;
    }
    .can-toggle input[type=checkbox] {
    opacity: 0;
    position: absolute;
    top: 0;
    left: 0;
    }
    .can-toggle input[type=checkbox][disabled] ~ label {
    pointer-events: none;
    }
    .can-toggle input[type=checkbox][disabled] ~ label .can-toggle__switch {
    opacity: 0.4;
    }
    .can-toggle input[type=checkbox]:checked ~ label .can-toggle__switch:before {
    content: attr(data-unchecked);
    left: 0;
    }
    .can-toggle input[type=checkbox]:checked ~ label .can-toggle__switch:after {
    content: attr(data-checked);
    }
    .can-toggle label {
    -webkit-user-select: none;
        -moz-user-select: none;
        -ms-user-select: none;
            user-select: none;
    position: relative;
    display: flex;
    align-items: center;
    }
    .can-toggle label .can-toggle__label-text {
    flex: 1;
    padding-left: 32px;
    }
    .can-toggle label .can-toggle__switch {
    position: relative;
    }
    .can-toggle label .can-toggle__switch:before {
    content: attr(data-checked);
    position: absolute;
    top: 0;
    text-align: center;
    }
    .can-toggle label .can-toggle__switch:after {
    content: attr(data-unchecked);
    position: absolute;
    z-index: 5;
    text-align: center;
    background: white;
    transform: translate3d(0, 0, 0);
    }
    .can-toggle input[type=checkbox][disabled] ~ label {
    color: rgba(119, 119, 119, 0.5);
    }
    .can-toggle input[type=checkbox]:focus ~ label .can-toggle__switch, .can-toggle input[type=checkbox]:hover ~ label .can-toggle__switch {
    background-color: #777;
    }
    .can-toggle input[type=checkbox]:focus ~ label .can-toggle__switch:after, .can-toggle input[type=checkbox]:hover ~ label .can-toggle__switch:after {
    color: #5e5e5e;
    }
    .can-toggle input[type=checkbox]:hover ~ label {
    color: #6a6a6a;
    }
    .can-toggle input[type=checkbox]:checked ~ label:hover {
    color: #00a19b;
    }
    .can-toggle input[type=checkbox]:checked ~ label .can-toggle__switch {
    background-color: #00a19b;
    }
    .can-toggle input[type=checkbox]:checked ~ label .can-toggle__switch:after {
    color: #00a19b;
    }
    .can-toggle input[type=checkbox]:checked:focus ~ label .can-toggle__switch, .can-toggle input[type=checkbox]:checked:hover ~ label .can-toggle__switch {
    background-color: #00a19b;
    }
    .can-toggle input[type=checkbox]:checked:focus ~ label .can-toggle__switch:after, .can-toggle input[type=checkbox]:checked:hover ~ label .can-toggle__switch:after {
    color: #00a19b;
    }
    .can-toggle label .can-toggle__label-text {
    flex: 1;
    }
    .can-toggle label .can-toggle__switch {
    transition: background-color 0.3s cubic-bezier(0, 1, 0.5, 1);
    background: #848484;
    }
    .can-toggle label .can-toggle__switch:before {
    color: rgba(255, 255, 255, 0.5);
    }
    .can-toggle label .can-toggle__switch:after {
    transition: transform 0.3s cubic-bezier(0, 1, 0.5, 1);
    color: #777;
    }
    .can-toggle input[type=checkbox]:focus ~ label .can-toggle__switch:after, .can-toggle input[type=checkbox]:hover ~ label .can-toggle__switch:after {
    box-shadow: 0 3px 3px rgba(0, 0, 0, 0.4);
    }
    .can-toggle input[type=checkbox]:checked ~ label .can-toggle__switch:after {
    transform: translate3d(65px, 0, 0);
    }
    .can-toggle input[type=checkbox]:checked:focus ~ label .can-toggle__switch:after, .can-toggle input[type=checkbox]:checked:hover ~ label .can-toggle__switch:after {
    box-shadow: 0 3px 3px rgba(0, 0, 0, 0.4);
    }
    .can-toggle label {
    font-size: 14px;
    }
    .can-toggle label .can-toggle__switch {
    height: 36px;
    flex: 0 0 134px;
    border-radius: 4px;
    }
    .can-toggle label .can-toggle__switch:before {
    left: 67px;
    font-size: 12px;
    line-height: 36px;
    width: 67px;
    padding: 0 12px;
    }
    .can-toggle label .can-toggle__switch:after {
    top: 2px;
    left: 2px;
    border-radius: 2px;
    width: 65px;
    line-height: 32px;
    font-size: 12px;
    }
    .can-toggle label .can-toggle__switch:hover:after {
    box-shadow: 0 3px 3px rgba(0, 0, 0, 0.4);
    }

    .can-toggle.can-toggle--size-large input[type=checkbox]:focus ~ label .can-toggle__switch:after, .can-toggle.can-toggle--size-large input[type=checkbox]:hover ~ label .can-toggle__switch:after {
    box-shadow: 0 4px 4px rgba(0, 0, 0, 0.4);
    }
    .can-toggle.can-toggle--size-large input[type=checkbox]:checked ~ label .can-toggle__switch:after {
    transform: translate3d(78px, 0, 0);
    }
    .can-toggle.can-toggle--size-large input[type=checkbox]:checked:focus ~ label .can-toggle__switch:after, .can-toggle.can-toggle--size-large input[type=checkbox]:checked:hover ~ label .can-toggle__switch:after {
    box-shadow: 0 4px 4px rgba(0, 0, 0, 0.4);
    }
    .can-toggle.can-toggle--size-large label {
    font-size: 14px;
    }
    .can-toggle.can-toggle--size-large label .can-toggle__switch {
    height: 50px;
    flex: 0 0 160px;
    border-radius: 4px;
    }
    .can-toggle.can-toggle--size-large label .can-toggle__switch:before {
    left: 80px;
    font-size: 14px;
    line-height: 50px;
    width: 80px;
    padding: 0 12px;
    }
    .can-toggle.can-toggle--size-large label .can-toggle__switch:after {
    top: 2px;
    left: 2px;
    border-radius: 2px;
    width: 78px;
    line-height: 46px;
    font-size: 14px;
    }
    .can-toggle.can-toggle--size-large label .can-toggle__switch:hover:after {
    box-shadow: 0 4px 4px rgba(0, 0, 0, 0.4);
    }



    .can-toggle.demo-rebrand-1 input[type=checkbox][disabled] ~ label {
    color: rgba(181, 62, 116, 0.5);
    }
    .can-toggle.demo-rebrand-1 input[type=checkbox]:focus ~ label .can-toggle__switch, .can-toggle.demo-rebrand-1 input[type=checkbox]:hover ~ label .can-toggle__switch {
    background-color: #777;
    }
    .can-toggle.demo-rebrand-1 input[type=checkbox]:focus ~ label .can-toggle__switch:after, .can-toggle.demo-rebrand-1 input[type=checkbox]:hover ~ label .can-toggle__switch:after {
    color: #777;
    }
    .can-toggle.demo-rebrand-1 input[type=checkbox]:hover ~ label {
    color: #777;
    }
    .can-toggle.demo-rebrand-1 input[type=checkbox]:checked ~ label:hover {
    color: #00a19b;
    }
    .can-toggle.demo-rebrand-1 input[type=checkbox]:checked ~ label .can-toggle__switch {
    background-color: #00a19b;
    }
    .can-toggle.demo-rebrand-1 input[type=checkbox]:checked ~ label .can-toggle__switch:after {
    color: #00a19b;
    }
    .can-toggle.demo-rebrand-1 input[type=checkbox]:checked:focus ~ label .can-toggle__switch, .can-toggle.demo-rebrand-1 input[type=checkbox]:checked:hover ~ label .can-toggle__switch {
    background-color: #00a19b;
    }
    .can-toggle.demo-rebrand-1 input[type=checkbox]:checked:focus ~ label .can-toggle__switch:after, .can-toggle.demo-rebrand-1 input[type=checkbox]:checked:hover ~ label .can-toggle__switch:after {
    color: #00a19b;
    }
    .can-toggle.demo-rebrand-1 label .can-toggle__label-text {
    flex: 1;
    }
    .can-toggle.demo-rebrand-1 label .can-toggle__switch {
    transition: background-color 0.3s ease-in-out;
    background: #777;
    }
    .can-toggle.demo-rebrand-1 label .can-toggle__switch:before {
    color: rgba(255, 255, 255, 0.6);
    }
    .can-toggle.demo-rebrand-1 label .can-toggle__switch:after {
    transition: transform 0.3s ease-in-out;
    color: #777;
    }

</style>

<style>

    .customcheckout li {
    list-style: none;
    }

    .customcheckout hr {
    border: 1px solid #e7e9ec;
    margin: 14px 0;
    }

    .customcheckout input[type="text"],
    .customcheckout input[type="email"],
    .customcheckout input[type="url"],
    .customcheckout input[type="tel"] {
    color: #3e4b61;
    width: 100%;
    border: 1px solid #d4d8dd;
    height: 40px;
    display: block;
    padding: 0.375rem 16px;
    font-size: 14px;
    -webkit-transition: border-color 0.15s ease-in-out;
    transition: border-color 0.15s ease-in-out;
    -webkit-box-sizing: border-box;
    box-sizing: border-box;
    line-height: 1.5;
    border-radius: 4px !important;
    font-family: "Archivo", sans-serif;
    background-color: rgba(0, 0, 0, 0);
    }

    .customcheckout input[type="text"].pointer-none,
    .customcheckout input[type="email"].pointer-none,
    .customcheckout input[type="url"].pointer-none,
    .customcheckout input[type="tel"].pointer-none {
    pointer-events: none;
    -webkit-user-select: none;
    -moz-user-select: none;
    -ms-user-select: none;
    user-select: none;
    }

    .customcheckout input[type="text"].invalid,
    .customcheckout input[type="email"].invalid,
    .customcheckout input[type="url"].invalid,
    .customcheckout input[type="tel"].invalid {
    border-color: #f58585;
    }

    .customcheckout input[type="text"]::-webkit-input-placeholder,
    .customcheckout input[type="email"]::-webkit-input-placeholder,
    .customcheckout input[type="url"]::-webkit-input-placeholder,
    .customcheckout input[type="tel"]::-webkit-input-placeholder {
    color: #b1b8c1;
    }

    .customcheckout input[type="text"]:-ms-input-placeholder,
    .customcheckout input[type="email"]:-ms-input-placeholder,
    .customcheckout input[type="url"]:-ms-input-placeholder,
    .customcheckout input[type="tel"]:-ms-input-placeholder {
    color: #b1b8c1;
    }

    .customcheckout input[type="text"]::-ms-input-placeholder,
    .customcheckout input[type="email"]::-ms-input-placeholder,
    .customcheckout input[type="url"]::-ms-input-placeholder,
    .customcheckout input[type="tel"]::-ms-input-placeholder {
    color: #b1b8c1;
    }

    .customcheckout input[type="text"]::placeholder,
    .customcheckout input[type="email"]::placeholder,
    .customcheckout input[type="url"]::placeholder,
    .customcheckout input[type="tel"]::placeholder {
    color: #b1b8c1;
    }

    .customcheckout input[type="text"]:focus,
    .customcheckout input[type="email"]:focus,
    .customcheckout input[type="url"]:focus,
    .customcheckout input[type="tel"]:focus {
    outline: none;
    -webkit-transition: all 0.15s ease-in-out;
    transition: all 0.15s ease-in-out;
    border-color: #3cb4e5;
    }

    .customcheckout input[type="radio"] {
    -webkit-appearance: none;
    width: 15px;
    height: 15px;
    border: 3px solid #b1b8c1;
    border-radius: 50%;
    position: relative;
    cursor: pointer;
    }

    .customcheckout input[type="radio"]:checked {
    border: 6px solid #3cb4e5;
    }

    .customcheckout select {
    color: #3e4b61;
    width: 100%;
    border: 1px solid #d4d8dd;
    height: 40px;
    display: block;
    padding: 0.375rem 0.75rem;
    font-size: 14px;
    -webkit-transition: border-color 0.15s ease-in-out;
    transition: border-color 0.15s ease-in-out;
    -webkit-box-sizing: border-box;
    box-sizing: border-box;
    line-height: 1.5;
    border-radius: 4px !important;
    font-family: "Archivo", sans-serif;
    background-color: rgba(0, 0, 0, 0);
    cursor: pointer;
    min-width: 100px;
    -webkit-appearance: none;
    -moz-appearance: none;
    appearance: none;
    padding: 0.375rem 1.5rem 0.375rem 0.75rem;
    pointer-events: none;
    }

    .customcheckout .btn {
    display: -webkit-inline-box;
    display: -ms-inline-flexbox;
    display: inline-flex;
    padding: 10px 36px;
    -webkit-box-align: center;
    -ms-flex-align: center;
    align-items: center;
    -webkit-box-pack: center;
    -ms-flex-pack: center;
    justify-content: center;
    text-align: center;
    border: 0;
    text-decoration: none;
    text-transform: initial;
    letter-spacing: 0;
    -webkit-transition: all 0.15s ease-in-out;
    transition: all 0.15s ease-in-out;
    cursor: pointer;
    font-weight: 600;
    font-family: "Archivo", sans-serif;
    font-size: 14px;
    height: 40px;
    color: #888888;
    border-radius: 4px;
    }

    .customcheckout .btn-disabled {
    background-color: #d4d8dd;
    }

    .customcheckout .btn-without-line {
    background: none;
    }

    .customcheckout .btn-save {
    background-color: #00a19b;
    color: #ffffff;
    }

    .customcheckout .btn-save.disabled {
    cursor: default;
    background-color: #d4d8dd;
    color: #b1b8c1;
    }

    .customcheckout .overlay {
    width: 0;
    height: 0;
    position: fixed;
    top: 0;
    left: 0;
    visibility: hidden;
    background: rgba(0, 0, 0, 0.6);
    display: -webkit-box;
    display: -ms-flexbox;
    display: flex;
    -webkit-box-align: center;
    -ms-flex-align: center;
    align-items: center;
    -webkit-box-pack: center;
    -ms-flex-pack: center;
    justify-content: center;
    z-index: 999;
    }

    .customcheckout .overlay.active {
    visibility: visible;
    width: 100%;
    height: 100vh;
    }

    .customcheckout .containerpopup{
    max-width: 1074px;
    min-height: 730px;
    width: 100%;
    background: #ffffff;
    border-radius: 4px;
    overflow: hidden;
    }

    .customcheckout .custom-checkout {
    padding: 20px 0 34px 0;
    }

    .customcheckout .custom-checkout__header {
    border-bottom: 1px solid #e7e9ec;
    display: -webkit-box;
    display: -ms-flexbox;
    display: flex;
    -webkit-box-align: center;
    -ms-flex-align: center;
    align-items: center;
    -webkit-box-pack: justify;
    -ms-flex-pack: justify;
    justify-content: space-between;
    padding: 0 20px 20px;
    }

    .customcheckout .custom-checkout__header-title {
    font-family: "Archivo", sans-serif;
    font-weight: 600;
    font-size: 18px;
    line-height: 28px;
    }

    .customcheckout .custom-checkout__header-close {
    display: -webkit-box;
    display: -ms-flexbox;
    display: flex;
    cursor: pointer;
    -webkit-transition: 0.17s all ease-in;
    transition: 0.17s all ease-in;
    }

    .customcheckout .custom-checkout__header-close:hover {
    -webkit-transform: scale(1.1);
    transform: scale(1.1);
    }

    .customcheckout .custom-checkout__footer {
    display: -webkit-box;
    display: -ms-flexbox;
    display: flex;
    -webkit-box-align: center;
    -ms-flex-align: center;
    align-items: center;
    -webkit-box-pack: end;
    -ms-flex-pack: end;
    justify-content: flex-end;
    padding: 0 60px;
    }

    .customcheckout .custom-checkout__footer .btn {
    padding: 6px 12px;
    }

    .customcheckout .custom-checkout__footer .btn:first-child {
    margin-right: 10px;
    }

    .customcheckout .custom-checkout__footer .btn-without-line:hover {
    color: #000000;
    }

    .customcheckout .custom-checkout__body {
    display: -webkit-box;
    display: -ms-flexbox;
    display: flex;
    width: 100%;
    min-height: 545px;
    padding: 24px 25px;
    -webkit-box-sizing: border-box;
    box-sizing: border-box;
    }

    .customcheckout .custom-checkout__body .content {
    width: 100%;
    display: -webkit-box;
    display: -ms-flexbox;
    display: flex;
    -webkit-box-align: center;
    -ms-flex-align: center;
    align-items: center;
    -webkit-box-pack: justify;
    -ms-flex-pack: justify;
    justify-content: space-between;
    }

    .customcheckout .custom-checkout__body .preview {
    max-width: 576px;
    width: 100%;
    pointer-events: none;
    -webkit-user-select: none;
    -moz-user-select: none;
    -ms-user-select: none;
    user-select: none;
    }

    .customcheckout .custom-checkout__body .preview-checkout {
    border-radius: 4px;
    overflow: hidden;
    width: 100%;
    min-height: 545px;
    -webkit-box-shadow: 0px 8px 12px rgba(9, 30, 66, 0.15), 0px 0px 1px rgba(9, 30, 66, 0.31);
    box-shadow: 0px 8px 12px rgba(9, 30, 66, 0.15), 0px 0px 1px rgba(9, 30, 66, 0.31);
    }

    .customcheckout .custom-checkout__body .preview-checkout__banner {
    width: 100%;
    background-color: #000000;
    height: 52px;
    display: -webkit-box;
    display: -ms-flexbox;
    display: flex;
    padding: 16px;
    -webkit-box-align: center;
    -ms-flex-align: center;
    align-items: center;
    -webkit-box-pack: start;
    -ms-flex-pack: start;
    justify-content: flex-start;
    }

    .customcheckout .custom-checkout__body .preview-checkout__banner .banner-logo {
    background: #ffffff;
    display: -webkit-box;
    display: -ms-flexbox;
    display: flex;
    place-content: center;
    width: 56px;
    height: 56px;
    border-radius: 4px;
    -webkit-transform: translateY(20px);
    transform: translateY(20px);
    padding: 4px;
    }

    .customcheckout .custom-checkout__body .preview-checkout__banner .banner-logo img {
    width: 48px;
    height: 48px;
    padding: 4px;
    border-radius: 3px;
    -webkit-box-shadow: 0px 3px 5px rgba(9, 30, 66, 0.2), 0px 0px 1px rgba(9, 30, 66, 0.31);
    box-shadow: 0px 3px 5px rgba(9, 30, 66, 0.2), 0px 0px 1px rgba(9, 30, 66, 0.31);
    -o-object-fit: contain;
    object-fit: contain;
    }

    .customcheckout .custom-checkout__body .preview-checkout__banner .banner-title {
    color: #ffffff;
    font-family: "Archivo", sans-serif;
    font-weight: 600;
    font-size: 18px;
    line-height: 28px;
    margin-left: 16px;
    }

    .customcheckout .custom-checkout__body .preview-checkout__amount {
    display: -webkit-box;
    display: -ms-flexbox;
    display: flex;
    -webkit-box-align: center;
    -ms-flex-align: center;
    align-items: center;
    -webkit-box-pack: end;
    -ms-flex-pack: end;
    justify-content: flex-end;
    padding: 6px 16px;
    border-bottom: 1px solid #e7e9ec;
    }

    .customcheckout .custom-checkout__body .preview-checkout__amount-contain {
    font-family: "Archivo", sans-serif;
    font-weight: 600;
    font-size: 16px;
    line-height: 24px;
    display: -webkit-box;
    display: -ms-flexbox;
    display: flex;
    -webkit-box-align: center;
    -ms-flex-align: center;
    align-items: center;
    -webkit-box-pack: center;
    -ms-flex-pack: center;
    justify-content: center;
    color: #00a19b;
    }

    .customcheckout .custom-checkout__body .preview-checkout__amount-contain svg {
    margin-left: 9px;
    }

    .customcheckout .custom-checkout__body .preview-checkout__container {
    width: 100%;
    height: 100%;
    display: -webkit-box;
    display: -ms-flexbox;
    display: flex;
    }

    .customcheckout .custom-checkout__body .preview-checkout__container-menu {
    max-width: 224px;
    width: 100%;
    height: 445px;
    border-right: 1px solid #e7e9ec;
    padding: 16px 11px 12px 8px;
    display: -webkit-box;
    display: -ms-flexbox;
    display: flex;
    -webkit-box-orient: vertical;
    -webkit-box-direction: normal;
    -ms-flex-direction: column;
    flex-direction: column;
    -webkit-box-pack: justify;
    -ms-flex-pack: justify;
    justify-content: space-between;
    }

    .customcheckout .custom-checkout__body .preview-checkout__container-menu ul {
    list-style-type: none;
    padding: 0;
    }

    .customcheckout .custom-checkout__body .preview-checkout__container-menu ul li {
    font-family: "Archivo", sans-serif;
    color: #677487;
    font-size: 14.22px;
    font-weight: 600;
    line-height: 20px;
    list-style: none;
    display: -webkit-box;
    display: -ms-flexbox;
    display: flex;
    -webkit-box-align: center;
    -ms-flex-align: center;
    align-items: center;
    position: relative;
    padding-left: 8px;
    margin-bottom: 16px;
    }

    .customcheckout .custom-checkout__body .preview-checkout__container-menu ul li .barra {
    display: block;
    height: 20px;
    width: 2px;
    border-radius: 4px;
    position: absolute;
    left: 0;
    }

    .customcheckout .custom-checkout__body .preview-checkout__container-menu ul li img,
    .customcheckout .custom-checkout__body .preview-checkout__container-menu ul li svg {
    margin-right: 10px;
    }

    .customcheckout .custom-checkout__body .preview-checkout__container-menu-image {
    display: -webkit-box;
    display: -ms-flexbox;
    display: flex;
    margin: 0 auto;
    max-width: 117px;
    }

    .customcheckout .custom-checkout__body .preview-checkout__container-content {
    padding: 24px 20px;
    position: relative;
    width: 100%;
    }

    .customcheckout .custom-checkout__body .preview-checkout__container-content .form-info {
    font-family: "Archivo", sans-serif;
    font-style: normal;
    font-weight: normal;
    font-size: 12px;
    line-height: 16px;
    display: -webkit-box;
    display: -ms-flexbox;
    display: flex;
    position: relative;
    -webkit-box-align: center;
    -ms-flex-align: center;
    align-items: center;
    margin: 0 auto;
    color: #7c7c7c;
    }

    .customcheckout .custom-checkout__body .personalize {
    height: 545px;
    max-width: 400px;
    width: 100%;
    padding: 10px 10px 10px 1px;
    overflow-y: auto;
    }

    .customcheckout .custom-checkout__body .personalize::-webkit-scrollbar {
    width: 16px;
    }

    .customcheckout .custom-checkout__body .personalize::-webkit-scrollbar-track {
    background: #f9f9fa;
    }

    .customcheckout .custom-checkout__body .personalize::-webkit-scrollbar-thumb {
    background-color: #d4d8dd;
    border-radius: 20px;
    border: 3px solid #f9f9fa;
    }

    .customcheckout .custom-checkout__body .personalize .title {
    font-weight: bold;
    font-size: 16px;
    line-height: 24px;
    color: #1f263e;
    }

    .customcheckout .custom-checkout__body .personalize .subtitle {
    font-weight: 600;
    font-size: 12px;
    line-height: 16px;
    color: #3e4b61;
    margin-bottom: 8px;
    }

    .customcheckout .custom-checkout__body .personalize-logotipo {
    margin-bottom: 20px;
    }

    .customcheckout .custom-checkout__body .personalize-logotipo__content {
    margin-top: 35px;
    display: -webkit-box;
    display: -ms-flexbox;
    display: flex;
    -webkit-box-align: center;
    -ms-flex-align: center;
    align-items: center;
    }

    .customcheckout .custom-checkout__body .personalize-logotipo__content .iso-logo {
    width: 220px;
    display: -ms-grid;
    display: grid;
    -ms-grid-columns: 1fr 1fr 1fr;
    grid-template-columns: 1fr 1fr 1fr;
    grid-column-gap: 8px;
    }

    .customcheckout .custom-checkout__body .personalize-logotipo__content .iso-logo__item {
    border: 0.5px solid #e7e9ec;
    width: 68px;
    height: 68px;
    border-radius: 4px;
    position: relative;
    }

    .customcheckout .custom-checkout__body .personalize-logotipo__content .iso-logo__item .check,
    .customcheckout .custom-checkout__body .personalize-logotipo__content .iso-logo__item .errorlogo {
    position: absolute;
    left: 50%;
    -webkit-transform: translate(-50%, -8px);
    transform: translate(-50%, -8px);
    width: 15px;
    height: 15px;
    border-radius: 50%;
    display: -webkit-box;
    display: -ms-flexbox;
    display: flex;
    -webkit-box-align: center;
    -ms-flex-align: center;
    align-items: center;
    -webkit-box-pack: center;
    -ms-flex-pack: center;
    justify-content: center;
    }

    .customcheckout .custom-checkout__body .personalize-logotipo__content .iso-logo__item .check {
    background-color: #499636;
    }

    .customcheckout .custom-checkout__body .personalize-logotipo__content .iso-logo__item .errorlogo {
    background-color: #d20808;
    }

    .customcheckout .custom-checkout__body .personalize-logotipo__content .iso-logo__item .image {
    width: 100%;
    height: 100%;
    display: -webkit-box;
    display: -ms-flexbox;
    display: flex;
    -webkit-box-align: center;
    -ms-flex-align: center;
    align-items: center;
    -webkit-box-pack: center;
    -ms-flex-pack: center;
    justify-content: center;
    }

    .customcheckout .custom-checkout__body .personalize-logotipo__content .iso-logo__item .image img {
    width: 48px;
    height: 48px;
    padding: 4px;
    border-radius: 3px;
    -webkit-box-shadow: 0px 3px 5px rgba(9, 30, 66, 0.2), 0px 0px 1px rgba(9, 30, 66, 0.31);
    box-shadow: 0px 3px 5px rgba(9, 30, 66, 0.2), 0px 0px 1px rgba(9, 30, 66, 0.31);
    -o-object-fit: contain;
    object-fit: contain;
    }

    .customcheckout .custom-checkout__body .personalize-logotipo__content .detail-logo {
    margin-left: 11px;
    padding-left: 16px;
    }

    .customcheckout .custom-checkout__body .personalize-logotipo__content .detail-logo__list {
    font-family: "Archivo", sans-serif;
    font-style: normal;
    font-weight: normal;
    font-size: 12px;
    line-height: 16px;
    display: -webkit-box;
    display: -ms-flexbox;
    display: flex;
    -webkit-box-align: center;
    -ms-flex-align: center;
    align-items: center;
    color: #677487;
    margin-bottom: 4px;
    position: relative;
    }

    .customcheckout .custom-checkout__body .personalize-logotipo__content .detail-logo__list svg {
    position: absolute;
    left: -16px;
    top: 50%;
    -webkit-transform: translateY(-50%);
    transform: translateY(-50%);
    }

    .customcheckout .custom-checkout__body .personalize-url .form__group label {
    margin-top: 4px;
    font-size: 11.24px;
    line-height: 16px;
    color: #677487;
    }

    .customcheckout .custom-checkout__body .personalize-color .paragraph {
    font-size: 14.22px;
    line-height: 20px;
    color: #3e4b61;
    }

    .customcheckout .custom-checkout__body .personalize-color__content-item {
    margin-bottom: 20px;
    }

    .customcheckout .custom-checkout__body .personalize-color__content-item .action-visible {
    font-weight: 600;
    font-size: 12px;
    line-height: 16px;
    color: #3cb4e5;
    display: -webkit-box;
    display: -ms-flexbox;
    display: flex;
    -webkit-box-align: center;
    -ms-flex-align: center;
    align-items: center;
    cursor: pointer;
    }

    .customcheckout .custom-checkout__body .personalize-color__content-item .action-visible svg {
    margin-right: 6px;
    -webkit-transition: 0.5s all ease;
    transition: 0.5s all ease;
    }

    .customcheckout .custom-checkout__body .personalize-color__content-item .action-visible svg.rotate {
    -webkit-transform: rotate(180deg);
    transform: rotate(180deg);
    }

    .customcheckout .custom-checkout__body .personalize-color__content-item .action-container {
    margin-top: 19px;
    height: 0;
    -webkit-transition: 0.5s all ease-in;
    transition: 0.5s all ease-in;
    visibility: hidden;
    }

    .customcheckout .custom-checkout__body .personalize-color__content-item .action-container .color-palette,
    .customcheckout .custom-checkout__body .personalize-color__content-item .action-container .subtitle {
    display: none;
    }

    .customcheckout .custom-checkout__body .personalize-color__content-item .action-container.active {
    height: auto;
    visibility: visible;
    }

    .customcheckout .custom-checkout__body .personalize-color__content-item .action-container.active .color-palette,
    .customcheckout .custom-checkout__body .personalize-color__content-item .action-container.active .subtitle {
    display: -ms-grid;
    display: grid;
    }

    .customcheckout .custom-checkout__body .personalize-color__content-item .color-palette {
    display: -ms-grid;
    display: grid;
    -ms-grid-columns: (minmax(84px, 84px)) [ auto-fill ];
    grid-template-columns: repeat(auto-fill, minmax(84px, 84px));
    grid-column-gap: 12px;
    -ms-grid-rows: (minmax(42px, 1fr)) [ auto-fill ];
    grid-template-rows: repeat(auto-fill, minmax(42px, 1fr));
    grid-row-gap: 12px;
    }

    .customcheckout .custom-checkout__body .personalize-color__content-item .color-palette__item {
    -webkit-box-shadow: 0px 1px 3px rgba(9, 30, 66, 0.2), 0px 0px 1px rgba(9, 30, 66, 0.31);
    box-shadow: 0px 1px 3px rgba(9, 30, 66, 0.2), 0px 0px 1px rgba(9, 30, 66, 0.31);
    border-radius: 4px;
    padding: 6px 12px;
    display: -webkit-box;
    display: -ms-flexbox;
    display: flex;
    -webkit-box-align: center;
    -ms-flex-align: center;
    align-items: center;
    -webkit-box-pack: justify;
    -ms-flex-pack: justify;
    justify-content: space-between;
    }

    .customcheckout .custom-checkout__body .personalize-color__content-item .color-palette__item label {
    width: 30px;
    height: 30px;
    position: relative;
    cursor: pointer;
    }

    .customcheckout .custom-checkout__body .personalize-color__content-item .color-palette__item label .color-container {
    display: -webkit-box;
    display: -ms-flexbox;
    display: flex;
    }

    .customcheckout .custom-checkout__body .personalize-color__content-item .color-palette__item label .color-container__left {
    width: 15px;
    height: 28px;
    border-radius: 100px 0 0 100px;
    }

    .customcheckout .custom-checkout__body .personalize-color__content-item .color-palette__item label .color-container__right {
    width: 15px;
    height: 28px;
    border-radius: 0 100px 100px 0;
    }

    .customcheckout .form {
    display: -ms-grid;
    display: grid;
    width: 100%;
    max-width: 312px;
    -ms-grid-columns: 1fr 1fr;
    grid-template-columns: 1fr 1fr;
    -ms-grid-rows: auto;
    grid-template-rows: auto;
    background-color: inherit;
    }

    .customcheckout .form label {
    font-family: "Archivo", sans-serif;
    font-weight: bold;
    margin-bottom: 4px;
    line-height: 16px;
    color: #677487;
    font-size: 12px;
    letter-spacing: normal;
    }

    .customcheckout .form__group {
    display: -webkit-box;
    display: -ms-flexbox;
    display: flex;
    -webkit-box-orient: vertical;
    -webkit-box-direction: normal;
    -ms-flex-direction: column;
    flex-direction: column;
    margin-bottom: 20px;
    position: relative;
    }

    .customcheckout .form__group-input {
    position: relative;
    }

    .customcheckout .form__group__select {
    position: relative;
    pointer-events: none;
    }

    .customcheckout .form__group__select::before {
    content: url("https://culqi-static-files.s3.amazonaws.com/v3/v3-checkout/icons/arrow_down.svg");
    position: absolute;
    top: 50%;
    -webkit-transform: translateY(-50%);
    transform: translateY(-50%);
    bottom: 0;
    right: 15px;
    pointer-events: none;
    -webkit-transition: 0.5s all;
    transition: 0.5s all;
    }

    .customcheckout .form__row {
    display: -webkit-box;
    display: -ms-flexbox;
    display: flex;
    -ms-flex-wrap: wrap;
    flex-wrap: wrap;
    width: 100%;
    -webkit-box-orient: vertical;
    -webkit-box-direction: normal;
    -ms-flex-direction: column;
    flex-direction: column;
    }

    .customcheckout .form__row__col {
    -ms-flex-preferred-size: 0;
    flex-basis: 0;
    -webkit-box-flex: 1;
    -ms-flex-positive: 1;
    flex-grow: 1;
    max-width: 100%;
    }

    .customcheckout .form__row__col.right {
    padding-left: 10px;
    }

    .customcheckout .form__row__col.left {
    padding-right: 10px;
    }

    .customcheckout .form .dobble {
    -ms-grid-column: 1;
    -ms-grid-column-span: 2;
    grid-column: 1 / span 2;
    }

    .customcheckout .form .dobble .form__row__col {
    padding-right: 0;
    padding-left: 0;
    }

    .customcheckout .form .brand {
    height: 20px;
    width: 30px;
    border-radius: 2px;
    position: absolute;
    top: 50%;
    right: 20px;
    -webkit-transform: translateY(-50%);
    transform: translateY(-50%);
    background-size: cover;
    background-position: center;
    background-repeat: no-repeat;
    background-size: contain;
    background-image: url(https://culqi-static-files.s3.amazonaws.com/v3/v3-checkout/logos/red-service/visa.png);
    }

    @media screen and (max-width: 782px){
        .customcheckout{
        }
    }

    .can-toggle label .can-toggle__switch:before{
        content: none!important
    }

    #contact-popup {
        position: fixed;
        top: 0px;
        left: 0px;
        height: 100%;
        width: 100%;
        color: #676767;
        z-index: 999;
        background: rgba(0,0,0,0.7);
    }

    .contact-form {
        width: 370px;
        margin: 0px;
        background-color: white;
        font-family: Arial;
        position: relative;
        left: 50%;
        top: 60%;
        margin-left: -210px;
        margin-top: -255px;
        box-shadow: 1px 1px 5px #444444;
        padding: 20px 40px 40px 40px;
    }

    #contact-icon {
        padding: 10px 5px 5px 12px;
        width: 58px;
        color: white;
        box-shadow: 1px 1px 5px grey;
        border-radius: 3px;
        cursor: pointer;
        margin: 60px auto;
    }

    .info {
        color: #d30a0a;
        letter-spacing: 2px;
        padding-left: 5px;
    }

    #send {
        background-color: #29A19B;
        border: 1px solid #29A19B;
        color: white;
        width: 100%;
        padding: 10px;
        cursor: pointer;
    }

    #contact-popup h1 {
        font-weight: normal;
        text-align: center;
        margin: 10px 0px 20px 0px;
        font-size: 20px;
        text-align: center;
    }
    #contact-popup p {
        font-size: 14px;
        text-align: center;
    }
    #contact-popup div {
        text-align: center;
    }

    .bootstrap input[type="number"]{
        display: block;
        width: 100%;
        height: 31px;
        padding: 6px 8px;
        font-size: 12px;
        line-height: 1.42857;
        color: #555;
        background-color: #F5F8F9;
        background-image: none;
        border: 1px solid #C7D6DB;
        border-radius: 3px;
        -webkit-transition: border-color ease-in-out 0.15s,box-shadow ease-in-out 0.15s;
        -o-transition: border-color ease-in-out 0.15s,box-shadow ease-in-out 0.15s;
        transition: border-color ease-in-out 0.15s,box-shadow ease-in-out 0.15s;
        font-family: "Open Sans",Helvetica,Arial,sans-serif,"FontAwesome" !important;
        cursor: not-allowed;
        background-color: #eee;
        opacity: 1;
    }

</style>

<link rel="stylesheet" href="{$module_dir|escape:'htmlall':'UTF-8'}views/css/waitMe.min.css" type="text/css" media="all">

<div id="contact-popup" style="display: none">
    <form class="contact-form" action="" id="contact-form"
          method="post" enctype="multipart/form-data">
        <div>
            <div>
                <img src="https://psculqi.purpura.pe/modules/culqi/views/img/icon-check.png" />
            </div>
            <div>
                <h1>¡Configuración registrada<br/> con éxito!</h1>
            </div>
            <div>
                <p>La configuración de tu Culqi checkout se ha<br/> registrado satisfactoriamente</p>
            </div>
        </div>
        <div>
            <input onclick="const element = document.getElementById('contact-popup'); element.remove();" id="send" type="button" value="Ok">
        </div>
    </form>
</div>

    <form id="module_form" class="defaultForm form-horizontal" action="{$currentIndex|escape:'htmlall':'UTF-8'}&amp;token={$token|escape:'htmlall':'UTF-8'}" method="post" enctype="multipart/form-data" novalidate="">
	    <input type="hidden" name="btnSubmit" value="1">

	    <div class="panel" id="fieldset_0">
            <div class="panel-heading">
			    <i class="icon-money"></i>CONFIGURACIONES GENERALES CULQI
			</div>

			<div class="form-wrapper">

                <div class="form-group">
                    <label class="control-label col-lg-4" style="font-weight: bold !important;">
						Culqi Checkout
					</label>
					<div class="col-lg-8 can-toggle demo-rebrand-1">
						<input id="d" type="checkbox" name="CULQI_ENABLED" value="yes" {$status_enabled|escape:'htmlall':'UTF-8'} >
						<label for="d">
							<div class="can-toggle__switch" data-checked="Activo" data-unchecked="Inactivo"></div>
						</label>
					</div>
				</div>



                <div class="form-group">
					<label class="control-label col-lg-4" style="font-weight: bold !important;">
						Elige el entorno donde activarás tu checkout
					</label>
					<div class="col-lg-8" style="padding-top: 8px">
						<input {$fields_value.CULQI_CHECKED_INTEG|escape:'htmlall':'UTF-8'} type="radio" name="CULQI_ENVIROMENT" value="integ" id="integracion"> <label for="integracion">Integración</label>
                        <input {$fields_value.CULQI_CHECKED_PROD|escape:'htmlall':'UTF-8'} style="margin-left: 25px" type="radio" name="CULQI_ENVIROMENT" value="prod" id="produccion"> <label for="produccion"> Producción</label>
					</div>
				</div>

                <div class="form-group logincontainer">
                    <label class="control-label col-lg-4" style="font-weight: bold !important;">
                        ¡Ahorra tiempo configurando tu Culqi checkout! Inicia sesión con tu cuenta de CulqiPanel
                    </label>
                    <div class="col-lg-8">
                        <button id="pretashop_culqi_login_button" type="button" class="btnlogin" data-toggle="modal" data-target="#modalLogin" onclick="jQuery('#errorlogin').html(''); " style="padding: 10px 20px">
                            <div style="display: inherit; vertical-align: middle">
                                <svg style="width: 16px!important; height: 16px!important" viewBox="0 0 16 16" fill="none" xmlns="http://www.w3.org/2000/svg" style="margin-bottom: -4px; margin-right: 5px">
                                    <path d="M7.99463 8.66086C6.58697 8.66086 5.44795 7.52184 5.44795 6.11418C5.44795 4.70653 6.59772 3.55676 8.00537 3.55676C9.41303 3.55676 10.5628 4.70653 10.5628 6.11418C10.5628 7.52184 9.40228 8.66086 7.99463 8.66086ZM7.99463 4.95367C7.36065 4.95367 6.83412 5.46946 6.83412 6.11418C6.83412 6.75891 7.3499 7.27469 7.99463 7.27469C8.63936 7.27469 9.15514 6.75891 9.15514 6.11418C9.15514 5.46946 8.63936 4.95367 7.99463 4.95367Z" fill="#3E4B61"/>
                                    <path d="M7.99463 0C3.58899 0 0 3.58899 0 7.99463C0 9.75688 0.580255 11.3902 1.54735 12.7119C1.83747 13.1095 2.17058 13.4856 2.53593 13.8294C3.96508 15.1726 5.88852 16 7.99463 16C10.1007 16 12.0242 15.1726 13.4533 13.8294C13.8187 13.4856 14.1518 13.1202 14.4419 12.7119C15.409 11.3902 15.9893 9.75688 15.9893 7.99463C16 3.58899 12.411 0 7.99463 0ZM7.99463 14.6568C6.14641 14.6568 4.47011 13.8939 3.25588 12.6689C4.36266 11.272 6.07119 10.3801 7.99463 10.3801C9.90732 10.3801 11.6159 11.272 12.7334 12.6689C11.5299 13.8939 9.85359 14.6568 7.99463 14.6568ZM13.6145 11.5621C12.2498 9.98254 10.2404 8.98321 7.99463 8.98321C5.74883 8.98321 3.73942 9.98254 2.37475 11.5514C1.71927 10.5306 1.34318 9.30557 1.34318 7.99463C1.34318 4.31968 4.33042 1.33244 8.00537 1.33244C11.6803 1.33244 14.6676 4.31968 14.6676 7.99463C14.6568 9.30557 14.27 10.5306 13.6145 11.5621Z" fill="#3E4B61"/>
                                </svg>
                            </div>
                            <span>Iniciar Sesión</span>
                        </button>
                    </div>
                </div>

				<div class="form-group">
					<label class="control-label col-lg-4" style="font-weight: bold !important;">
						Llave Pública

                        <span class="tool" data-tip="Encuentra tu llave pública ingresando a la sección Desarrollo en tu Culqipanel, en la pestaña de API Keys" tabindex="2" style=" font-weight: normal;">

                        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-question-circle-fill" viewBox="0 0 16 16">
			            <path d="M16 8A8 8 0 1 1 0 8a8 8 0 0 1 16 0zM5.496 6.033h.825c.138 0 .248-.113.266-.25.09-.656.54-1.134 1.342-1.134.686 0 1.314.343 1.314 1.168 0 .635-.374.927-.965 1.371-.673.489-1.206 1.06-1.168 1.987l.003.217a.25.25 0 0 0 .25.246h.811a.25.25 0 0 0 .25-.25v-.105c0-.718.273-.927 1.01-1.486.609-.463 1.244-.977 1.244-2.056 0-1.511-1.276-2.241-2.673-2.241-1.267 0-2.655.59-2.75 2.286a.237.237 0 0 0 .241.247zm2.325 6.443c.61 0 1.029-.394 1.029-.927 0-.552-.42-.94-1.029-.94-.584 0-1.009.388-1.009.94 0 .533.425.927 1.01.927z"/> </svg> 
                        
                        </span>

					</label>
					<div class="col-lg-8">
                        <input type="hidden" id="CULQI_TOKENLOGIN" />
						<input required="true" type="text" name="CULQI_LLAVE_PUBLICA" id="CULQI_LLAVE_PUBLICA" value="{$fields_value.CULQI_LLAVE_PUBLICA|escape:'htmlall':'UTF-8'}" class="">
                        <span id="errorpubkey" class="form-text text-muted" style="display: none; color: red; font-size: 0.8rem !important;">La llave pública no pertenece al ambiente de producción</span>
                        <span class="form-text text-muted"> Ingresa tu llave pública. </span>
					</div>
				</div>

				<div class="form-group">
					<label class="control-label col-lg-4" style="font-weight: bold !important;">
						Llave Privada

                        <span class="tool" data-tip="Encuentra tu llave privada ingresando a la sección Desarrollo en tu Culqipanel, en la pestaña de API Keys" tabindex="2" style=" font-weight: normal;">

                        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-question-circle-fill" viewBox="0 0 16 16">
			            <path d="M16 8A8 8 0 1 1 0 8a8 8 0 0 1 16 0zM5.496 6.033h.825c.138 0 .248-.113.266-.25.09-.656.54-1.134 1.342-1.134.686 0 1.314.343 1.314 1.168 0 .635-.374.927-.965 1.371-.673.489-1.206 1.06-1.168 1.987l.003.217a.25.25 0 0 0 .25.246h.811a.25.25 0 0 0 .25-.25v-.105c0-.718.273-.927 1.01-1.486.609-.463 1.244-.977 1.244-2.056 0-1.511-1.276-2.241-2.673-2.241-1.267 0-2.655.59-2.75 2.286a.237.237 0 0 0 .241.247zm2.325 6.443c.61 0 1.029-.394 1.029-.927 0-.552-.42-.94-1.029-.94-.584 0-1.009.388-1.009.94 0 .533.425.927 1.01.927z"/> </svg>

                        </span>

					</label>
					<div class="col-lg-8">
						<input required="true" type="text" name="CULQI_LLAVE_SECRETA" id="CULQI_LLAVE_SECRETA" value="{$fields_value.CULQI_LLAVE_SECRETA|escape:'htmlall':'UTF-8'}" class="">
                        <span id="errorseckey" class="form-text text-muted" style="display: none; color: red; font-size: 0.8rem !important;">La llave privada no pertenece al ambiente de producción</span>
                        <span class="form-text text-muted"> Ingresa tu llave privada. </span>
					</div>
				</div>

				<div class="form-group">
					<label class="control-label col-lg-4" style="font-weight: bold !important;">
						Métodos de pago
					</label>
					<div class="col-lg-8">
						<div class="checkbox">
							<label for="CULQI_METHODS_TARJETA"><input type="checkbox" name="CULQI_METHODS_TARJETA" id="CULQI_METHODS_TARJETA" class="" value="yes" {$status_methods_tarjeta_enabled|escape:'htmlall':'UTF-8'}> Tarjetas débito/credito</label>
						</div>
						<div class="checkbox">
							<label for="CULQI_METHODS_BANCAMOVIL"><input type="checkbox" name="CULQI_METHODS_BANCAMOVIL" id="CULQI_METHODS_BANCAMOVIL" class="" value="yes" {$status_methods_bancamovil_enabled|escape:'htmlall':'UTF-8'}>Banca móvil o internet</label>
						</div>
						<div class="checkbox">
							<label for="CULQI_METHODS_AGENTS"><input type="checkbox" name="CULQI_METHODS_AGENTS" id="CULQI_METHODS_AGENTS" class="" value="yes" {$status_methods_agents_enabled|escape:'htmlall':'UTF-8'}>Agentes y bodegas</label>
						</div>
						<div class="checkbox">
							<label for="CULQI_METHODS_WALLETS"><input type="checkbox" name="CULQI_METHODS_WALLETS" id="CULQI_METHODS_WALLETS" class="" value="yes" {$status_methods_wallets_enabled|escape:'htmlall':'UTF-8'}>Billeteras móviles</label>
                            <span class="tool" data-tip="Tus clientes pueden pagar con Yape, Plin y las principales billeteras móviles del país." tabindex="2">
			                <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-question-circle-fill" viewBox="0 0 16 16">
			                <path d="M16 8A8 8 0 1 1 0 8a8 8 0 0 1 16 0zM5.496 6.033h.825c.138 0 .248-.113.266-.25.09-.656.54-1.134 1.342-1.134.686 0 1.314.343 1.314 1.168 0 .635-.374.927-.965 1.371-.673.489-1.206 1.06-1.168 1.987l.003.217a.25.25 0 0 0 .25.246h.811a.25.25 0 0 0 .25-.25v-.105c0-.718.273-.927 1.01-1.486.609-.463 1.244-.977 1.244-2.056 0-1.511-1.276-2.241-2.673-2.241-1.267 0-2.655.59-2.75 2.286a.237.237 0 0 0 .241.247zm2.325 6.443c.61 0 1.029-.394 1.029-.927 0-.552-.42-.94-1.029-.94-.584 0-1.009.388-1.009.94 0 .533.425.927 1.01.927z"/></svg>
		                    </span>
						</div>
						<div class="checkbox">
							<label for="CULQI_METHODS_QUOTEBCP"><input type="checkbox" name="CULQI_METHODS_QUOTEBCP" id="CULQI_METHODS_QUOTEBCP" class="" value="yes" {$status_methods_quotebcp_enabled|escape:'htmlall':'UTF-8'}>Cuotéalo BCP</label>
                            <span class="tool" data-tip="Paga en cuotas y sin tarjetas de crédito con Cuotéalo" tabindex="2">
			                <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-question-circle-fill" viewBox="0 0 16 16">
			                <path d="M16 8A8 8 0 1 1 0 8a8 8 0 0 1 16 0zM5.496 6.033h.825c.138 0 .248-.113.266-.25.09-.656.54-1.134 1.342-1.134.686 0 1.314.343 1.314 1.168 0 .635-.374.927-.965 1.371-.673.489-1.206 1.06-1.168 1.987l.003.217a.25.25 0 0 0 .25.246h.811a.25.25 0 0 0 .25-.25v-.105c0-.718.273-.927 1.01-1.486.609-.463 1.244-.977 1.244-2.056 0-1.511-1.276-2.241-2.673-2.241-1.267 0-2.655.59-2.75 2.286a.237.237 0 0 0 .241.247zm2.325 6.443c.61 0 1.029-.394 1.029-.927 0-.552-.42-.94-1.029-.94-.584 0-1.009.388-1.009.94 0 .533.425.927 1.01.927z"/></svg>
		                    </span>
						</div>
					</div>
				</div>

				<div class="form-group">
					<label class="control-label col-lg-4" style="font-weight: bold !important;">
					    Tiempo de expiración de pago
					</label>
					<div class="col-lg-8">
						<input type="number" name="CULQI_TIMEXP" id="CULQI_TIMEXP" value="{$fields_value.CULQI_TIMEXP|escape:'htmlall':'UTF-8'}" class="">
                        <span id="errortimeexp" class="form-text text-muted" style="display: none; color: red; font-size: 0.8rem !important;">El tiempo de expiración debe ser un valor numérico, mayor a 0 y no mayor a 10 dígitos.</span>
                        <span class="form-text text-muted"> Ingresar el número de horas que tendrá el cliente para pagar su orden. Ejem: 24</span>
					</div>
				</div>

				<div class="form-group">
					<label class="control-label col-lg-4" style="font-weight: bold !important;">
						Notificaciones de pagos

                        <span class="tool" data-tip="Ingresa a tu Culqipanel en la sección de eventos, hacer clic a +Añadir. Se abrirá un popup, en donde deberás escoger order.status.changed y pegar la siguiente URL" tabindex="2" style=" font-weight: normal;">

                        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-question-circle-fill" viewBox="0 0 16 16">
			            <path d="M16 8A8 8 0 1 1 0 8a8 8 0 0 1 16 0zM5.496 6.033h.825c.138 0 .248-.113.266-.25.09-.656.54-1.134 1.342-1.134.686 0 1.314.343 1.314 1.168 0 .635-.374.927-.965 1.371-.673.489-1.206 1.06-1.168 1.987l.003.217a.25.25 0 0 0 .25.246h.811a.25.25 0 0 0 .25-.25v-.105c0-.718.273-.927 1.01-1.486.609-.463 1.244-.977 1.244-2.056 0-1.511-1.276-2.241-2.673-2.241-1.267 0-2.655.59-2.75 2.286a.237.237 0 0 0 .241.247zm2.325 6.443c.61 0 1.029-.394 1.029-.927 0-.552-.42-.94-1.029-.94-.584 0-1.009.388-1.009.94 0 .533.425.927 1.01.927z"/> </svg>

                        </span>

					</label>
					<div class="col-lg-8">
						<input type="text" name="CULQI_NOTPAY" id="CULQI_NOTPAY" value="{$fields_value.CULQI_URL_WEBHOOK_PS|escape:'htmlall':'UTF-8'}" readonly="true" class="">
                        <span class="form-text text-muted"> Si no iniciaste sesión con tu cuenta de Culqi Panel, tienes que configurar esta URL.</span>
					</div>
				</div>

                <div class="form-group customcheckout">
					<label class="control-label col-lg-4" style="font-weight: bold !important;">
						Personalizar formulario de checkout
					</label>
					<div class="col-lg-8">
						<div class="">
                            <div class="container" style="justify-content: center; margin: auto;">
                                <input value="Personalizar" type="button" class="btn btn-save" id="open-modal">
                            </div>
                            <div class="overlay" id="overlay">
                                <div class="container containerpopup" style="transform: scale(0.8)">
                                    <div class="custom-checkout">
                                        <div class="custom-checkout__header">
                                            <div class="custom-checkout__header-title">Personalización</div>
                                            <div class="custom-checkout__header-close" id="btn-close">
                                                <img src="https://culqi-static-files.s3.amazonaws.com/v3/v3-checkout/icons/close-black.svg" alt="close">
                                            </div>
                                        </div>
                                        <div class="custom-checkout__body">
                                            <div class="content">
                                                <div class="preview">
                                                    <div class="preview-checkout">
                                                        <div class="preview-checkout__banner" id="palette-left">
                                                            <div class="banner-logo">
                                                                <img id="logo" src="https://culqi-static-files.s3.amazonaws.com/v3/v3-checkout/brand.svg" alt="logo">
                                                            </div>
                                                            <div class="banner-title">
                                                                {$fields_value.commerce|escape:'htmlall':'UTF-8'}
                                                            </div>
                                                        </div>
                                                        <div class="preview-checkout__amount">
                                                            <div class="preview-checkout__amount-contain">
                                                                <span id="palette-right" name="color">S/ 350.00</span>
                                                                <svg style="width: 20px!important; height: 20px!important" width="20" height="20" viewBox="0 0 20 20" fill="none" xmlns="http://www.w3.org/2000/svg">
                                                                    <path id="palette-right" name="svg" d="M18.3335 1.66663H1.66683C1.44582 1.66663 1.23385 1.75442 1.07757 1.9107C0.921293 2.06698 0.833496 2.27895 0.833496 2.49996V9.16663C0.833496 9.38764 0.921293 9.5996 1.07757 9.75588C1.23385 9.91216 1.44582 9.99996 1.66683 9.99996H4.16683V17.5C4.16683 17.721 4.25463 17.9329 4.41091 18.0892C4.56719 18.2455 4.77915 18.3333 5.00016 18.3333H15.0002C15.2212 18.3333 15.4331 18.2455 15.5894 18.0892C15.7457 17.9329 15.8335 17.721 15.8335 17.5V9.99996H18.3335C18.5545 9.99996 18.7665 9.91216 18.9228 9.75588C19.079 9.5996 19.1668 9.38764 19.1668 9.16663V2.49996C19.1668 2.27895 19.079 2.06698 18.9228 1.9107C18.7665 1.75442 18.5545 1.66663 18.3335 1.66663ZM5.8335 16.6666V15C6.27552 15 6.69945 15.1756 7.01201 15.4881C7.32457 15.8007 7.50016 16.2246 7.50016 16.6666H5.8335ZM14.1668 16.6666H12.5002C12.5002 16.2246 12.6758 15.8007 12.9883 15.4881C13.3009 15.1756 13.7248 15 14.1668 15V16.6666ZM14.1668 13.3333C13.2828 13.3333 12.4349 13.6845 11.8098 14.3096C11.1847 14.9347 10.8335 15.7826 10.8335 16.6666H9.16683C9.16683 15.7826 8.81564 14.9347 8.19052 14.3096C7.5654 13.6845 6.71755 13.3333 5.8335 13.3333V6.66663H14.1668V13.3333ZM17.5002 8.33329H15.8335V5.83329C15.8335 5.61228 15.7457 5.40032 15.5894 5.24404C15.4331 5.08776 15.2212 4.99996 15.0002 4.99996H5.00016C4.77915 4.99996 4.56719 5.08776 4.41091 5.24404C4.25463 5.40032 4.16683 5.61228 4.16683 5.83329V8.33329H2.50016V3.33329H17.5002V8.33329ZM10.0002 12.5C10.4946 12.5 10.978 12.3533 11.3891 12.0786C11.8002 11.8039 12.1206 11.4135 12.3099 10.9567C12.4991 10.4999 12.5486 9.99719 12.4521 9.51223C12.3557 9.02728 12.1176 8.58182 11.7679 8.23219C11.4183 7.88256 10.9728 7.64446 10.4879 7.548C10.0029 7.45153 9.50027 7.50104 9.04345 7.69026C8.58664 7.87948 8.19619 8.19991 7.92149 8.61103C7.64678 9.02216 7.50016 9.50551 7.50016 9.99996C7.50016 10.663 7.76355 11.2989 8.23239 11.7677C8.70124 12.2366 9.33712 12.5 10.0002 12.5ZM10.0002 9.16663C10.165 9.16663 10.3261 9.2155 10.4631 9.30707C10.6002 9.39864 10.707 9.52878 10.7701 9.68106C10.8331 9.83333 10.8496 10.0009 10.8175 10.1625C10.7853 10.3242 10.706 10.4727 10.5894 10.5892C10.4729 10.7058 10.3244 10.7851 10.1627 10.8173C10.0011 10.8494 9.83353 10.8329 9.68126 10.7699C9.52899 10.7068 9.39884 10.6 9.30727 10.4629C9.2157 10.3259 9.16683 10.1648 9.16683 9.99996C9.16683 9.77895 9.25463 9.56698 9.41091 9.4107C9.56719 9.25442 9.77915 9.16663 10.0002 9.16663Z" fill="#00A19B"></path>
                                                                </svg>

                                                            </div>
                                                        </div>
                                                        <div class="preview-checkout__container">
                                                            <div class="preview-checkout__container-menu">
                                                                <ul>
                                                                    <li id="palette-right" name="color">
                                                                    <span class="barra" id="palette-right" name="bg"></span>
                                                                        <svg style="width: 20px!important; height: 20px!important" width="20" height="20" viewBox="0 0 20 20" fill="none" xmlns="http://www.w3.org/2000/svg">
                                                                            <g clip-path="url(#clip0_478_2813)">
                                                                                <path fill-rule="evenodd" clip-rule="evenodd" id="palette-right" name="svg" d="M3.94475 4.5H16.0552C17.0276 4.5 17.9116 5.38 18 6.436V13.564C18 14.62 17.116 15.5 16.0552 15.5H3.94475C2.88398 15.5 2 14.62 2 13.564V6.436C2 5.38 2.88398 4.5 3.94475 4.5ZM16.0552 5.644H3.94475C3.50276 5.644 3.14917 5.996 3.14917 6.436V6.964H16.8508V6.436C16.8508 5.996 16.4972 5.644 16.0552 5.644ZM3.94475 14.268H16.0552C16.4088 14.268 16.7624 13.916 16.7624 13.564V8.108H3.14917V13.476C3.14917 13.916 3.50276 14.268 3.94475 14.268ZM4.20989 11.892H6.68503V13.036H4.20989V11.892Z" fill="#00A19B"></path>
                                                                            </g>
                                                                            <defs>
                                                                                <clipPath id="clip0_478_2813">
                                                                                    <rect width="16" height="11" fill="white" transform="translate(2 4.5)"></rect>
                                                                                </clipPath>
                                                                            </defs>
                                                                        </svg>
                                                                        Tarjeta débito / crédito
                                                                    </li>
                                                                    <li>
                                                                        <img src="https://culqi-static-files.s3.amazonaws.com/v3/v3-checkout/icons/online-banking.svg" alt="icon">
                                                                        Banca móvil o internet
                                                                    </li>
                                                                    <li>
                                                                        <img src="https://culqi-static-files.s3.amazonaws.com/v3/v3-checkout/icons/agents.svg" alt="icon">
                                                                        Agentes y bodegas
                                                                    </li>
                                                                    <li>
                                                                        <img src="https://culqi-static-files.s3.amazonaws.com/v3/v3-checkout/icons/banca-movil.svg" alt="icon">

                                                                        Billeteras móviles
                                                                    </li>
                                                                    <li>
                                                                        <img src="https://culqi-static-files.s3.amazonaws.com/v3/v3-checkout/icons/calendar.svg" alt="icon">
                                                                        Cuotéalo BCP
                                                                    </li>
                                                                </ul>
                                                                <div class="preview-checkout__container-menu-image">
                                                                    <img src="https://culqi-static-files.s3.amazonaws.com/v3/v3-checkout/logos/culqi-black.svg" alt="Culqi logo">
                                                                </div>
                                                            </div>
                                                            <div class="preview-checkout__container-content">
                                            <span class="form-info">
                                            <img src="https://culqi-static-files.s3.amazonaws.com/v3/v3-checkout/icons/info.svg" alt="culqi icon">
                                            <p style="margin-bottom: 0">Recuerda activar tu tarjeta para <b>compras por internet.</b></p>
                                            </span>

                                            <div class="form__row empty dobble" style="margin-top: 15px">
                                                <div class="form__row__col">
                                                    <div class="form__group">
                                                        <label class="" for="cardNumber">
                                                            Número de Tarjeta
                                                        </label>
                                                        <div class="form__group-input">
                                                            <input name="cardNumber" value="1234 1234 1234 1234" type="tel" class="empty">
                                                            <div class="brand"></div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="form__row" style="float: left; width: 50%;">
                                                <div class="form__row__col left">
                                                    <div class="form__group">
                                                        <label class="" for="cardExp">
                                                            Vencimiento
                                                        </label>
                                                        <div class="form__group-input">
                                                            <input name="cardExp" placeholder="MM/AAAA" type="tel" class="">
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="form__row" style="float: left; width: 50%;">
                                                <div class="form__row__col right">
                                                    <div class="form__group">
                                                        <label class="" for="cardCVV">
                                                            Codigo de seguridad
                                                        </label>
                                                        <div class="form__group-input">
                                                            <input name="cardCVV" placeholder="CVV" type="tel" class="">
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="form__row dobble">
                                                <div class="form__row__col">
                                                    <div class="form__group">
                                                        <label class="" for="select">
                                                            Número de Cuotas
                                                        </label>
                                                        <div class="form__group__select">
                                                            <select name="select" id="select" disabled="disabled">
                                                                <option value="">
                                                                    0
                                                                </option>
                                                            </select></div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="form__row dobble">
                                                <div class="form__row__col">
                                                    <div class="form__group">
                                                        <label class="" for="cardEmail">
                                                            Correo Electrónico
                                                        </label>
                                                        <div class="form__group-input">
                                                            <input name="cardEmail" value="correo@electronico.com" type="email" class="">
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="form__row dobble">
                                                <div class="form__row__col">
                                                    <div class="form__group" style="margin-bottom: 0;">
                                                        <button class="btn btn-green" id="palette-right" name="bg" style="background-color:#00A19B; color: #FFFFFF;">
                                                            Pagar S/ 350.00
                                                        </button>
                                                    </div>
                                                </div>
                                            </div>

                                    </div>
                                </div>
                            </div>

                        </div>
                        <div class="personalize" id="personalize">
                            <div class="personalize-logotipo">
                                <span class="title">Logotipo</span>
                                <div class="personalize-logotipo__content">
                                    <div class="iso-logo">
                                        <div class="iso-logo__item">
                                            <div class="check">
                                                <svg width="9" height="8" viewBox="0 0 9 8" fill="none" xmlns="http://www.w3.org/2000/svg">
                                                    <path d="M1 3.55361L3.53289 6L8 1" stroke="white" stroke-width="1.4" stroke-linecap="round"></path>
                                                </svg>

                                            </div>
                                            <div class="image">
                                                <img src="https://culqi-static-files.s3.amazonaws.com/v3/v3-checkout/brand.svg" alt="logo">
                                            </div>
                                        </div>
                                        <div class="iso-logo__item">
                                            <div class="check">
                                                <svg width="9" height="8" viewBox="0 0 9 8" fill="none" xmlns="http://www.w3.org/2000/svg">
                                                    <path d="M1 3.55361L3.53289 6L8 1" stroke="white" stroke-width="1.4" stroke-linecap="round"></path>
                                                </svg>

                                            </div>
                                            <div class="image">
                                                <img src="https://culqi-static-files.s3.amazonaws.com/v3/v3-checkout/brand-culqi.svg" alt="logo">
                                            </div>
                                        </div>
                                        <div class="iso-logo__item">
                                            <div class="errorlogo">
                                                <svg width="7" height="7" viewBox="0 0 7 7" fill="none"
                                                     xmlns="http://www.w3.org/2000/svg">
                                                    <path d="M1 1L6 6" stroke="white" stroke-width="1.4"
                                                          stroke-linecap="round"/>
                                                    <path d="M6 1L1 6" stroke="white" stroke-width="1.4"
                                                          stroke-linecap="round"/>
                                                </svg>
                                            </div>
                                            <div class="image">
                                                <img src="https://culqi-static-files.s3.amazonaws.com/v3/v3-checkout/bran-culqi-bg.svg" alt="logo">
                                            </div>
                                        </div>

                                    </div>
                                    <div class="detail-logo">
                                        <li class="detail-logo__list">
                                            <svg style="width: 9px!important; height: 8px!important" width="9" height="8" viewBox="0 0 9 8" fill="none" xmlns="http://www.w3.org/2000/svg">
                                                <path d="M1 3.55361L3.53289 6L8 1" stroke="#5BBC43" stroke-width="1.4" stroke-linecap="round"></path>
                                            </svg>

                                            Isotipo
                                        </li>
                                        <li class="detail-logo__list">
                                            <svg style="width: 9px!important; height: 8px!important" width="9" height="8" viewBox="0 0 9 8" fill="none" xmlns="http://www.w3.org/2000/svg">
                                                <path d="M1 3.55361L3.53289 6L8 1" stroke="#5BBC43" stroke-width="1.4" stroke-linecap="round"></path>
                                            </svg>

                                            En fondo blanco
                                        </li>
                                        <li class="detail-logo__list">
                                            <svg style="width: 7px!important; height: 7px!important" width="7" height="7" viewBox="0 0 7 7" fill="none" xmlns="http://www.w3.org/2000/svg">
                                                <path d="M1 1L6 6" stroke="#D20808" stroke-width="1.4" stroke-linecap="round"></path>
                                                <path d="M6 1L1 6" stroke="#D20808" stroke-width="1.4" stroke-linecap="round"></path>
                                            </svg>

                                            Evita fondos de color
                                        </li>

                                    </div>
                                </div>
                            </div>
                            <div class="personalize-url">
                                <span class="title">URL</span>
                                <div class="personalize-url__content">
                                    <div class="form__row empty dobble">
                                        <div class="form__row__col">
                                            <div class="form__group" style="margin-bottom: 0;">
                                                <div class="form__group-input">
                                                    <input name="url" id="logo-url" placeholder="https://culqi.image.jpg.com" value="{$fields_value.CULQI_URL_LOGO|escape:'htmlall':'UTF-8'}" type="url">
                                                </div>
                                                <label id="label-text" for="url">
                                                    Copia la URL de tu logotipo
                                                </label>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <hr>
                            <div class="personalize-color">
                                <span class="title">Color</span>
                                <div class="personalize-color__content">
                                    <p class="paragraph">Personaliza los colores de tu checkout. Elige los colores que más
                                        se acomoden a tu marca.</p>
                                    <div class="personalize-color__content-item">
                                        <div class="subtitle">Predeterminado</div>
                                        <div class="color-palette">
                                            <div class="color-palette__item">
                                                <input type="radio" checked="" name="color-palette" id="141414-00a19b">
                                                <label for="141414-00a19b">
                                                    <div class="color-container">
                                                        <div class="color-container__left" style="background: rgb(20, 20, 20);"></div>
                                                        <div class="color-container__right" style="background: rgb(0, 161, 155);"></div>
                                                    </div>
                                                </label>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="personalize-color__content-item">
                                        <div class="subtitle">Colores clásicos</div>
                                        <div class="color-palette">
                                            <div class="color-palette__item">
                                                <input type="radio" name="color-palette" id="0E456F-2B88D8">
                                                <label for="0E456F-2B88D8">
                                                    <div class="color-container">
                                                        <div class="color-container__left" style="background: rgb(14, 69, 111);"></div>
                                                        <div class="color-container__right" style="background: rgb(43, 136, 216);"></div>
                                                    </div>
                                                </label>
                                            </div>
                                            <div class="color-palette__item">
                                                <input type="radio" name="color-palette" id="7049A8-9373BF">
                                                <label for="7049A8-9373BF">
                                                    <div class="color-container">
                                                        <div class="color-container__left" style="background: rgb(112, 73, 168);"></div>
                                                        <div class="color-container__right" style="background: rgb(147, 115, 191);"></div>
                                                    </div>
                                                </label>
                                            </div>
                                            <div class="color-palette__item">
                                                <input type="radio" name="color-palette" id="3A6505-85B44C">
                                                <label for="3A6505-85B44C">
                                                    <div class="color-container">
                                                        <div class="color-container__left" style="background: rgb(58, 101, 5);"></div>
                                                        <div class="color-container__right" style="background: rgb(133, 180, 76);"></div>
                                                    </div>
                                                </label>
                                            </div>
                                            <div class="color-palette__item">
                                                <input type="radio" name="color-palette" id="EB6F25-E98B52">
                                                <label for="EB6F25-E98B52">
                                                    <div class="color-container">
                                                        <div class="color-container__left" style="background: rgb(235, 111, 37);"></div>
                                                        <div class="color-container__right" style="background: rgb(233, 139, 82);"></div>
                                                    </div>
                                                </label>
                                            </div>
                                            <div class="color-palette__item">
                                                <input type="radio" name="color-palette" id="0280B5-00B1F5">
                                                <label for="0280B5-00B1F5">
                                                    <div class="color-container">
                                                        <div class="color-container__left" style="background: rgb(2, 128, 181);"></div>
                                                        <div class="color-container__right" style="background: rgb(0, 177, 245);"></div>
                                                    </div>
                                                </label>
                                            </div>
                                            <div class="color-palette__item">
                                                <input type="radio" name="color-palette" id="B40593-D32CB5">
                                                <label for="B40593-D32CB5">
                                                    <div class="color-container">
                                                        <div class="color-container__left" style="background: rgb(180, 5, 147);"></div>
                                                        <div class="color-container__right" style="background: rgb(211, 44, 181);"></div>
                                                    </div>
                                                </label>
                                            </div>
                                            <div class="color-palette__item">
                                                <input type="radio" name="color-palette" id="9C3F10-CA5011">
                                                <label for="9C3F10-CA5011">
                                                    <div class="color-container">
                                                        <div class="color-container__left" style="background: rgb(156, 63, 16);"></div>
                                                        <div class="color-container__right" style="background: rgb(202, 80, 17);"></div>
                                                    </div>
                                                </label>
                                            </div>
                                            <div class="color-palette__item">
                                                <input type="radio" name="color-palette" id="F6911B-FFB600">
                                                <label for="F6911B-FFB600">
                                                    <div class="color-container">
                                                        <div class="color-container__left" style="background: rgb(246, 145, 27);"></div>
                                                        <div class="color-container__right" style="background: rgb(255, 182, 0);"></div>
                                                    </div>
                                                </label>
                                            </div>
                                            <div class="color-palette__item">
                                                <input type="radio" name="color-palette" id="6C0101-9D0606">
                                                <label for="6C0101-9D0606">
                                                    <div class="color-container">
                                                        <div class="color-container__left" style="background: rgb(108, 1, 1);"></div>
                                                        <div class="color-container__right" style="background: rgb(157, 6, 6);"></div>
                                                    </div>
                                                </label>
                                            </div>
                                            <div class="color-palette__item">
                                                <input type="radio" name="color-palette" id="046763-00A19B">
                                                <label for="046763-00A19B">
                                                    <div class="color-container">
                                                        <div class="color-container__left" style="background: rgb(4, 103, 99);"></div>
                                                        <div class="color-container__right" style="background: rgb(0, 161, 155);"></div>
                                                    </div>
                                                </label>
                                            </div>
                                            <div class="color-palette__item">
                                                <input type="radio" name="color-palette" id="63464F-894B5D">
                                                <label for="63464F-894B5D">
                                                    <div class="color-container">
                                                        <div class="color-container__left" style="background: rgb(99, 70, 79);"></div>
                                                        <div class="color-container__right" style="background: rgb(137, 75, 93);"></div>
                                                    </div>
                                                </label>
                                            </div>
                                            <div class="color-palette__item">
                                                <input type="radio" name="color-palette" id="C50011-E85965">
                                                <label for="C50011-E85965">
                                                    <div class="color-container">
                                                        <div class="color-container__left" style="background: rgb(197, 0, 17);"></div>
                                                        <div class="color-container__right" style="background: rgb(232, 89, 101);"></div>
                                                    </div>
                                                </label>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="personalize-color__content-item">
                                <span class="action-visible">
                                <svg width="9" height="5" style="width: 9px!important; height: 5px!importanty me " viewBox="0 0 9 5" fill="none" class="action-svg" xmlns="http://www.w3.org/2000/svg">
                                    <g clip-path="url(#clip0_478_2514)">
                                    <path d="M1.61794 4.64227L0.913939 3.94377L4.49994 0.357773L8.08594 3.93827L7.38744 4.64227L4.49994 1.75477L1.61794 4.64227Z" fill="#3CB4E5"></path>
                                    </g>
                                    <defs>
                                    <clipPath id="clip0_478_2514">
                                        <rect width="7.172" height="4.2845" fill="white" transform="translate(8.08594 4.64227) rotate(-180)"></rect>
                                    </clipPath>
                                    </defs>
                                </svg>
                                <span class="action-visible-text">Ver más combinaciones</span></span>
                                        <div class="action-container">
                                            <div class="subtitle">Colores complementarios</div>
                                            <div class="color-palette">
                                                <div class="color-palette__item">
                                                    <input type="radio" name="color-palette" id="0976C9-F6911B">
                                                    <label for="0976C9-F6911B">
                                                        <div class="color-container">
                                                            <div class="color-container__left" style="background: rgb(9, 118, 201);"></div>
                                                            <div class="color-container__right" style="background: rgb(246, 145, 27);"></div>
                                                        </div>
                                                    </label>
                                                </div>
                                                <div class="color-palette__item">
                                                    <input type="radio" name="color-palette" id="8865B9-F48572">
                                                    <label for="8865B9-F48572">
                                                        <div class="color-container">
                                                            <div class="color-container__left" style="background: rgb(136, 101, 185);"></div>
                                                            <div class="color-container__right" style="background: rgb(244, 133, 114);"></div>
                                                        </div>
                                                    </label>
                                                </div>
                                                <div class="color-palette__item">
                                                    <input type="radio" name="color-palette" id="52463A-00A19B">
                                                    <label for="52463A-00A19B">
                                                        <div class="color-container">
                                                            <div class="color-container__left" style="background: rgb(82, 70, 58);"></div>
                                                            <div class="color-container__right" style="background: rgb(0, 161, 155);"></div>
                                                        </div>
                                                    </label>
                                                </div>
                                                <div class="color-palette__item">
                                                    <input type="radio" name="color-palette" id="EB6F25-00A9A4">
                                                    <label for="EB6F25-00A9A4">
                                                        <div class="color-container">
                                                            <div class="color-container__left" style="background: rgb(235, 111, 37);"></div>
                                                            <div class="color-container__right" style="background: rgb(0, 169, 164);"></div>
                                                        </div>
                                                    </label>
                                                </div>
                                                <div class="color-palette__item">
                                                    <input type="radio" name="color-palette" id="134A29-024064">
                                                    <label for="134A29-024064">
                                                        <div class="color-container">
                                                            <div class="color-container__left" style="background: rgb(19, 74, 41);"></div>
                                                            <div class="color-container__right" style="background: rgb(2, 64, 100);"></div>
                                                        </div>
                                                    </label>
                                                </div>
                                                <div class="color-palette__item">
                                                    <input type="radio" name="color-palette" id="0976C9-D32CB5">
                                                    <label for="0976C9-D32CB5">
                                                        <div class="color-container">
                                                            <div class="color-container__left" style="background: rgb(9, 118, 201);"></div>
                                                            <div class="color-container__right" style="background: rgb(211, 44, 181);"></div>
                                                        </div>
                                                    </label>
                                                </div>
                                                <div class="color-palette__item">
                                                    <input type="radio" name="color-palette" id="CA5011-F6911B">
                                                    <label for="CA5011-F6911B">
                                                        <div class="color-container">
                                                            <div class="color-container__left" style="background: rgb(202, 80, 17);"></div>
                                                            <div class="color-container__right" style="background: rgb(246, 145, 27);"></div>
                                                        </div>
                                                    </label>
                                                </div>
                                                <div class="color-palette__item">
                                                    <input type="radio" name="color-palette" id="141414-D20808">
                                                    <label for="141414-D20808">
                                                        <div class="color-container">
                                                            <div class="color-container__left" style="background: rgb(20, 20, 20);"></div>
                                                            <div class="color-container__right" style="background: rgb(210, 8, 8);"></div>
                                                        </div>
                                                    </label>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                                <div class="custom-checkout__footer">
                                    <button class="btn btn-without-line" id="btn-close" type="button">Cancelar</button>
                                    <input class="btn btn-save" id="btn-save" value="Guardar">
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
					</div>
				</div>

                <div class="form-group">
					<label class="control-label col-lg-4" style="font-weight: bold !important;">
						Logo URL
					</label>
					<div class="col-lg-8">
						<input type="text" name="CULQI_URL_LOGO" id="CULQI_URL_LOGO" value="{$fields_value.CULQI_URL_LOGO|escape:'htmlall':'UTF-8'}" class="" readonly>
                        <span class="form-text text-muted"> Este logo aparecerá en tu Culqi Checkout.</span>
					</div>
				</div>

                <div class="form-group">
					<label class="control-label col-lg-4" style="font-weight: bold !important;">
						Tema elegido
					</label>
					<div class="col-lg-8">
						<input type="text" name="CULQI_COLOR_PALETTE" id="CULQI_COLOR_PALETTE" value="{$fields_value.CULQI_COLOR_PALETTE|escape:'htmlall':'UTF-8'}" class="" readonly>
                        <span class="form-text text-muted"> Utilizaremos estos colores para personalizar tu checkout.</span>
					</div>
				</div>

			</div>

			<div class="panel-footer">
				<button type="submit" value="1" id="module_form_submit_btn" name="btnSubmit" class="btn btn-default pull-right" style="background: #45A29C; border-color: #45A29C">
				    <i class="process-icon-save"></i> Guardar cambios
				</button>
			</div>

		</div>

	</form>

    <div class="modal fade" id="modalLogin" tabindex="-1" role="dialog" aria-labelledby="modalLoginLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered" role="document">
            <div class="modal-content">
            <form method="post" id="modal_login_form_culqi">
                <div class="modal-header">
                <span class="modal-title" id="modalLoginLabel">Ingresa tus datos para ayudarte con la configuración.</span>
                </div>
                <div class="modal-body">
                <div class="form-group">
                    <label for="email">Correo electrónico</label>
                    <input required type="email" class="form-control" id="email" name="email" aria-describedby="emailHelp" placeholder="ejemplo@culqi.com">
                </div>
                <div class="form-group">
                    <label for="password">Contraseña</label>
                    <input required type="password" class="form-control" id="password" name="password" placeholder="Tu contraseña de CulqiPanel">
                </div>
                <div class="form-group d-none" style="display: none">
                    <label for="type_integration">Tipo de Integración</label>
                    <select name="type_integration" class="form-control" id="type_integration">
                    <option value="0" selected>Test</option>
                    <option value="1">Live</option>
                    </select>
                </div>
                <div class="form-group">
                <span id="errorlogin" class="form-text text-muted" style="display: none; color: red; font-size: 0.8rem !important;">El usuario ingresado no existe.</span>
                </div>
                </div>
                <div class="modal-footer">
                <button type="submit" name="submit" class="btn btn-primary" style='width:100%; background: #00a19b'>Iniciar Sesión</button>
                <button type="button" onclick="jQuery('#errorlogincpanelculqi').html(''); jQuery('#modalLogin').modal('toggle')" name="button" class="btn btn-primary" style='width:100%; background: #808080;'>Cerrar</button>
                </div>
            </form>
            </div>
        </div>
    </div>

    <div class="modal fade" id="modalList" tabindex="-1" role="dialog" aria-labelledby="modalListLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered" role="document">
            <div class="modal-content">
            <div class="modal-header">
                <div class="modal-title">
                <span class="modalListLabel">¡Bienvenid@!</span>
                </div>
            </div>
            <div class="modal-body">
                <br />
                <div class="modal-subtitle">
                <span class="modalListDesc"
                    >Elige el comercio en donde activarás tu checkout de Culqi</span
                >
                </div>
                <div class="form-group">
                <ul id='list-merchants' class="listaselect"></ul>
                </div>
            </div>
            </div>
        </div>
    </div>

    <script type="text/javascript" defer src="{$module_dir|escape:'htmlall':'UTF-8'}views/js/waitMe.min.js"></script>

    <script type="text/javascript">
        /**
         * @license
         * three.js - JavaScript 3D library
         * Copyright 2016 The three.js Authors
         *
         * Permission is hereby granted, free of charge, to any person obtaining a copy
         * of this software and associated documentation files (the "Software"), to deal
         * in the Software without restriction, including without limitation the rights
         * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
         * copies of the Software, and to permit persons to whom the Software is
         * furnished to do so, subject to the following conditions:
         *
         * The above copyright notice and this permission notice shall be included in
         * all copies or substantial portions of the Software.
         *
         * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
         * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
         * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
         * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
         * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
         * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
         * THE SOFTWARE.
         */
        jQuery(document).ready(function () {
            var post = "{$fields_value.CULQI_POST|escape:'htmlall':'UTF-8'}";
            var errors = "{$fields_value.CULQI_POST_ERRORS|escape:'htmlall':'UTF-8'}";
            if(post==1 && errors==0){
                jQuery('#contact-popup').show()
            }
            jQuery('#module_form').submit(function (e) {

                 /* */
                 console.log('hi save');
                var llavepublica = jQuery('#CULQI_LLAVE_PUBLICA').val().split('_');
                var llaveprivada = jQuery('#CULQI_LLAVE_SECRETA').val().split('_');
                var timexp = jQuery('#CULQI_TIMEXP').val();
                var hasError = '0';

                jQuery('#errorpubkey').html('');
                jQuery('#errorseckey').html('');
                jQuery('#errortimeexp').html('');
                jQuery('#errorpubkey').css('display','none');
                jQuery('#errorseckey').css('display','none');
                jQuery('#errortimeexp').css('display','none');

                if(jQuery('#integracion').is(':checked')){
                    if(!(llavepublica.length==3 && llavepublica[1]=='test')){
                        jQuery('#errorpubkey').html('La llave pública no pertenece al ambiente de integración');
                        jQuery('#errorpubkey').css('display','block');
                        //alert('Las llaves ingresadas no pertenecen al ambiente de integración');
                        //e.preventDefault();
                        hasError = '1'; 
                    }
                    if(!(llaveprivada.length==3 && llaveprivada[1]=='test')) {
                        jQuery('#errorseckey').html('La llave privada no pertenece al ambiente de integración');
                        jQuery('#errorseckey').css('display','block');
                        hasError = '1';
                    }
                }
                if(jQuery('#produccion').is(':checked')){
                    if(!(llavepublica.length==3 && llavepublica[1]=='live')){
                        jQuery('#errorpubkey').html('La llave pública no pertenece al ambiente de producción');
                        jQuery('#errorpubkey').css('display','block');
                        hasError = '1';
                    }
                    if(!(llaveprivada.length==3 && llaveprivada[1]=='live')){
                        jQuery('#errorseckey').html('La llave privada no pertenece al ambiente de producción');
                        jQuery('#errorseckey').css('display','block');
                        hasError = '1';
                    }
                }
                
                console.log('timexp2:::', timexp);
                if(!(timexp=='' || (timexp>0 && timexp.length <= 10 && timexp.length > 0))){
                    
                    //e.preventDefault();
                    jQuery('#errortimeexp').html('El tiempo de expiración debe ser un valor numérico, mayor a 0 y no mayor a 10 dígitos.');
                    //alert('El tiempo de expiración no es correcto, verifique.');
                    jQuery('#errortimeexp').css('display','block');
                    hasError = '1';
                }
                console.log('hasError:::', hasError);
                if(hasError == '1') {
                    e.preventDefault();
                }
                //alert('hi');

                var urlwebhook = "{$fields_value.URLAPI_WEBHOOK_INTEG|escape:'htmlall':'UTF-8'}";
                if(jQuery('#produccion').is(':checked')){
                    urlwebhook = "{$fields_value.URLAPI_WEBHOOK_PROD|escape:'htmlall':'UTF-8'}";
                }
                if (jQuery('#CULQI_TOKENLOGIN').val().length>0) {
                    const settings = {
                        url: urlwebhook,
                        crossDomain: true,
                        dataType: 'json',
                        contentType: 'application/json',
                        type: "GET",
                        timeout: 0,
                        headers: {
                            'Authorization': 'Bearer ' + jQuery('#CULQI_TOKENLOGIN').val(),
                            'Access-Control-Allow-Origin': '*',
                            "Content-Type": "application/json",
                            "Accept": "*/*"
                        },
                        data: {
                            "merchant": jQuery('#CULQI_LLAVE_PUBLICA').val(),
                            "version": 2
                        }
                    };
                    jQuery.ajax(settings).done(function (response) {
                        var valid = 1;
                        for(let i = 0; i < response.data.length; i++) {
                            if(response.data[i].url==jQuery('#CULQI_NOTPAY').val()){
                                valid=0;
                            }
                        }
                        if(valid==1){
                            const settings = {
                                url: urlwebhook,
                                crossDomain: true,
                                dataType: 'json',
                                contentType: 'application/json',
                                type: "POST",
                                timeout: 0,
                                headers: {
                                    'Authorization': 'Bearer ' + jQuery('#CULQI_TOKENLOGIN').val(),
                                    'Access-Control-Allow-Origin': '*',
                                    "Content-Type": "application/json",
                                    "Accept": "*/*"
                                },
                                data: JSON.stringify({
                                    "merchant": jQuery('#CULQI_LLAVE_PUBLICA').val(),
                                    "eventId": "order.status.changed",
                                    "url": jQuery('#CULQI_NOTPAY').val(),
                                    "version": 2
                                }),
                            };
                            jQuery.ajax(settings).done(function (response) {
                                console.log(response);
                            });
                        }
                    });
                }
            });

            jQuery("#modal_login_form_culqi").submit(function (e) {

                e.preventDefault();
                const data = jQuery(this).serializeArray();
                console.log('data:::', data);

                const databody = data.reduce((acc, curVal) => {
                return {  ...acc, [curVal.name]: curVal.value };
                }, {});

                console.log('databody:::', databody);
                run_waitMe();
                fullculqi_login(databody);
            });

            function fullculqi_login(data) {

                jQuery('#errorlogin').html('');
                jQuery('#errorlogin').css('display','none');

                var urllogin = "{$fields_value.URLAPI_LOGIN_INTEG|escape:'htmlall':'UTF-8'}";
                if(jQuery('#produccion').is(':checked')){
                    urllogin = "{$fields_value.URLAPI_LOGIN_PROD|escape:'htmlall':'UTF-8'}";
                }
                const settings = {
                    url: urllogin,
                    method: "POST",
                    timeout: 0,
                    headers: {
                        "Content-Type": "application/json",
                    },
                    data: JSON.stringify(data),
                };
                console.log('settings:::', settings);
                jQuery.ajax(settings).done(function (response) {
                    console.log('response:::', response);
                    window.culqi_token = response.data;
                    console.log('window.culqi_token:::', window.culqi_token);
                    //culqiWoGetMerchants(window.culqi_token);

                    if(typeof(response.message) != "undefined" && response.message !== null){
                        jQuery('#errorlogin').css('display','block');
                        jQuery('#errorlogin').html(response.message);
                    }else{
                        window.culqi_token = response.data;
                        culqiWoGetMerchants(window.culqi_token);
                    }

                }).complete(function() {
                    $('body').waitMe('hide');
                }).error(function() {
                    jQuery('#errorlogin').css('display','block');
                    $('body').waitMe('hide');
                });
            }

            const culqiWoGetMerchants = (token) => {
                console.log('culqiWoGetMerchants');
                var urlmerchant = "{$fields_value.URLAPI_MERCHANT_INTEG|escape:'htmlall':'UTF-8'}";
                if(jQuery('#produccion').is(':checked')){
                    urlmerchant = "{$fields_value.URLAPI_MERCHANT_PROD|escape:'htmlall':'UTF-8'}";
                }
                const settings = {
                    url: urlmerchant,
                    method: "GET",
                    headers: {
                        "Content-Type": "application/json",
                        "Accept": "application/json",
                        "Authorization": "Bearer " + token,
                    },
                };

                console.log('settings:::', settings);

                jQuery.ajax(settings)
                .done(function (response) {
                    console.log('response:::', response);
                    renderMerchants(response.data);
                    jQuery("#modalLogin").modal("hide");
                    jQuery("#modalList").modal("show");
                })
                .error(function (error) {
                    jQuery('#errorlogin').css('display','block');
                    console.log('error:::', error);
                });
            };

            const getMerchant = (id) => {
                run_waitMe();
                console.log('getMerchant');
                var urlmerchantsingle = "{$fields_value.URLAPI_MERCHANTSINGLE_INTEG|escape:'htmlall':'UTF-8'}";
                if(jQuery('#produccion').is(':checked')){
                    urlmerchantsingle = "{$fields_value.URLAPI_MERCHANTSINGLE_PROD|escape:'htmlall':'UTF-8'}";
                }
                const settings = {
                    url: urlmerchantsingle + id,
                    method: "GET",
                    timeout: 0,
                    headers: {
                        "Content-Type": "application/json",
                        "Accept": "application/json",
                        "Authorization": "Bearer " + window.culqi_token,
                    },
                };

                console.log('settings:::', settings);

                jQuery.ajax(settings)
                .done(function (response) {
                    console.log('response data:::', response.data[0].key);
                    window.culqi_settings["private_key"] = response.data[0].key;
                    renderSettings();
                    jQuery("#modalList").modal("hide");
                })
                .complete(function() {
                    $('body').waitMe('hide');
                })
                .error(function() {
                    $('body').waitMe('hide');
                });
                return false;
            };

            const renderSettings = () => {
                console.log(window.culqi_settings);

                if (jQuery("#public_key").length) {
                jQuery("#public_key").val(window.culqi_settings["public_key"]);
                } else {
                jQuery("#CULQI_LLAVE_PUBLICA").val(window.culqi_settings["public_key"]);
                }

                if (jQuery("#secret_key").length) {
                jQuery("#secret_key").val(window.culqi_settings["private_key"]);
                } else {
                jQuery("#CULQI_LLAVE_SECRETA").val(window.culqi_settings["private_key"]);
                }
                jQuery("#CULQI_TOKENLOGIN").val(window.culqi_token);

                window.culqi_settings = null;

                console.log(window.culqi_settings);
            };

            const renderMerchants = (merchants) => {
                let html = "";
                merchants.forEach((merchant) => {
                html += `
                    <li>
                    <div class="items">
                       <div class="merchant_item" data-name="`+merchant.nombre_comercial+`" data-key='`+merchant.codigo_comercio+`'>
                        <div class="merchant_logo">
                            <svg width="24" height="20" viewBox="0 0 24 20" fill="none" xmlns="http://www.w3.org/2000/svg">
                            <g clip-path="url(#clip0_135_620)">
                            <path d="M11.6701 18.3208V19.625H2.46777V8.49707C2.8659 8.69858 3.3209 8.81613 3.79296 8.83852V18.3264H11.6701V18.3208Z" fill="white"/>
                            <path d="M23.244 0.38623V5.56957C23.244 6.50436 22.8459 7.34959 22.2032 7.94293V19.625H12.9952V18.3208H20.8837V8.6986C20.5823 8.78816 20.2524 8.83854 19.9168 8.83854C18.8248 8.83854 17.858 8.31797 17.2551 7.51752C16.6522 8.31797 15.6853 8.83854 14.5933 8.83854C13.5013 8.83854 12.5288 8.31797 11.9259 7.51752C11.414 8.18922 10.6462 8.67061 9.75328 8.79936C9.59403 8.82175 9.4291 8.83854 9.26416 8.83854V7.53431C9.36654 7.53431 9.46322 7.52871 9.55991 7.51192C10.5268 7.37198 11.2605 6.53794 11.2605 5.56957V3.35294H12.5857V5.56957C12.5857 6.65549 13.4786 7.53431 14.582 7.53431C15.6797 7.53431 16.5783 6.65549 16.5783 5.56957V3.35294H17.9035V5.56957C17.9035 6.65549 18.8021 7.53431 19.8998 7.53431C21.0032 7.53431 21.8961 6.65549 21.8961 5.56957V0.38623H23.244Z" fill="white"/>
                            <path d="M12.9952 14.4416V19.625H11.67V14.4416C11.67 13.3053 10.7316 12.3761 9.57134 12.3761C8.41677 12.3761 7.47265 13.2997 7.47265 14.4416V18.3207H6.14746V14.4416C6.14746 12.5832 7.6774 11.0719 9.56565 11.0719C11.4596 11.0719 12.9952 12.5832 12.9952 14.4416Z" fill="white"/>
                            <path d="M19.4337 16.0034H14.4287V11.0775H19.4337V16.0034ZM15.7539 14.6991H18.1085V12.3817H15.7539V14.6991Z" fill="white"/>
                            <path d="M1.95019 1.68924V5.56835C1.95019 6.65427 2.84312 7.53309 3.9465 7.53309C5.04419 7.53309 5.94281 6.65427 5.94281 5.56835V3.35172H7.268V5.56835C7.268 6.65427 8.16662 7.53309 9.26431 7.53309V8.83732C8.17231 8.83732 7.20544 8.31675 6.60256 7.5163C5.99969 8.31675 5.03281 8.83732 3.94081 8.83732C3.88962 8.83732 3.83275 8.83732 3.78156 8.82613C3.30381 8.80933 2.8545 8.68619 2.45637 8.48468C1.37575 7.9585 0.625 6.85019 0.625 5.56835V0.38501H21.9133V1.68924H1.95019Z" fill="white"/>
                            <path d="M23.2388 0.375H21.9136V0.386195H23.2388V0.375Z" fill="white"/>
                            </g>
                            <defs>
                            <clipPath id="clip0_135_620">
                            <rect width="22.75" height="19.25" fill="white" transform="translate(0.625 0.375)"/>
                            </clipPath>
                            </defs>
                            </svg>
                        </div>
                        <div class="merchant_name">`
                        +merchant.nombre_comercial+
                    `</div>
                        <div class="merchant_arrow">
                            <svg width="7" height="13" viewBox="0 0 7 13" fill="none" xmlns="http://www.w3.org/2000/svg">
                            <path d="M5.95079 5.23163L1.71079 0.341176C1.61783 0.233069 1.50723 0.147262 1.38537 0.0887049C1.26351 0.0301478 1.1328 0 1.00079 0C0.868781 0 0.738075 0.0301478 0.616216 0.0887049C0.494356 0.147262 0.383755 0.233069 0.290792 0.341176C0.104542 0.557282 0 0.849616 0 1.15433C0 1.45904 0.104542 1.75138 0.290792 1.96748L3.83079 6.05055L0.290792 10.1336C0.104542 10.3497 0 10.6421 0 10.9468C0 11.2515 0.104542 11.5438 0.290792 11.7599C0.384233 11.8668 0.495049 11.9514 0.616886 12.0088C0.738724 12.0662 0.869186 12.0953 1.00079 12.0944C1.1324 12.0953 1.26286 12.0662 1.3847 12.0088C1.50654 11.9514 1.61735 11.8668 1.71079 11.7599L5.95079 6.86947C6.04452 6.76225 6.11891 6.63468 6.16968 6.49413C6.22045 6.35357 6.24659 6.20282 6.24659 6.05055C6.24659 5.89829 6.22045 5.74753 6.16968 5.60698C6.11891 5.46642 6.04452 5.33886 5.95079 5.23163Z" fill="#B1B8C1"/>
                            </svg>
                        </div>
                        </div>
                    </div>
                    </li>`;
                });
                jQuery("#list-merchants").html(html);

                jQuery(".merchant_item").click(function (event) {

                    const key = jQuery(this).attr("data-key");
                    const name = jQuery(this).attr("data-name");
                    window.culqi_settings = {
                        public_key: key,
                        merchant_name: name,
                    };
                    getMerchant(key);
                    event.preventDefault();
                });
            };


            /* CUSTOMIZE */

            const setUrlLogo = ''; // Al iniciar estará vacío, una vez personalizado el checkout esta variable tendrá seteado el url de logo ingresado
            const setPrimaryColor = ''; // Al iniciar estará vacío, una vez personalizado el checkout esta variable tendrá seteado el color ingresado
            const setSecondaryColor = ''; // Al iniciar estará vacío, una vez personalizado el checkout esta variable tendrá seteado el color ingresado
            const setColors = (setPrimaryColor != '' ? setPrimaryColor.slice(1) : '') + '-' + (setSecondaryColor != '' ? setSecondaryColor.slice(1) : '');

            const btnOpen = document.querySelector('#open-modal')
            const overlay = document.querySelector('#overlay')

            const personalize = document.querySelector('#personalize');

            const inputColor = document.getElementsByName('color-palette');
            const paletteLeft = document.querySelector('#palette-left')
            const paletteRight = document.querySelectorAll('#palette-right');
            const action = document.querySelector('.action-visible');
            const actionSvg = document.querySelector('.action-svg');
            const actionContainer = document.querySelector('.action-container');
            const actionTextVisible = document.querySelector('.action-visible-text');
            const inputLogo = document.querySelector('#logo-url');
            const logo = document.querySelector('#logo');
            const labelText = document.querySelector('#label-text');

            const btnClose = document.querySelectorAll('#btn-close')
            const btnSave = document.querySelector('#btn-save')

            const logoDefault = logo.src;
            const labelDefault = 'Copia la URL de tu logotipo';

            let styleConfig = {};
            let isSelectRadios = false,
                isUrlDefault = false;

            const actionButton = () => {
                if (isSelectRadios || isUrlDefault) {
                btnSave.disabled = false;
                btnSave.classList.remove('disabled')
                } else {
                //btnSave.classList.add('disabled')
                //btnSave.disabled = true;
                }
            }

            const configColors = palette => {
                paletteLeft.style.background = '#' + palette[0];
                paletteRight.forEach(item => {
                switch (item.getAttribute('name')) {
                    case 'color':
                    item.style.color = '#' + palette[1];
                    break;
                    case 'svg':
                    item.style.fill = '#' + palette[1];
                    break;
                    case 'bg':
                    item.style.background = '#' + palette[1];
                    break;
                    default:
                    break;
                }
                })
            }

            if (setUrlLogo != '' && setUrlLogo != null && setUrlLogo != undefined) {
                inputLogo.src = setColors;
            }

            if (setColors != '' && setColors != null && setColors != undefined) {
                inputColor.forEach(el => {
                if (el.id == setColors) {
                    el.checked = true
                    configColors(setColors.split('-'))
                }
                })
            }
            ;

            inputColor.forEach(el => {
                const colors = el.id.split('-');
                const lbl = el.nextElementSibling;
                const left = lbl.querySelector('.color-container__left');
                const right = lbl.querySelector('.color-container__right');
                left.style.background = '#' + colors[0];
                right.style.background = '#' + colors[1];
                el.addEventListener('change', e => {
                const palette = e.target.id.split('-');
                isSelectRadios = (e.target.id !== setColors);
                configColors(palette);
                actionButton();
                })
            })

            inputLogo.addEventListener('input', el => {
                const r = /^(http|https):\/\/[^ "]+$/
                if (r.test(el.target.value)) {
                logo.src = el.target.value;
                isUrlDefault = true;
                labelText.innerText = labelDefault;
                inputLogo.classList.remove('invalid');
                labelText.removeAttribute('style');
                } else if (el.target.value == '') {
                labelText.innerText = labelDefault;
                inputLogo.classList.remove('invalid');
                labelText.removeAttribute('style');
                    logo.src = 'https://culqi-static-files.s3.amazonaws.com/v3/v3-checkout/brand.svg';
                } else {
                inputLogo.classList.add('invalid')
                labelText.style.color = '#D20808';
                isUrlDefault = false;
                logo.src = logoDefault;
                labelText.innerText = 'URL incompleta, falta agregar protocolo https o http';
                }
                ;
                actionButton();
            });

            action.addEventListener('click', () => {
                actionSvg.classList.toggle('rotate');
                actionContainer.classList.toggle('active');
                // cambiar texto de un span
                if (actionContainer.classList.contains('active')) {
                    actionTextVisible.innerText = 'Ver menos combinaciones';
                }
                else {
                    actionTextVisible.innerText = 'Ver más combinaciones';
                }
            });

            btnSave.addEventListener('click', () => {
                const inputs = personalize.getElementsByTagName('input');
                Array.from(inputs).forEach(e => {
                if (e.name == 'color-palette') {
                    if (e.checked) {
                    const colors = e.id.split('-');
                    styleConfig.primaryColor = '#' + colors[0];
                    styleConfig.secondaryColor = '#' + colors[1];
                    }
                } else {
                    styleConfig.urlLogo = e.value;
                }
                })
                overlay.classList.remove('active');
                jQuery('#CULQI_URL_LOGO').val(styleConfig.urlLogo);
                jQuery('#CULQI_COLOR_PALETTE').val(styleConfig.primaryColor+'-'+styleConfig.secondaryColor);
                console.log('styleConfig: ', styleConfig)
            });

            Array.from(btnClose).forEach(el => {
                el.addEventListener('click', event => {
                overlay.classList.remove('active')
                });
            });

            btnOpen.addEventListener('click', () => {
                overlay.classList.add('active')
            });

        });


    </script>

    <script type="text/javascript">
        /**
         * @license
         * three.js - JavaScript 3D library
         * Copyright 2016 The three.js Authors
         *
         * Permission is hereby granted, free of charge, to any person obtaining a copy
         * of this software and associated documentation files (the "Software"), to deal
         * in the Software without restriction, including without limitation the rights
         * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
         * copies of the Software, and to permit persons to whom the Software is
         * furnished to do so, subject to the following conditions:
         *
         * The above copyright notice and this permission notice shall be included in
         * all copies or substantial portions of the Software.
         *
         * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
         * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
         * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
         * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
         * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
         * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
         * THE SOFTWARE.
         */
        document.addEventListener('DOMContentLoaded', () => {
            

            
        })
    </script>
    
    <script type="text/javascript">
    
        jQuery(document).ready(function(){
            jQuery('#{$fields_value.CULQI_COLOR_PALETTEID|escape:'htmlall':'UTF-8'}').click();
            if(document.querySelector('#CULQI_URL_LOGO').value!=''){
                document.querySelector('#logo').src=document.querySelector('#CULQI_URL_LOGO').value;
            }

        });

        function run_waitMe() {
            console.log('run_waitMe');
            $('body').waitMe({
                effect: 'bounce',
                text: 'Cargando. Espere por favor',
                bg: 'rgba(0,0,0,0.7)',
                color:'#fff'
            });
        }
    </script>