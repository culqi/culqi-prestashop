
/*MASTERCARD*/
const fnMcSonic = (success_url) => {
    $('body').append(`<div id="brandMastercard">
    <mc-sonic id="mc-sonic" style="height: 40%;" type="default" clear-background></mc-sonic> </div>`);
    const time = 2000;
    document.addEventListener('sonicCompletion', onCompletion(success_url, time));
    let mc_component = document.getElementById("mc-sonic");
    $('body').waitMe('hide');
    mc_component.play();
};

const onCompletion = (success_url, time = 1) => {
    setTimeout(() => {
       location.href = success_url;
    }, time);
};

/*VISA*/
const fnBrandvisa = (success_url) => {
    $('body').html(`<div id="brand-wrapper">
        <div id="visa-sensory-branding"></div>
    </div>`);

    VisaSensoryBranding.init({}, 
    `${modulePath}/visa/VisaSensoryBrandingSDK`);

    document.getElementById('visa-sensory-branding').addEventListener('visa-sensory-branding-end', function(e) {
        setTimeout(() => {
            run_waitMe('transparent');
            onCompletion(success_url);
        }, 500);
    });

    $('body').addClass('showVisa');
    setTimeout(function() { 
        VisaSensoryBranding.show();
    }, 100);
};