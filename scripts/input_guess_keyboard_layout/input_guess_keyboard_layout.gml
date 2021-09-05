//Keyboard latin layout hint
//Returns string indicating guessed keyboard layout (QWERTY, AZERTY, QWERTZ)
//Data source: https://docs.microsoft.com/windows-hardware/manufacture/desktop/default-input-locales-for-windows-language-packs
function input_guess_keyboard_layout()
{
    //Resolve language region to it's default Latin keyboard layout
    var _locale = os_get_language() + "-" + os_get_region();
    switch(_locale)
    {
        case "en-US": case "en-":
        case "en-GB": case "-":
            return "QWERTY";
        break;

        case "ar-DZ": case "ar-MA": case "ar-TN":
        case "fr-BE": case "fr-FR": case "fr-MC":
        case "co-FR": case "oc-FR": case "ff-SN": 
        case "wo-SN": case "gsw-FR": 
        case "nl-BE": case "tzm-DZ":
            return "AZERTY";
        break;  

        case "cs-CZ": case "de-AT": case "de-CH": 
        case "de-DE": case "de-LI": case "de-LU": 
        case "fr-CH": case "fr-LU": case "sq-AL":
        case "hr-BA": case "hr-HR": case "hu-HU":
        case "lb-LU": case "rm-CH": case "sk-SK": 
        case "sl-SI": case "dsb-DE":
        case "sr-BA": case "hsb-DE":
            return "QWERTZ";
        break;

        default:
            return "QWERTY";
        break;
    }
}