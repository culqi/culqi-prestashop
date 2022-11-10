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
        background: rgba(0, 0, 0, 0.5);
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
        font-family: "Lexend Deca", sans-serif !important;
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


    #form-culqi-settings tbody th {
        position: relative;
    }

    .tool {
        cursor: help;
        padding-left: 10PX;
        position: absolute;
        /* right: 0;  */
    }

    .tool::before,
    .tool::after {
        left: 50%;
        opacity: 0;

        position: absolute;
        z-index: -100;
    }

    .tool::after {
        bottom: 30px !important;
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
        transition: all .65s cubic-bezier(.84, -0.18, .31, 1.26), opacity .65s .5s;
        transform: scale(.6) translateY(-90%);
    }

    .tool:hover::before,
    .tool:focus::before {
        transition: all .65s cubic-bezier(.84, -0.18, .31, 1.26) .2s;
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
        transition: all .65s cubic-bezier(.84, -0.18, .31, 1.26) .2s;
        transform: scale(.6) translateY(50%);
        width: 17.5em;
    }

    .tool:hover::after,
    .tool:focus::after {
        transition: all .65s cubic-bezier(.84, -0.18, .31, 1.26);
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

    .can-toggle *,
    .can-toggle *:before,
    .can-toggle *:after {
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

    .can-toggle input[type=checkbox]:focus ~ label .can-toggle__switch,
    .can-toggle input[type=checkbox]:hover ~ label .can-toggle__switch {
        background-color: #777;
    }

    .can-toggle input[type=checkbox]:focus ~ label .can-toggle__switch:after,
    .can-toggle input[type=checkbox]:hover ~ label .can-toggle__switch:after {
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

    .can-toggle input[type=checkbox]:checked:focus ~ label .can-toggle__switch,
    .can-toggle input[type=checkbox]:checked:hover ~ label .can-toggle__switch {
        background-color: #00a19b;
    }

    .can-toggle input[type=checkbox]:checked:focus ~ label .can-toggle__switch:after,
    .can-toggle input[type=checkbox]:checked:hover ~ label .can-toggle__switch:after {
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

    .can-toggle input[type=checkbox]:focus ~ label .can-toggle__switch:after,
    .can-toggle input[type=checkbox]:hover ~ label .can-toggle__switch:after {
        box-shadow: 0 3px 3px rgba(0, 0, 0, 0.4);
    }

    .can-toggle input[type=checkbox]:checked ~ label .can-toggle__switch:after {
        transform: translate3d(65px, 0, 0);
    }

    .can-toggle input[type=checkbox]:checked:focus ~ label .can-toggle__switch:after,
    .can-toggle input[type=checkbox]:checked:hover ~ label .can-toggle__switch:after {
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

    .can-toggle.can-toggle--size-large input[type=checkbox]:focus ~ label .can-toggle__switch:after,
    .can-toggle.can-toggle--size-large input[type=checkbox]:hover ~ label .can-toggle__switch:after {
        box-shadow: 0 4px 4px rgba(0, 0, 0, 0.4);
    }

    .can-toggle.can-toggle--size-large input[type=checkbox]:checked ~ label .can-toggle__switch:after {
        transform: translate3d(78px, 0, 0);
    }

    .can-toggle.can-toggle--size-large input[type=checkbox]:checked:focus ~ label .can-toggle__switch:after,
    .can-toggle.can-toggle--size-large input[type=checkbox]:checked:hover ~ label .can-toggle__switch:after {
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

    .can-toggle.demo-rebrand-1 input[type=checkbox]:focus ~ label .can-toggle__switch,
    .can-toggle.demo-rebrand-1 input[type=checkbox]:hover ~ label .can-toggle__switch {
        background-color: #777;
    }

    .can-toggle.demo-rebrand-1 input[type=checkbox]:focus ~ label .can-toggle__switch:after,
    .can-toggle.demo-rebrand-1 input[type=checkbox]:hover ~ label .can-toggle__switch:after {
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

    .can-toggle.demo-rebrand-1 input[type=checkbox]:checked:focus ~ label .can-toggle__switch,
    .can-toggle.demo-rebrand-1 input[type=checkbox]:checked:hover ~ label .can-toggle__switch {
        background-color: #00a19b;
    }

    .can-toggle.demo-rebrand-1 input[type=checkbox]:checked:focus ~ label .can-toggle__switch:after,
    .can-toggle.demo-rebrand-1 input[type=checkbox]:checked:hover ~ label .can-toggle__switch:after {
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
        border: 1px solid transparent;
        height: 40px;
        display: block;
        padding: 0.375rem 16px;
        font-size: 14px;
        transition: border-color 0.15s ease-in-out;
        box-sizing: border-box;
        line-height: 1.5;
        border-radius: 4px !important;
        font-family: "Lexend Deca", sans-serif !important;
        background-color: #F9F9FA;
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

    .customcheckout input[type="text"].valid,
    .customcheckout input[type="email"].valid,
    .customcheckout input[type="url"].valid,
    .customcheckout input[type="tel"].valid {
        border-color: #00A19B;
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
        color: #b1b8c1 !important;
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

    .customcheckout input[type="radio"]:focus {
        outline: none !important;
    }

    .customcheckout select {
        color: #3e4b61;
        width: 100%;
        border: 1px solid transparent;
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
        font-family: "Lexend Deca", sans-serif !important;
        background-color: #F9F9FA !important;
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
        font-family: "Lexend Deca", sans-serif !important;
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

    .customcheckout .containerpopup {
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
        font-family: "Lexend Deca", sans-serif !important;
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
        border-radius: 8px;
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
        border-radius: 8px;
        -webkit-transform: translateY(20px);
        transform: translateY(20px);
        padding: 4px;
    }

    .customcheckout .custom-checkout__body .preview-checkout__banner .banner-logo img {
        width: 48px;
        height: 48px;
        padding: 4px;
        border-radius: 4px;
        -webkit-box-shadow: 0px 3px 5px rgba(9, 30, 66, 0.2), 0px 0px 1px rgba(9, 30, 66, 0.31);
        box-shadow: 0px 3px 5px rgba(9, 30, 66, 0.2), 0px 0px 1px rgba(9, 30, 66, 0.31);
        -o-object-fit: contain;
        object-fit: contain;
    }

    .customcheckout .custom-checkout__body .preview-checkout__banner .banner-title {
        color: #ffffff;
        font-family: "Lexend Deca", sans-serif !important;
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
        font-family: "Lexend Deca", sans-serif !important;
        font-weight: normal;
        font-size: 16px;
        line-height: 17px;
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
        display: -ms-grid;
        display: grid;
        grid-template-columns: 201px auto;
    }

    .customcheckout .custom-checkout__body .preview-checkout__container-menu {
        width: 100%;
        height: 457px;
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
        font-family: "Lexend Deca", sans-serif !important;
        color: #1F263E;
        font-size: 12px;
        font-weight: 400;
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

    .customcheckout .custom-checkout__body .preview-checkout__container-menu ul li.menu-color {
        color: #00a19b;
    }

    .customcheckout .custom-checkout__body .preview-checkout__container-menu ul li .barra {
        display: block;
        height: 20px;
        width: 2px;
        border-radius: 4px;
        position: absolute;
        left: 0;
        background: #00a19b;
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
        font-family: "Lexend Deca", sans-serif !important;
        font-style: normal;
        font-weight: normal;
        font-size: 12px;
        line-height: 13px;
        display: -webkit-box;
        display: -ms-flexbox;
        display: flex;
        position: relative;
        -webkit-box-align: center;
        -ms-flex-align: center;
        align-items: center;
        margin: 0 auto;
        color: #1F263E;
    }

    .customcheckout .custom-checkout__body .preview-checkout__container-content .form-info svg {
        width: auto !important;
    }

    .customcheckout .custom-checkout__body .personalize {
        font-family: "Lexend Deca", sans-serif !important;
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

    .customcheckout .custom-checkout__body .personalize-logotipo__content .iso-logo__item .check svg,
    .customcheckout .custom-checkout__body .personalize-logotipo__content .iso-logo__item .errorlogo svg {
        width: 10px !important;
        height: 10px !important;
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
        font-family: "Lexend Deca", sans-serif !important;
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

    .customcheckout .form__row label {
        font-family: "Lexend Deca", sans-serif !important;
        font-weight: bold !important;
        margin-bottom: 4px;
        line-height: 16px;
        color: #3E4B61;
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

    .customcheckout .form__group-input .opacity,
    .customcheckout .form__group .opacity {
        opacity: 0.5 !important;
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

    .customcheckout .form__row__col .btn {
        background-color: #00A19B;
        color: #FFFFFF;

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

    @media screen and (max-width: 782px) {
        .customcheckout

    {}
    }

    .can-toggle label .can-toggle__switch:before {
        content: none !important;
    }

    #contact-popup {
        position: fixed;
        top: 0px;
        left: 0px;
        height: 100%;
        width: 100%;
        color: #676767;
        z-index: 999;
        background: rgba(0, 0, 0, 0.7);
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
        background-color: #29a19b;
        border: 1px solid #29a19b;
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

    .bootstrap input[type="number"] {
        display: block;
        width: 100%;
        height: 31px;
        padding: 6px 8px;
        font-size: 12px;
        line-height: 1.42857;
        color: #555;
        background-color: #f5f8f9;
        background-image: none;
        border: 1px solid #c7d6db;
        border-radius: 3px;
        -webkit-transition: border-color ease-in-out 0.15s, box-shadow ease-in-out 0.15s;
        -o-transition: border-color ease-in-out 0.15s, box-shadow ease-in-out 0.15s;
        transition: border-color ease-in-out 0.15s, box-shadow ease-in-out 0.15s;
        font-family: "Open Sans", Helvetica, Arial, sans-serif, "FontAwesome" !important;
        cursor: not-allowed;
        background-color: #eee;
        opacity: 1;
    }
</style>

<link rel="stylesheet" href="{$module_dir|escape:'htmlall':'UTF-8'}views/css/waitMe.min.css" type="text/css"
      media="all">

<div id="contact-popup" style="display: none">
    <form class="contact-form" action="" id="contact-form" method="post" enctype="multipart/form-data">
        <div>
            <div>
                <img src="{$module_dir|escape:'htmlall':'UTF-8'}views/img/icon-check.png"/>
            </div>
            <div>
                <h1>¡Configuración registrada<br/> con éxito!</h1>
            </div>
            <div>
                <p>La configuración de tu Culqi checkout se ha<br/> registrado satisfactoriamente</p>
            </div>
        </div>
        <div>
            <input onclick="const element = document.getElementById('contact-popup'); element.remove();" id="send"
                   type="button" value="Ok">
        </div>
    </form>
</div>

<form id="module_form" class="defaultForm form-horizontal"
      action="{$currentIndex|escape:'htmlall':'UTF-8'}&amp;token={$token|escape:'htmlall':'UTF-8'}" method="post"
      enctype="multipart/form-data" novalidate="">
    <input type="hidden" name="btnSubmit" value="1">

    <div class="panel" id="fieldset_0">
        <div class="panel-heading">
            <i class="icon-money"></i>CONFIGURACIONES GENERALES CULQI
        </div>

        <div class="form-wrapper">

            <div class="form-group">
                <label class="control-label col-lg-4" style="font-weight: bold !important;">
                    Culqi
                </label>
                <div class="col-lg-8 can-toggle demo-rebrand-1">
                    <input id="d" type="checkbox" name="CULQI_ENABLED"
                           value="yes" {$status_enabled|escape:'htmlall':'UTF-8'}>
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
                    <input {$fields_value.CULQI_CHECKED_INTEG|escape:'htmlall':'UTF-8'} type="radio"
                                                                                        name="CULQI_ENVIROMENT"
                                                                                        value="integ" id="integracion">
                    <label for="integracion">Integración</label>
                    <input {$fields_value.CULQI_CHECKED_PROD|escape:'htmlall':'UTF-8'} style="margin-left: 25px"
                                                                                       type="radio"
                                                                                       name="CULQI_ENVIROMENT"
                                                                                       value="prod" id="produccion">
                    <label for="produccion"> Producción</label>
                </div>
            </div>

            <div class="form-group logincontainer">
                <label class="control-label col-lg-4" style="font-weight: bold !important;">
                    ¡Ahorra tiempo configurando tu Culqi checkout! Inicia sesión con tu cuenta de CulqiPanel
                </label>
                <div class="col-lg-8">
                    <button id="pretashop_culqi_login_button" type="button" class="btnlogin" data-toggle="modal"
                            data-target="#modalLogin" onclick="jQuery('#errorlogin').html(''); "
                            style="padding: 10px 20px">
                        <div style="display: inherit; vertical-align: middle">
                            <svg style="width: 16px!important; height: 16px!important" viewBox="0 0 16 16" fill="none"
                                 xmlns="http://www.w3.org/2000/svg" style="margin-bottom: -4px; margin-right: 5px">
                                <path d="M7.99463 8.66086C6.58697 8.66086 5.44795 7.52184 5.44795 6.11418C5.44795 4.70653 6.59772 3.55676 8.00537 3.55676C9.41303 3.55676 10.5628 4.70653 10.5628 6.11418C10.5628 7.52184 9.40228 8.66086 7.99463 8.66086ZM7.99463 4.95367C7.36065 4.95367 6.83412 5.46946 6.83412 6.11418C6.83412 6.75891 7.3499 7.27469 7.99463 7.27469C8.63936 7.27469 9.15514 6.75891 9.15514 6.11418C9.15514 5.46946 8.63936 4.95367 7.99463 4.95367Z"
                                      fill="#3E4B61"/>
                                <path d="M7.99463 0C3.58899 0 0 3.58899 0 7.99463C0 9.75688 0.580255 11.3902 1.54735 12.7119C1.83747 13.1095 2.17058 13.4856 2.53593 13.8294C3.96508 15.1726 5.88852 16 7.99463 16C10.1007 16 12.0242 15.1726 13.4533 13.8294C13.8187 13.4856 14.1518 13.1202 14.4419 12.7119C15.409 11.3902 15.9893 9.75688 15.9893 7.99463C16 3.58899 12.411 0 7.99463 0ZM7.99463 14.6568C6.14641 14.6568 4.47011 13.8939 3.25588 12.6689C4.36266 11.272 6.07119 10.3801 7.99463 10.3801C9.90732 10.3801 11.6159 11.272 12.7334 12.6689C11.5299 13.8939 9.85359 14.6568 7.99463 14.6568ZM13.6145 11.5621C12.2498 9.98254 10.2404 8.98321 7.99463 8.98321C5.74883 8.98321 3.73942 9.98254 2.37475 11.5514C1.71927 10.5306 1.34318 9.30557 1.34318 7.99463C1.34318 4.31968 4.33042 1.33244 8.00537 1.33244C11.6803 1.33244 14.6676 4.31968 14.6676 7.99463C14.6568 9.30557 14.27 10.5306 13.6145 11.5621Z"
                                      fill="#3E4B61"/>
                            </svg>
                        </div>
                        <span>Iniciar Sesión</span>
                    </button>
                </div>
            </div>

            <div class="form-group">
                <label class="control-label col-lg-4" style="font-weight: bold !important;">
                    Llave Pública

                    <span class="tool"
                          data-tip="Encuentra tu llave pública ingresando a la sección Desarrollo en tu Culqipanel, en la pestaña de API Keys"
                          tabindex="2" style=" font-weight: normal;">

            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor"
                 class="bi bi-question-circle-fill" viewBox="0 0 16 16">
              <path d="M16 8A8 8 0 1 1 0 8a8 8 0 0 1 16 0zM5.496 6.033h.825c.138 0 .248-.113.266-.25.09-.656.54-1.134 1.342-1.134.686 0 1.314.343 1.314 1.168 0 .635-.374.927-.965 1.371-.673.489-1.206 1.06-1.168 1.987l.003.217a.25.25 0 0 0 .25.246h.811a.25.25 0 0 0 .25-.25v-.105c0-.718.273-.927 1.01-1.486.609-.463 1.244-.977 1.244-2.056 0-1.511-1.276-2.241-2.673-2.241-1.267 0-2.655.59-2.75 2.286a.237.237 0 0 0 .241.247zm2.325 6.443c.61 0 1.029-.394 1.029-.927 0-.552-.42-.94-1.029-.94-.584 0-1.009.388-1.009.94 0 .533.425.927 1.01.927z"/>
            </svg>

          </span>

                </label>
                <div class="col-lg-8">
                    <input type="hidden" id="CULQI_TOKENLOGIN"/>
                    <input required="true" type="text" name="CULQI_LLAVE_PUBLICA" id="CULQI_LLAVE_PUBLICA"
                           value="{$fields_value.CULQI_LLAVE_PUBLICA|escape:'htmlall':'UTF-8'}" class="">
                    <span id="errorpubkey" class="form-text text-muted"
                          style="display: none; color: red; font-size: 0.8rem !important;">La llave pública no pertenece al ambiente de producción</span>
                    <span class="form-text text-muted"> Ingresa tu llave pública. </span>
                </div>
            </div>

            <div class="form-group">
                <label class="control-label col-lg-4" style="font-weight: bold !important;">
                    Llave Privada

                    <span class="tool"
                          data-tip="Encuentra tu llave privada ingresando a la sección Desarrollo en tu Culqipanel, en la pestaña de API Keys"
                          tabindex="2" style=" font-weight: normal;">

            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor"
                 class="bi bi-question-circle-fill" viewBox="0 0 16 16">
              <path d="M16 8A8 8 0 1 1 0 8a8 8 0 0 1 16 0zM5.496 6.033h.825c.138 0 .248-.113.266-.25.09-.656.54-1.134 1.342-1.134.686 0 1.314.343 1.314 1.168 0 .635-.374.927-.965 1.371-.673.489-1.206 1.06-1.168 1.987l.003.217a.25.25 0 0 0 .25.246h.811a.25.25 0 0 0 .25-.25v-.105c0-.718.273-.927 1.01-1.486.609-.463 1.244-.977 1.244-2.056 0-1.511-1.276-2.241-2.673-2.241-1.267 0-2.655.59-2.75 2.286a.237.237 0 0 0 .241.247zm2.325 6.443c.61 0 1.029-.394 1.029-.927 0-.552-.42-.94-1.029-.94-.584 0-1.009.388-1.009.94 0 .533.425.927 1.01.927z"/>
            </svg>

          </span>

                </label>
                <div class="col-lg-8">
                    <input required="true" type="text" name="CULQI_LLAVE_SECRETA" id="CULQI_LLAVE_SECRETA"
                           value="{$fields_value.CULQI_LLAVE_SECRETA|escape:'htmlall':'UTF-8'}" class="">
                    <span id="errorseckey" class="form-text text-muted"
                          style="display: none; color: red; font-size: 0.8rem !important;">La llave privada no pertenece al ambiente de producción</span>
                    <span class="form-text text-muted"> Ingresa tu llave privada. </span>
                </div>
            </div>

            <div class="form-group">
                <label class="control-label col-lg-4" style="font-weight: bold !important;">
                    Métodos de pago
                </label>
                <div class="col-lg-8">
                    <div class="checkbox">
                        <label for="CULQI_METHODS_TARJETA"><input type="checkbox" name="CULQI_METHODS_TARJETA"
                                                                  id="CULQI_METHODS_TARJETA" class=""
                                                                  value="yes" {$status_methods_tarjeta_enabled|escape:'htmlall':'UTF-8'}>
                            Tarjetas débito/credito</label>
                    </div>
                    <div class="checkbox">
                        <label for="CULQI_METHODS_YAPE"><input type="checkbox" name="CULQI_METHODS_YAPE"
                                                               id="CULQI_METHODS_YAPE" class=""
                                                               value="yes" {$status_methods_yape_enabled|escape:'htmlall':'UTF-8'}>Yape</label>
                    </div>
                    <div class="checkbox">
                        <label for="CULQI_METHODS_WALLETS"><input type="checkbox" name="CULQI_METHODS_WALLETS"
                                                                  id="CULQI_METHODS_WALLETS" class=""
                                                                  value="yes" {$status_methods_wallets_enabled|escape:'htmlall':'UTF-8'}>Billeteras
                            móviles</label>
                        <span class="tool"
                              data-tip="Tus clientes pueden pagar con Yape, Plin y las principales billeteras móviles del país."
                              tabindex="2">
              <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor"
                   class="bi bi-question-circle-fill" viewBox="0 0 16 16">
                <path d="M16 8A8 8 0 1 1 0 8a8 8 0 0 1 16 0zM5.496 6.033h.825c.138 0 .248-.113.266-.25.09-.656.54-1.134 1.342-1.134.686 0 1.314.343 1.314 1.168 0 .635-.374.927-.965 1.371-.673.489-1.206 1.06-1.168 1.987l.003.217a.25.25 0 0 0 .25.246h.811a.25.25 0 0 0 .25-.25v-.105c0-.718.273-.927 1.01-1.486.609-.463 1.244-.977 1.244-2.056 0-1.511-1.276-2.241-2.673-2.241-1.267 0-2.655.59-2.75 2.286a.237.237 0 0 0 .241.247zm2.325 6.443c.61 0 1.029-.394 1.029-.927 0-.552-.42-.94-1.029-.94-.584 0-1.009.388-1.009.94 0 .533.425.927 1.01.927z"/>
              </svg>
            </span>
                    </div>
                    <div class="checkbox">
                        <label for="CULQI_METHODS_BANCAMOVIL"><input type="checkbox" name="CULQI_METHODS_BANCAMOVIL"
                                                                     id="CULQI_METHODS_BANCAMOVIL" class=""
                                                                     value="yes" {$status_methods_bancamovil_enabled|escape:'htmlall':'UTF-8'}>Banca
                            móvil o internet</label>
                    </div>
                    <div class="checkbox">
                        <label for="CULQI_METHODS_AGENTS"><input type="checkbox" name="CULQI_METHODS_AGENTS"
                                                                 id="CULQI_METHODS_AGENTS" class=""
                                                                 value="yes" {$status_methods_agents_enabled|escape:'htmlall':'UTF-8'}>Agentes
                            y bodegas</label>
                    </div>
                    <div class="checkbox">
                        <label for="CULQI_METHODS_QUOTEBCP"><input type="checkbox" name="CULQI_METHODS_QUOTEBCP"
                                                                   id="CULQI_METHODS_QUOTEBCP" class=""
                                                                   value="yes" {$status_methods_quotebcp_enabled|escape:'htmlall':'UTF-8'}>Cuotéalo
                            BCP</label>
                        <span class="tool" data-tip="Paga en cuotas y sin tarjetas de crédito con Cuotéalo"
                              tabindex="2">
              <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor"
                   class="bi bi-question-circle-fill" viewBox="0 0 16 16">
                <path d="M16 8A8 8 0 1 1 0 8a8 8 0 0 1 16 0zM5.496 6.033h.825c.138 0 .248-.113.266-.25.09-.656.54-1.134 1.342-1.134.686 0 1.314.343 1.314 1.168 0 .635-.374.927-.965 1.371-.673.489-1.206 1.06-1.168 1.987l.003.217a.25.25 0 0 0 .25.246h.811a.25.25 0 0 0 .25-.25v-.105c0-.718.273-.927 1.01-1.486.609-.463 1.244-.977 1.244-2.056 0-1.511-1.276-2.241-2.673-2.241-1.267 0-2.655.59-2.75 2.286a.237.237 0 0 0 .241.247zm2.325 6.443c.61 0 1.029-.394 1.029-.927 0-.552-.42-.94-1.029-.94-.584 0-1.009.388-1.009.94 0 .533.425.927 1.01.927z"/>
              </svg>
            </span>
                    </div>
                    <span id="errorpaymentmethod" class="form-text text-muted"
                          style="display: none; color: red; font-size: 0.8rem !important;">Debes seleccionar al menos 1 método de pago.</span>
                </div>
            </div>

            <div class="form-group">
                <label class="control-label col-lg-4" style="font-weight: bold !important;">
                    Tiempo de expiración de pago
                </label>
                <div class="col-lg-8">
                    <input type="text" name="CULQI_TIMEXP" id="CULQI_TIMEXP"
                           value="{$fields_value.CULQI_TIMEXP|escape:'htmlall':'UTF-8'}" class="">
                    <span id="errortimeexp" class="form-text text-muted"
                          style="display: none; color: red; font-size: 0.8rem !important;">El tiempo de expiración debe ser un valor numérico, mayor a 0 y no mayor a 10 dígitos.</span>
                    <span class="form-text text-muted"> Ingresar el número de horas que tendrá el cliente para pagar su orden. Ejem: 24</span>
                </div>
            </div>

            <div class="form-group">
                <label class="control-label col-lg-4" style="font-weight: bold !important;">
                    Notificaciones de pagos

                    <span class="tool"
                          data-tip="Ingresa a tu Culqipanel en la sección de eventos, hacer clic a +Añadir. Se abrirá un popup, en donde deberás escoger order.status.changed y pegar la siguiente URL"
                          tabindex="2" style=" font-weight: normal;">

            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor"
                 class="bi bi-question-circle-fill" viewBox="0 0 16 16">
              <path d="M16 8A8 8 0 1 1 0 8a8 8 0 0 1 16 0zM5.496 6.033h.825c.138 0 .248-.113.266-.25.09-.656.54-1.134 1.342-1.134.686 0 1.314.343 1.314 1.168 0 .635-.374.927-.965 1.371-.673.489-1.206 1.06-1.168 1.987l.003.217a.25.25 0 0 0 .25.246h.811a.25.25 0 0 0 .25-.25v-.105c0-.718.273-.927 1.01-1.486.609-.463 1.244-.977 1.244-2.056 0-1.511-1.276-2.241-2.673-2.241-1.267 0-2.655.59-2.75 2.286a.237.237 0 0 0 .241.247zm2.325 6.443c.61 0 1.029-.394 1.029-.927 0-.552-.42-.94-1.029-.94-.584 0-1.009.388-1.009.94 0 .533.425.927 1.01.927z"/>
            </svg>

          </span>

                </label>
                <div class="col-lg-8">
                    <input type="text" name="CULQI_NOTPAY" id="CULQI_NOTPAY"
                           value="{$fields_value.CULQI_URL_WEBHOOK_PS|escape:'htmlall':'UTF-8'}" readonly="true"
                           class="">
                    <span class="form-text text-muted"> Si no iniciaste sesión con tu cuenta de Culqi Panel, tienes que configurar esta URL colocando estas credenciales:</span><br>
                    <b>Usuario:</b> {$fields_value.CULQI_USERNAME|escape:'htmlall':'UTF-8'}  <b>Password:</b> {$fields_value.CULQI_PASSWORD|escape:'htmlall':'UTF-8'}<br>

                </div>
            </div>

            <div class="form-group">               
                <div class="col-lg-8">
                    <input type="hidden" name="CULQI_USERNAME" id="CULQI_USERNAME"
                           value="{$fields_value.CULQI_USERNAME|escape:'htmlall':'UTF-8'}"
                           class="">
                </div>
            </div>

            <div class="form-group">
                <div class="col-lg-8">
                    <input type="hidden" name="CULQI_PASSWORD" id="CULQI_PASSWORD"
                           value="{$fields_value.CULQI_PASSWORD|escape:'htmlall':'UTF-8'}"
                           class="">
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
                                            <img src="https://culqi-static-files.s3.amazonaws.com/v4/v4-checkout/icons/close-black.svg"
                                                 alt="close">
                                        </div>
                                    </div>
                                    <div class="custom-checkout__body">
                                        <div class="content">
                                            <div class="preview">
                                                <div class="preview-checkout">
                                                    <div class="preview-checkout__banner" id="palette-left">
                                                        <div class="banner-logo">
                                                            <img id="logo"
                                                                 src="https://culqi-static-files.s3.amazonaws.com/v4/v4-checkout/brand.svg"
                                                                 alt="logo">
                                                        </div>
                                                        <div class="banner-title">
                                                            {$fields_value.commerce|escape:'htmlall':'UTF-8'}
                                                        </div>
                                                    </div>
                                                    <div class="preview-checkout__amount">
                                                        <div class="preview-checkout__amount-contain">
                                                            <span id="palette-right" name="color">S/ 350.00</span>
                                                            <svg style="width: 20px!important; height: 20px!important"
                                                                 width="22" height="22" viewBox="0 0 43 43" fill="none"
                                                                 xmlns="http://www.w3.org/2000/svg">
                                                                <path fill-rule="evenodd" id="palette-right" name="svg"
                                                                      clip-rule="evenodd"
                                                                      d="M2.39404 14.3924C2.39404 9.80605 6.11198 6.0881 10.6983 6.0881H31.6775C36.2638 6.0881 39.9817 9.80605 39.9817 14.3924V23.1337C39.9817 23.8578 39.3947 24.4449 38.6705 24.4449C37.9464 24.4449 37.3593 23.8578 37.3593 23.1337V14.3924C37.3593 11.2544 34.8155 8.7105 31.6775 8.7105H10.6983C7.56029 8.7105 5.01644 11.2544 5.01644 14.3924V28.3785C5.01644 31.5165 7.56029 34.0603 10.6983 34.0603H22.9361C23.6603 34.0603 24.2473 34.6474 24.2473 35.3715C24.2473 36.0957 23.6603 36.6827 22.9361 36.6827H10.6983C6.11198 36.6827 2.39404 32.9648 2.39404 28.3785V14.3924Z"
                                                                      fill="#00A19B"/>
                                                                <path id="palette-right" name="svg"
                                                                      d="M12.4462 14.3924C12.4462 13.4268 11.6635 12.6441 10.698 12.6441C9.73243 12.6441 8.94971 13.4268 8.94971 14.3924C8.94971 15.3579 9.73243 16.1406 10.698 16.1406C11.6635 16.1406 12.4462 15.3579 12.4462 14.3924Z"
                                                                      fill="#00A19B"/>
                                                                <path fill-rule="evenodd" id="palette-right" name="svg"
                                                                      clip-rule="evenodd"
                                                                      d="M21.1876 23.5707C19.9807 23.5707 19.0023 22.5923 19.0023 21.3854C19.0023 20.1785 19.9807 19.2001 21.1876 19.2001C22.3945 19.2001 23.3729 20.1785 23.3729 21.3854C23.3729 22.5923 22.3945 23.5707 21.1876 23.5707ZM16.3799 21.3854C16.3799 24.0407 18.5324 26.1931 21.1876 26.1931C23.8428 26.1931 25.9953 24.0407 25.9953 21.3854C25.9953 18.7302 23.8428 16.5777 21.1876 16.5777C18.5324 16.5777 16.3799 18.7302 16.3799 21.3854Z"
                                                                      fill="#00A19B"/>
                                                                <path fill-rule="evenodd" id="palette-right" name="svg"
                                                                      clip-rule="evenodd"
                                                                      d="M39.5339 27.3917C40.0789 27.8686 40.1341 28.6969 39.6572 29.2419L34.6399 34.976C33.5617 36.2082 31.7047 36.3732 30.4262 35.3504L27.3618 32.8989C26.7963 32.4465 26.7046 31.6214 27.157 31.0559C27.6094 30.4904 28.4345 30.3988 29 30.8511L32.0644 33.3026C32.247 33.4488 32.5123 33.4252 32.6663 33.2492L37.6837 27.515C38.1605 26.9701 38.9889 26.9148 39.5339 27.3917Z"
                                                                      fill="#00A19B"/>
                                                            </svg>
                                                        </div>
                                                    </div>
                                                    <div class="preview-checkout__container">
                                                        <div class="preview-checkout__container-menu">
                                                            <ul>
                                                                <li class="menu-color" id="palette-right" name="color">
                                                                    <span class="barra" id="palette-right"
                                                                          name="bg"></span>
                                                                    <svg style="width: 20px!important; height: 20px!important"
                                                                         width="20" height="20" viewBox="0 0 20 20"
                                                                         fill="none" xmlns="http://www.w3.org/2000/svg">
                                                                        <g clip-path="url(#clip0_478_2813)">
                                                                            <path fill-rule="evenodd"
                                                                                  clip-rule="evenodd" id="palette-right"
                                                                                  name="svg"
                                                                                  d="M3.94475 4.5H16.0552C17.0276 4.5 17.9116 5.38 18 6.436V13.564C18 14.62 17.116 15.5 16.0552 15.5H3.94475C2.88398 15.5 2 14.62 2 13.564V6.436C2 5.38 2.88398 4.5 3.94475 4.5ZM16.0552 5.644H3.94475C3.50276 5.644 3.14917 5.996 3.14917 6.436V6.964H16.8508V6.436C16.8508 5.996 16.4972 5.644 16.0552 5.644ZM3.94475 14.268H16.0552C16.4088 14.268 16.7624 13.916 16.7624 13.564V8.108H3.14917V13.476C3.14917 13.916 3.50276 14.268 3.94475 14.268ZM4.20989 11.892H6.68503V13.036H4.20989V11.892Z"
                                                                                  fill="#00A19B"></path>
                                                                        </g>
                                                                        <defs>
                                                                            <clipPath id="clip0_478_2813">
                                                                                <rect width="16" height="11"
                                                                                      fill="white"
                                                                                      transform="translate(2 4.5)"></rect>
                                                                            </clipPath>
                                                                        </defs>
                                                                    </svg>
                                                                    Tarjeta débito/crédito
                                                                </li>
                                                                <li>
                                                                    <img src="https://culqi-static-files.s3.amazonaws.com/v4/v4-checkout/icons/yape.svg"
                                                                         alt="icon">
                                                                    Yape
                                                                </li>
                                                                <li>
                                                                    <img src="https://culqi-static-files.s3.amazonaws.com/v4/v4-checkout/icons/billeteras.svg"
                                                                         alt="icon">
                                                                    Billeteras móviles
                                                                </li>
                                                                <li>
                                                                    <img src="https://culqi-static-files.s3.amazonaws.com/v4/v4-checkout/icons/banca-movil.svg"
                                                                         alt="icon">
                                                                    Banca móvil o internet
                                                                </li>
                                                                <li>
                                                                    <img src="https://culqi-static-files.s3.amazonaws.com/v4/v4-checkout/icons/agents.svg"
                                                                         alt="icon">
                                                                    Agentes y bodegas
                                                                </li>
                                                                <li>
                                                                    <img src="https://culqi-static-files.s3.amazonaws.com/v4/v4-checkout/icons/bcp.svg"
                                                                         alt="icon">
                                                                    Cuotéalo BCP
                                                                </li>
                                                            </ul>
                                                            <div class="preview-checkout__container-menu-image">
                                                                <img src="https://culqi-static-files.s3.amazonaws.com/v4/v4-checkout/logos/culqi-black.svg"
                                                                     alt="Culqi logo">
                                                            </div>
                                                        </div>
                                                        <div class="preview-checkout__container-content">
                              <span class="form-info">
                                <svg width="15" height="13" viewBox="0 0 29 29" fill="none"
                                     xmlns="http://www.w3.org/2000/svg">
                                  <circle cx="14.0867" cy="8.22975" r="1.16551" fill="#00A19B"/>
                                  <path fill-rule="evenodd" id="palette-right" name="svg" clip-rule="evenodd"
                                        d="M14.0868 3.27637C8.13268 3.27637 3.30588 8.10317 3.30588 14.0573C3.30588 20.0115 8.13268 24.8383 14.0868 24.8383C20.041 24.8383 24.8678 20.0115 24.8678 14.0573C24.8678 8.10317 20.041 3.27637 14.0868 3.27637ZM1.55762 14.0573C1.55762 7.13763 7.16714 1.52811 14.0868 1.52811C21.0065 1.52811 26.6161 7.13763 26.6161 14.0573C26.6161 20.977 21.0065 26.5866 14.0868 26.5866C7.16714 26.5866 1.55762 20.977 1.55762 14.0573ZM12.0472 11.7263C12.0472 11.2435 12.4386 10.8522 12.9213 10.8522H14.0868C14.5696 10.8522 14.961 11.2435 14.961 11.7263V19.8849C14.961 20.3676 14.5696 20.759 14.0868 20.759C13.6041 20.759 13.2127 20.3676 13.2127 19.8849V12.6004H12.9213C12.4386 12.6004 12.0472 12.2091 12.0472 11.7263Z"
                                        fill="#00A19B"/>
                                </svg>
                                <p style="margin-bottom: 0">Recuerda activar tu tarjeta para <b>compras por internet.</b></p>
                              </span>

                                                            <div class="form__row empty dobble"
                                                                 style="margin-top: 15px">
                                                                <div class="form__row__col">
                                                                    <div class="form__group">
                                                                        <label class="" for="cardNumber">
                                                                            Número de Tarjeta
                                                                        </label>
                                                                        <div class="form__group-input">
                                                                            <input name="cardNumber"
                                                                                   value="1234 1234 1234 1234"
                                                                                   type="tel" class="valid">
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
                                                                            <input name="cardExp" placeholder="MM/AAAA"
                                                                                   type="tel" class="">
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
                                                                            <input name="cardCVV" placeholder="CVV"
                                                                                   type="tel" class="">
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
                                                                            <select name="select" id="select"
                                                                                    disabled="disabled">
                                                                                <option value="">
                                                                                    Sin cuotas
                                                                                </option>
                                                                            </select>
                                                                        </div>
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
                                                                            <input name="cardEmail"
                                                                                   placeholder="correo@electronico.com"
                                                                                   type="email" class="">
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div class="form__row dobble">
                                                                <div class="form__row__col">
                                                                    <div class="form__group" style="margin-bottom: 0;">
                                                                        <button class="btn btn-green opacity"
                                                                                id="palette-right" name="bg">
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
                                                                    <svg width="9" height="8" viewBox="0 0 9 8"
                                                                         fill="none" xmlns="http://www.w3.org/2000/svg">
                                                                        <path d="M1 3.55361L3.53289 6L8 1"
                                                                              stroke="white" stroke-width="1.4"
                                                                              stroke-linecap="round"></path>
                                                                    </svg>

                                                                </div>
                                                                <div class="image">
                                                                    <img src="https://culqi-static-files.s3.amazonaws.com/v4/v4-checkout/brand.svg"
                                                                         alt="logo">
                                                                </div>
                                                            </div>
                                                            <div class="iso-logo__item">
                                                                <div class="check">
                                                                    <svg width="9" height="8" viewBox="0 0 9 8"
                                                                         fill="none" xmlns="http://www.w3.org/2000/svg">
                                                                        <path d="M1 3.55361L3.53289 6L8 1"
                                                                              stroke="white" stroke-width="1.4"
                                                                              stroke-linecap="round"></path>
                                                                    </svg>

                                                                </div>
                                                                <div class="image">
                                                                    <img src="https://culqi-static-files.s3.amazonaws.com/v4/v4-checkout/brand-culqi.svg"
                                                                         alt="logo">
                                                                </div>
                                                            </div>
                                                            <div class="iso-logo__item">
                                                                <div class="errorlogo">
                                                                    <svg width="7" height="7" viewBox="0 0 7 7"
                                                                         fill="none" xmlns="http://www.w3.org/2000/svg">
                                                                        <path d="M1 1L6 6" stroke="white"
                                                                              stroke-width="1.4"
                                                                              stroke-linecap="round"/>
                                                                        <path d="M6 1L1 6" stroke="white"
                                                                              stroke-width="1.4"
                                                                              stroke-linecap="round"/>
                                                                    </svg>
                                                                </div>
                                                                <div class="image">
                                                                    <img src="https://culqi-static-files.s3.amazonaws.com/v4/v4-checkout/bran-culqi-bg.svg"
                                                                         alt="logo">
                                                                </div>
                                                            </div>

                                                        </div>
                                                        <div class="detail-logo">
                                                            <li class="detail-logo__list">
                                                                <svg style="width: 9px!important; height: 8px!important"
                                                                     width="9" height="8" viewBox="0 0 9 8" fill="none"
                                                                     xmlns="http://www.w3.org/2000/svg">
                                                                    <path d="M1 3.55361L3.53289 6L8 1" stroke="#5BBC43"
                                                                          stroke-width="1.4"
                                                                          stroke-linecap="round"></path>
                                                                </svg>

                                                                Isotipo
                                                            </li>
                                                            <li class="detail-logo__list">
                                                                <svg style="width: 9px!important; height: 8px!important"
                                                                     width="9" height="8" viewBox="0 0 9 8" fill="none"
                                                                     xmlns="http://www.w3.org/2000/svg">
                                                                    <path d="M1 3.55361L3.53289 6L8 1" stroke="#5BBC43"
                                                                          stroke-width="1.4"
                                                                          stroke-linecap="round"></path>
                                                                </svg>

                                                                En fondo blanco
                                                            </li>
                                                            <li class="detail-logo__list">
                                                                <svg style="width: 7px!important; height: 7px!important"
                                                                     width="7" height="7" viewBox="0 0 7 7" fill="none"
                                                                     xmlns="http://www.w3.org/2000/svg">
                                                                    <path d="M1 1L6 6" stroke="#D20808"
                                                                          stroke-width="1.4"
                                                                          stroke-linecap="round"></path>
                                                                    <path d="M6 1L1 6" stroke="#D20808"
                                                                          stroke-width="1.4"
                                                                          stroke-linecap="round"></path>
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
                                                                        <input name="url" id="logo-url"
                                                                               placeholder="https://culqi.image.jpg.com"
                                                                               value="{$fields_value.CULQI_URL_LOGO|escape:'htmlall':'UTF-8'}"
                                                                               type="url">
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
                                                        <p class="paragraph">Personaliza los colores de tu checkout.
                                                            Elige los colores que más
                                                            se acomoden a tu marca.</p>
                                                        <div class="personalize-color__content-item">
                                                            <div class="subtitle">Predeterminado</div>
                                                            <div class="color-palette">
                                                                <div class="color-palette__item">
                                                                    <input type="radio" checked="" name="color-palette"
                                                                           class="colorPreviewDefault"
                                                                           id="141414-00a19b">
                                                                    <label for="141414-00a19b">
                                                                        <div class="color-container">
                                                                            <div class="color-container__left"
                                                                                 style="background: rgb(20, 20, 20);"></div>
                                                                            <div class="color-container__right"
                                                                                 style="background: rgb(0, 161, 155);"></div>
                                                                        </div>
                                                                    </label>
                                                                </div>
                                                            </div>
                                                        </div>

                                                        <div class="personalize-color__content-item">
                                                            <div class="subtitle">Colores clásicos</div>
                                                            <div class="color-palette">
                                                                <div class="color-palette__item">
                                                                    <input type="radio" name="color-palette"
                                                                           id="0E456F-2B88D8">
                                                                    <label for="0E456F-2B88D8">
                                                                        <div class="color-container">
                                                                            <div class="color-container__left"
                                                                                 style="background: rgb(14, 69, 111);"></div>
                                                                            <div class="color-container__right"
                                                                                 style="background: rgb(43, 136, 216);"></div>
                                                                        </div>
                                                                    </label>
                                                                </div>
                                                                <div class="color-palette__item">
                                                                    <input type="radio" name="color-palette"
                                                                           id="7049A8-9373BF">
                                                                    <label for="7049A8-9373BF">
                                                                        <div class="color-container">
                                                                            <div class="color-container__left"
                                                                                 style="background: rgb(112, 73, 168);"></div>
                                                                            <div class="color-container__right"
                                                                                 style="background: rgb(147, 115, 191);"></div>
                                                                        </div>
                                                                    </label>
                                                                </div>
                                                                <div class="color-palette__item">
                                                                    <input type="radio" name="color-palette"
                                                                           id="3A6505-85B44C">
                                                                    <label for="3A6505-85B44C">
                                                                        <div class="color-container">
                                                                            <div class="color-container__left"
                                                                                 style="background: rgb(58, 101, 5);"></div>
                                                                            <div class="color-container__right"
                                                                                 style="background: rgb(133, 180, 76);"></div>
                                                                        </div>
                                                                    </label>
                                                                </div>
                                                                <div class="color-palette__item">
                                                                    <input type="radio" name="color-palette"
                                                                           id="EB6F25-E98B52">
                                                                    <label for="EB6F25-E98B52">
                                                                        <div class="color-container">
                                                                            <div class="color-container__left"
                                                                                 style="background: rgb(235, 111, 37);"></div>
                                                                            <div class="color-container__right"
                                                                                 style="background: rgb(233, 139, 82);"></div>
                                                                        </div>
                                                                    </label>
                                                                </div>
                                                                <div class="color-palette__item">
                                                                    <input type="radio" name="color-palette"
                                                                           id="0280B5-00B1F5">
                                                                    <label for="0280B5-00B1F5">
                                                                        <div class="color-container">
                                                                            <div class="color-container__left"
                                                                                 style="background: rgb(2, 128, 181);"></div>
                                                                            <div class="color-container__right"
                                                                                 style="background: rgb(0, 177, 245);"></div>
                                                                        </div>
                                                                    </label>
                                                                </div>
                                                                <div class="color-palette__item">
                                                                    <input type="radio" name="color-palette"
                                                                           id="B40593-D32CB5">
                                                                    <label for="B40593-D32CB5">
                                                                        <div class="color-container">
                                                                            <div class="color-container__left"
                                                                                 style="background: rgb(180, 5, 147);"></div>
                                                                            <div class="color-container__right"
                                                                                 style="background: rgb(211, 44, 181);"></div>
                                                                        </div>
                                                                    </label>
                                                                </div>
                                                                <div class="color-palette__item">
                                                                    <input type="radio" name="color-palette"
                                                                           id="9C3F10-CA5011">
                                                                    <label for="9C3F10-CA5011">
                                                                        <div class="color-container">
                                                                            <div class="color-container__left"
                                                                                 style="background: rgb(156, 63, 16);"></div>
                                                                            <div class="color-container__right"
                                                                                 style="background: rgb(202, 80, 17);"></div>
                                                                        </div>
                                                                    </label>
                                                                </div>
                                                                <div class="color-palette__item">
                                                                    <input type="radio" name="color-palette"
                                                                           id="F6911B-FFB600">
                                                                    <label for="F6911B-FFB600">
                                                                        <div class="color-container">
                                                                            <div class="color-container__left"
                                                                                 style="background: rgb(246, 145, 27);"></div>
                                                                            <div class="color-container__right"
                                                                                 style="background: rgb(255, 182, 0);"></div>
                                                                        </div>
                                                                    </label>
                                                                </div>
                                                                <div class="color-palette__item">
                                                                    <input type="radio" name="color-palette"
                                                                           id="6C0101-9D0606">
                                                                    <label for="6C0101-9D0606">
                                                                        <div class="color-container">
                                                                            <div class="color-container__left"
                                                                                 style="background: rgb(108, 1, 1);"></div>
                                                                            <div class="color-container__right"
                                                                                 style="background: rgb(157, 6, 6);"></div>
                                                                        </div>
                                                                    </label>
                                                                </div>
                                                                <div class="color-palette__item">
                                                                    <input type="radio" name="color-palette"
                                                                           id="046763-00A19B">
                                                                    <label for="046763-00A19B">
                                                                        <div class="color-container">
                                                                            <div class="color-container__left"
                                                                                 style="background: rgb(4, 103, 99);"></div>
                                                                            <div class="color-container__right"
                                                                                 style="background: rgb(0, 161, 155);"></div>
                                                                        </div>
                                                                    </label>
                                                                </div>
                                                                <div class="color-palette__item">
                                                                    <input type="radio" name="color-palette"
                                                                           id="63464F-894B5D">
                                                                    <label for="63464F-894B5D">
                                                                        <div class="color-container">
                                                                            <div class="color-container__left"
                                                                                 style="background: rgb(99, 70, 79);"></div>
                                                                            <div class="color-container__right"
                                                                                 style="background: rgb(137, 75, 93);"></div>
                                                                        </div>
                                                                    </label>
                                                                </div>
                                                                <div class="color-palette__item">
                                                                    <input type="radio" name="color-palette"
                                                                           id="C50011-E85965">
                                                                    <label for="C50011-E85965">
                                                                        <div class="color-container">
                                                                            <div class="color-container__left"
                                                                                 style="background: rgb(197, 0, 17);"></div>
                                                                            <div class="color-container__right"
                                                                                 style="background: rgb(232, 89, 101);"></div>
                                                                        </div>
                                                                    </label>
                                                                </div>
                                                            </div>
                                                        </div>

                                                        <div class="personalize-color__content-item">
                              <span class="action-visible">
                                <svg width="9" height="5" style="width: 9px!important; height: 5px!important;"
                                     viewBox="0 0 9 5" fill="none" class="action-svg"
                                     xmlns="http://www.w3.org/2000/svg">
                                  <g clip-path="url(#clip0_478_2514)">
                                    <path d="M1.61794 4.64227L0.913939 3.94377L4.49994 0.357773L8.08594 3.93827L7.38744 4.64227L4.49994 1.75477L1.61794 4.64227Z"
                                          fill="#3CB4E5"></path>
                                  </g>
                                  <defs>
                                    <clipPath id="clip0_478_2514">
                                      <rect width="7.172" height="4.2845" fill="white"
                                            transform="translate(8.08594 4.64227) rotate(-180)"></rect>
                                    </clipPath>
                                  </defs>
                                </svg>
                                <span class="action-visible-text">Ver más combinaciones</span></span>
                                                            <div class="action-container">
                                                                <div class="subtitle">Colores complementarios</div>
                                                                <div class="color-palette">
                                                                    <div class="color-palette__item">
                                                                        <input type="radio" name="color-palette"
                                                                               id="0976C9-F6911B">
                                                                        <label for="0976C9-F6911B">
                                                                            <div class="color-container">
                                                                                <div class="color-container__left"
                                                                                     style="background: rgb(9, 118, 201);"></div>
                                                                                <div class="color-container__right"
                                                                                     style="background: rgb(246, 145, 27);"></div>
                                                                            </div>
                                                                        </label>
                                                                    </div>
                                                                    <div class="color-palette__item">
                                                                        <input type="radio" name="color-palette"
                                                                               id="8865B9-F48572">
                                                                        <label for="8865B9-F48572">
                                                                            <div class="color-container">
                                                                                <div class="color-container__left"
                                                                                     style="background: rgb(136, 101, 185);"></div>
                                                                                <div class="color-container__right"
                                                                                     style="background: rgb(244, 133, 114);"></div>
                                                                            </div>
                                                                        </label>
                                                                    </div>
                                                                    <div class="color-palette__item">
                                                                        <input type="radio" name="color-palette"
                                                                               id="52463A-00A19B">
                                                                        <label for="52463A-00A19B">
                                                                            <div class="color-container">
                                                                                <div class="color-container__left"
                                                                                     style="background: rgb(82, 70, 58);"></div>
                                                                                <div class="color-container__right"
                                                                                     style="background: rgb(0, 161, 155);"></div>
                                                                            </div>
                                                                        </label>
                                                                    </div>
                                                                    <div class="color-palette__item">
                                                                        <input type="radio" name="color-palette"
                                                                               id="EB6F25-00A9A4">
                                                                        <label for="EB6F25-00A9A4">
                                                                            <div class="color-container">
                                                                                <div class="color-container__left"
                                                                                     style="background: rgb(235, 111, 37);"></div>
                                                                                <div class="color-container__right"
                                                                                     style="background: rgb(0, 169, 164);"></div>
                                                                            </div>
                                                                        </label>
                                                                    </div>
                                                                    <div class="color-palette__item">
                                                                        <input type="radio" name="color-palette"
                                                                               id="134A29-024064">
                                                                        <label for="134A29-024064">
                                                                            <div class="color-container">
                                                                                <div class="color-container__left"
                                                                                     style="background: rgb(19, 74, 41);"></div>
                                                                                <div class="color-container__right"
                                                                                     style="background: rgb(2, 64, 100);"></div>
                                                                            </div>
                                                                        </label>
                                                                    </div>
                                                                    <div class="color-palette__item">
                                                                        <input type="radio" name="color-palette"
                                                                               id="0976C9-D32CB5">
                                                                        <label for="0976C9-D32CB5">
                                                                            <div class="color-container">
                                                                                <div class="color-container__left"
                                                                                     style="background: rgb(9, 118, 201);"></div>
                                                                                <div class="color-container__right"
                                                                                     style="background: rgb(211, 44, 181);"></div>
                                                                            </div>
                                                                        </label>
                                                                    </div>
                                                                    <div class="color-palette__item">
                                                                        <input type="radio" name="color-palette"
                                                                               id="CA5011-F6911B">
                                                                        <label for="CA5011-F6911B">
                                                                            <div class="color-container">
                                                                                <div class="color-container__left"
                                                                                     style="background: rgb(202, 80, 17);"></div>
                                                                                <div class="color-container__right"
                                                                                     style="background: rgb(246, 145, 27);"></div>
                                                                            </div>
                                                                        </label>
                                                                    </div>
                                                                    <div class="color-palette__item">
                                                                        <input type="radio" name="color-palette"
                                                                               id="141414-D20808">
                                                                        <label for="141414-D20808">
                                                                            <div class="color-container">
                                                                                <div class="color-container__left"
                                                                                     style="background: rgb(20, 20, 20);"></div>
                                                                                <div class="color-container__right"
                                                                                     style="background: rgb(210, 8, 8);"></div>
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
                                        <button class="btn btn-without-line" id="btn-close" type="button">Cancelar
                                        </button>
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
                    <input type="text" name="CULQI_URL_LOGO" id="CULQI_URL_LOGO"
                           value="{$fields_value.CULQI_URL_LOGO|escape:'htmlall':'UTF-8'}" class="" readonly>
                    <span class="form-text text-muted"> Este logo aparecerá en tu Culqi Checkout.</span>
                </div>
            </div>

            <div class="form-group">
                <label class="control-label col-lg-4" style="font-weight: bold !important;">
                    Tema elegido
                </label>
                <div class="col-lg-8">
                    <input type="text" name="CULQI_COLOR_PALETTE" id="CULQI_COLOR_PALETTE"
                           value="{$fields_value.CULQI_COLOR_PALETTE|escape:'htmlall':'UTF-8'}" class="" readonly>
                    <span class="form-text text-muted"> Utilizaremos estos colores para personalizar tu checkout.</span>
                </div>
            </div>

        </div>

        <div class="panel-footer">
            <button type="submit" value="1" id="module_form_submit_btn" name="btnSubmit"
                    class="btn btn-default pull-right" style="background: #45A29C; border-color: #45A29C">
                <i class="process-icon-save"></i> Guardar cambios
            </button>
        </div>

    </div>

</form>

<div class="modal fade" id="modalLogin" tabindex="-1" role="dialog" aria-labelledby="modalLoginLabel"
     aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content">
            <form method="post" id="modal_login_form_culqi">
                <div class="modal-header">
                    <span class="modal-title"
                          id="modalLoginLabel">Ingresa tus datos para ayudarte con la configuración.</span>
                </div>
                <div class="modal-body">
                    <div class="form-group">
                        <label for="email">Correo electrónico</label>
                        <input required type="email" class="form-control" id="email" name="email"
                               aria-describedby="emailHelp" placeholder="ejemplo@culqi.com">
                    </div>
                    <div class="form-group">
                        <label for="password">Contraseña</label>
                        <input required type="password" class="form-control" id="password" name="password"
                               placeholder="Tu contraseña de CulqiPanel">
                    </div>
                    <div class="form-group d-none" style="display: none">
                        <label for="type_integration">Tipo de Integración</label>
                        <select name="type_integration" class="form-control" id="type_integration">
                            <option value="0" selected>Test</option>
                            <option value="1">Live</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <span id="errorlogin" class="form-text text-muted"
                              style="display: none; color: red; font-size: 0.8rem !important;">El usuario ingresado no existe.</span>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="submit" name="submit" class="btn btn-primary" style='width:100%; background: #00a19b'>
                        Iniciar Sesión
                    </button>
                    <button type="button"
                            onclick="jQuery('#errorlogincpanelculqi').html(''); jQuery('#modalLogin').modal('toggle')"
                            name="button" class="btn btn-primary" style='width:100%; background: #808080;'>Cerrar
                    </button>
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
                <br/>
                <div class="modal-subtitle">
                    <span class="modalListDesc">Elige el comercio en donde activarás tu checkout de Culqi</span>
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
        var sendsubmit = 0;
        var post = "{$fields_value.CULQI_POST|escape:'htmlall':'UTF-8'}";
        var errors = "{$fields_value.CULQI_POST_ERRORS|escape:'htmlall':'UTF-8'}";
        if (post == 1 && errors == 0) {
            jQuery('#contact-popup').show()
        }
        jQuery('#module_form').submit(function (e) {
            console.log('hi save');
            var llavepublica = jQuery('#CULQI_LLAVE_PUBLICA').val().split('_');
            var llaveprivada = jQuery('#CULQI_LLAVE_SECRETA').val().split('_');
            var timexp = jQuery('#CULQI_TIMEXP').val();
            var hasError = '0';

            jQuery('#errorpubkey').html('');
            jQuery('#errorseckey').html('');
            jQuery('#errortimeexp').html('');
            jQuery('#errorpubkey').css('display', 'none');
            jQuery('#errorseckey').css('display', 'none');
            jQuery('#errortimeexp').css('display', 'none');

            if (jQuery('#integracion').is(':checked')) {
                if (!(llavepublica.length == 3 && llavepublica[1] == 'test')) {
                    jQuery('#errorpubkey').html('La llave pública no pertenece al ambiente de integración');
                    jQuery('#errorpubkey').css('display', 'block');
                    //alert('Las llaves ingresadas no pertenecen al ambiente de integración');
                    //e.preventDefault();
                    hasError = '1';
                }
                if (!(llaveprivada.length == 3 && llaveprivada[1] == 'test')) {
                    jQuery('#errorseckey').html('La llave privada no pertenece al ambiente de integración');
                    jQuery('#errorseckey').css('display', 'block');
                    hasError = '1';
                }
            }
            if (jQuery('#produccion').is(':checked')) {
                if (!(llavepublica.length == 3 && llavepublica[1] == 'live')) {
                    jQuery('#errorpubkey').html('La llave pública no pertenece al ambiente de producción');
                    jQuery('#errorpubkey').css('display', 'block');
                    hasError = '1';
                }
                if (!(llaveprivada.length == 3 && llaveprivada[1] == 'live')) {
                    jQuery('#errorseckey').html('La llave privada no pertenece al ambiente de producción');
                    jQuery('#errorseckey').css('display', 'block');
                    hasError = '1';
                }
            }

            console.log('timexp2:::', timexp);
            if (!(timexp == '' || (timexp > 0 && timexp.length <= 10 && timexp.length > 0))) {
                //e.preventDefault();
                jQuery('#errortimeexp').html('El tiempo de expiración debe ser un valor numérico, mayor a 0 y no mayor a 10 dígitos.');
                //alert('El tiempo de expiración no es correcto, verifique.');
                jQuery('#errortimeexp').css('display', 'block');
                hasError = '1';
            }
            console.log('hasError:::', hasError);

            if (!(jQuery('#CULQI_METHODS_TARJETA').is(':checked') || jQuery('#CULQI_METHODS_BANCAMOVIL').is(':checked') || jQuery('#CULQI_METHODS_YAPE').is(':checked') || jQuery('#CULQI_METHODS_AGENTS').is(':checked') || jQuery('#CULQI_METHODS_WALLETS').is(':checked') || jQuery('#CULQI_METHODS_QUOTEBCP').is(':checked'))) {
                jQuery('#errorpaymentmethod').css('display', 'block');
                hasError = '1';
            }

            if (hasError == '1') {
                e.preventDefault();
                return false;
            }
            //alert('hi');
            console.log(sendsubmit);

            sendWebhook();
            e.preventDefault();
        });

        jQuery("#modal_login_form_culqi").submit(function (e) {

            e.preventDefault();
            const data = jQuery(this).serializeArray();
            console.log('data:::', data);

            const databody = data.reduce((acc, curVal) => {
                return {
                    ...acc,
                    [curVal.name]: curVal.value
                };
            }, {});

            console.log('databody:::', databody);
            run_waitMe();
            fullculqi_login(databody);
        });

        function sendWebhook() {
            console.log('jaji');
            var urlwebhook = "{$fields_value.URLAPI_WEBHOOK_INTEG|escape:'htmlall':'UTF-8'}";
            if (jQuery('#produccion').is(':checked')) {
                urlwebhook = "{$fields_value.URLAPI_WEBHOOK_PROD|escape:'htmlall':'UTF-8'}";
            }
            if (jQuery('#CULQI_TOKENLOGIN').val().length > 0) {
                const settings = {
                    url: urlwebhook,
                    crossDomain: true,
                    dataType: 'json',
                    contentType: 'application/json',
                    type: "GET",
                    timeout: 0,
                    headers: {
                        'Authorization': 'Bearer ' + jQuery('#CULQI_TOKENLOGIN').val(),
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
                    for (let i = 0; i < response.data.length; i++) {
                        if (response.data[i].url == jQuery('#CULQI_NOTPAY').val()) {
                            valid = 0;
                        }
                    }
                    if (valid == 1) {
                        const settings = {
                            url: urlwebhook,
                            crossDomain: true,
                            dataType: 'json',
                            contentType: 'application/json',
                            type: "POST",
                            timeout: 0,
                            headers: {
                                'Authorization': 'Bearer ' + jQuery('#CULQI_TOKENLOGIN').val(),
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
                            $('#module_form').unbind('submit').submit();
                        });
                    } else {
                        $('#module_form').unbind('submit').submit();
                    }
                });
            } else {
                $('#module_form').unbind('submit').submit();
            }
        }

        function fullculqi_login(data) {

            jQuery('#errorlogin').html('');
            jQuery('#errorlogin').css('display', 'none');

            var urllogin = "{$fields_value.URLAPI_LOGIN_INTEG|escape:'htmlall':'UTF-8'}";
            if (jQuery('#produccion').is(':checked')) {
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

                if (typeof (response.message) != "undefined" && response.message !== null) {
                    jQuery('#errorlogin').css('display', 'block');
                    jQuery('#errorlogin').html(response.message);
                    $('body').waitMe('hide');
                } else {
                    jQuery("#modalLogin").modal("hide");
                    window.culqi_token = response.data;
                    culqiWoGetMerchants(window.culqi_token);
                }

            }).complete(function () {

            }).error(function () {
                jQuery('#errorlogin').css('display', 'block');
            });
        }

        const culqiWoGetMerchants = (token) => {
            console.log('culqiWoGetMerchants');
            var urlmerchant = "{$fields_value.URLAPI_MERCHANT_INTEG|escape:'htmlall':'UTF-8'}";
            if (jQuery('#produccion').is(':checked')) {
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
                    jQuery('#errorlogin').css('display', 'block');
                    console.log('error:::', error);
                });
        };

        const getMerchant = (id) => {
            run_waitMe();
            console.log('getMerchant');
            var urlmerchantsingle = "{$fields_value.URLAPI_MERCHANTSINGLE_INTEG|escape:'htmlall':'UTF-8'}";
            if (jQuery('#produccion').is(':checked')) {
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
                    window.culqi_settings["private_key"] = '';
                    console.log('response data seckeys:::', response.data);
                    for (var v = 0; v < response.data.length; v++) {
                        if (response.data[v].active) {
                            window.culqi_settings["private_key"] = response.data[v].key;
                        }
                    }
                    renderSettings();
                    jQuery("#modalList").modal("hide");
                })
                .complete(function () {
                    $('body').waitMe('hide');
                })
                .error(function () {
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
                       <div class="merchant_item" data-name="` + merchant.nombre_comercial + `" data-key='` + merchant.codigo_comercio + `'>
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
                        <div class="merchant_name">` +
                    merchant.nombre_comercial +
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
            setTimeout(function () {
                $('body').waitMe('hide');
            }, 2000)

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

        const setLogoPs = "{$fields_value.CULQI_URL_LOGO|escape:'htmlall':'UTF-8'}";
        const setPrimaryColor = ''; // Al iniciar estará vacío, una vez personalizado el checkout esta variable tendrá seteado el color ingresado
        const setSecondaryColor = ''; // Al iniciar estará vacío, una vez personalizado el checkout esta variable tendrá seteado el color ingresado
        const setPalette = "{$fields_value.CULQI_COLOR_PALETTE|escape:'htmlall':'UTF-8'}";

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


        const checkoutPreviewText = {
            labelDefault: 'Copia la URL de tu logotipo',
            logoDefault: 'https://culqi-static-files.s3.amazonaws.com/v3/v3-checkout/brand.svg',
            errors: {
                logoUrl: 'URL incompleta, falta agregar protocolo https o http',
                logoInvalid: 'Imagen no válida'
            }
        }

        let styleConfig = {};
        let isEnabledRadio = false,
            isEnabledLogo = false,
            isValidUrlLogo = true;

        const actionButton = () => {
            if (isEnabledRadio || isEnabledLogo) {
                btnSave.disabled = false;
                btnSave.classList.remove('disabled')
            } else {
                btnSave.classList.add('disabled')
                btnSave.disabled = true;
            }
        }

        const getSetColor = () => {
            let color = '';
            if (styleConfig.primaryColor && styleConfig.secondaryColor) {
                if (styleConfig.primaryColor != '' && styleConfig.secondaryColor != '') {
                    color = styleConfig.primaryColor.slice(1) + '-' + styleConfig.secondaryColor.slice(1);
                }
            } else if (setPalette != '') {
                color = setPalette.replace(new RegExp('#', 'g'), '');
            }
            return color;
        }

        const setValidationInput = (input = null, logo = null) => {
            if (typeof input == "boolean") {
                isEnabledRadio = input
            }
            if (typeof logo == "boolean") {
                isEnabledLogo = logo
            }
        }

        const configColors = (palette, isRemove) => {
            isRemove = isRemove || false;
            paletteLeft.style.background = isRemove ? null : '#' + palette[0];
            ;
            paletteRight.forEach((item) => {
                switch (item.getAttribute('name')) {
                    case 'color':
                        item.style.color = isRemove ? null : '#' + palette[1];
                        break;
                    case 'svg':
                        item.style.fill = isRemove ? null : '#' + palette[1];
                        break;
                    case 'bg':
                        item.style.background = isRemove ? null : '#' + palette[1];
                        break;
                    default:
                        break;
                }
            });
        };

        if (setLogoPs != '' && setLogoPs != null && setLogoPs != undefined) {
            inputLogo.src = setLogoPs;
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
                setValidationInput(isValidUrlLogo ? (e.target.id !== getSetColor()) : false, null)
                configColors(palette);
                actionButton();
            })
        })

        inputLogo.addEventListener('input', el => {
            const r = /^(http|https):\/\/[^ "]+$/
            if (r.test(el.target.value)) {
                let image = new Image();
                image.src = el.target.value;

                image.addEventListener('error', () => {
                    setValidationInput(false, false);
                    inputLogo.classList.add('invalid')
                    isValidUrlLogo = false;
                    labelText.style.color = '#D20808';
                    labelText.innerText = checkoutPreviewText.errors.logoInvalid;
                    actionButton();
                });

                image.addEventListener('load', () => {
                    if (styleConfig.urlLogo) {
                        if (styleConfig.urlLogo == el.target.value) {
                            setValidationInput(null, false);
                        }
                    } else if (setLogoPs == el.target.value) {
                        setValidationInput(null, false);
                    } else {
                        setValidationInput(true, true);
                    }
                    logo.src = el.target.value;
                    labelText.innerText = checkoutPreviewText.labelDefault;
                    isValidUrlLogo = true;
                    inputLogo.classList.remove('invalid');
                    labelText.removeAttribute('style');
                    actionButton();
                });
            } else if (el.target.value == '') {
                labelText.innerText = checkoutPreviewText.labelDefault;
                inputLogo.classList.remove('invalid');
                labelText.removeAttribute('style');
                logo.src = checkoutPreviewText.logoDefault;
                if (styleConfig.urlLogo) {
                    if (styleConfig.urlLogo == '') {
                        setValidationInput(true, false);
                    } else {
                        setValidationInput(null, true);
                    }
                } else if (setLogoPs == '') {
                    setValidationInput(true, false);
                } else {
                    setValidationInput(true, true);
                }
                isValidUrlLogo = true;
                actionButton();
            } else {
                isValidUrlLogo = false;
                setValidationInput(false, false);
                inputLogo.classList.add('invalid')
                labelText.style.color = '#D20808';
                labelText.innerText = checkoutPreviewText.errors.logoUrl;
                actionButton();
            }
        });

        action.addEventListener('click', () => {
            actionSvg.classList.toggle('rotate');
            actionContainer.classList.toggle('active');
            // cambiar texto de un span
            if (actionContainer.classList.contains('active')) {
                actionTextVisible.innerText = 'Ver menos combinaciones';
            } else {
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
            jQuery('#CULQI_COLOR_PALETTE').val(styleConfig.primaryColor + '-' + styleConfig.secondaryColor);
            console.log('styleConfig: ', styleConfig)
        });

        Array.from(btnClose).forEach((el) => {
            el.addEventListener('click', (event) => {
                if (styleConfig.urlLogo != undefined) {
                    if (styleConfig.urlLogo != '' && styleConfig.urlLogo != null && styleConfig.urlLogo != undefined) {
                        inputLogo.value = styleConfig.urlLogo;
                        logo.src = styleConfig.urlLogo;
                    } else {
                        inputLogo.value = '';
                        logo.src = checkoutPreviewText.logoDefault;
                    }
                } else {
                    if (setLogoPs != '' && setLogoPs != null && setLogoPs != undefined) {
                        inputLogo.value = setLogoPs;
                        logo.src = setLogoPs;
                    } else {
                        logo.src = checkoutPreviewText.logoDefault;
                        inputLogo.value = '';
                    }
                }
                labelText.innerText = checkoutPreviewText.labelDefault;
                inputLogo.classList.remove('invalid');
                labelText.removeAttribute('style');
                if (styleConfig.primaryColor && styleConfig.secondaryColor) {
                    document.getElementById(styleConfig.primaryColor.slice(1) + '-' + styleConfig.secondaryColor.slice(1)).click()
                    configColors([styleConfig.primaryColor, styleConfig.secondaryColor]);
                } else {
                    if (setPalette != '' && setPalette != null && setPalette != undefined) {
                        document.getElementById(setPalette.replace(new RegExp(/\#/g), '')).click()
                    } else {
                        configColors(setPalette.split('-'), true);

                    }
                }
                setValidationInput(false, false)
                overlay.classList.remove('active');
            });
        });

        btnOpen.addEventListener('click', () => {
            setValidationInput(false, false)
            actionButton();
            if (styleConfig.urlLogo != undefined) {
                if (styleConfig.urlLogo != '' && styleConfig.urlLogo != null && styleConfig.urlLogo != undefined) {
                    inputLogo.value = styleConfig.urlLogo;
                    logo.src = styleConfig.urlLogo;
                } else {
                    inputLogo.value = '';
                    logo.src = checkoutPreviewText.logoDefault;
                }
            } else {
                if (setLogoPs != '' && setLogoPs != null && setLogoPs != undefined) {
                    inputLogo.value = setLogoPs;
                    logo.src = setLogoPs;
                } else {
                    logo.src = checkoutPreviewText.logoDefault;
                    inputLogo.value = '';
                }
            }
            if (styleConfig.primaryColor && styleConfig.secondaryColor) {
                configColors([styleConfig.primaryColor, styleConfig.secondaryColor]);
            } else {
                if (setPalette != '' && setPalette != null && setPalette != undefined) {
                    configColors(setPalette.replace(new RegExp(/\#/g), "").split('-'));
                } else {
                    document.querySelector(".colorPreviewDefault").click()
                    configColors(['', ''], true);
                }
            }
            overlay.classList.add('active')
        })
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
    jQuery(document).ready(function () {
        jQuery('#{$fields_value.CULQI_COLOR_PALETTEID|escape:'
      htmlall ':'
      UTF - 8 '}').click();
        if (document.querySelector('#CULQI_URL_LOGO').value != '') {
            document.querySelector('#logo').src = document.querySelector('#CULQI_URL_LOGO').value;
        }

    });

    function run_waitMe() {
        console.log('run_waitMe');
        $('body').waitMe({
            effect: 'bounce',
            text: 'Cargando. Espere por favor',
            bg: 'rgba(0,0,0,0.7)',
            color: '#fff'
        });
    }
</script>