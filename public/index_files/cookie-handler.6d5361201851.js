window.addEventListener('load', function() {
    const api = window.elbphilharmonie.consent;

    var gtmCookie = document.getElementById("gtm").innerHTML;
    var gtmActivated = gtmCookie.replace(/<!--if-consent|endif-->|\n-->/g, '');

    if (api.getConsent('google_analytics')) {
        console.log('Tagmanager bereits aktiv');
        $("#gtm").html(gtmActivated); 

    }
    api.onEvent('consentChanged', function() {
        if (api.getConsent('google_analytics')) {
            console.log('Tagmanager aktiv');
            $("#gtm").html(gtmActivated); 
    

        } else {
            console.log('Tagmanager inaktiv');
            location.reload();
            return false;
        }
    });
});




