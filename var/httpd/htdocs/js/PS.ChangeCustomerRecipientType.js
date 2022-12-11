// --
// PS.ChangeCustomerRecipientType.js 
// --
// This software comes with ABSOLUTELY NO WARRANTY. For details, see
// the enclosed file COPYING for license information (AGPL). If you
// did not receive this file, see http://www.gnu.org/licenses/agpl.txt.
// --

"use strict";

var PS = PS || {};

/**
 * @namespace
 * @exports TargetNS as PS.ChangeCustomerRecipientType
 * @description
 *      This namespace contains the special module functions for the time tracking add on
 */
PS.ChangeCustomerRecipientType = (function (TargetNS) {
    TargetNS.Init = function() {
    };

    Core.Init.RegisterNamespace(TargetNS, 'APP_MODULE');

    return TargetNS;
}(PS.ChangeCustomerRecipientType || {}));
