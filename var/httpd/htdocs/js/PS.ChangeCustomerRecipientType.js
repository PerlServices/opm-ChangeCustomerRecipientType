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
        var AddTicketCustomerFunc = Core.Agent.CustomerSearch.AddTicketCustomer;

        Core.Agent.CustomerSearch.AddTicketCustomer = function( Field, CustomerValue, CustomerKey, SetAsTicketCustomer ) {
            var OrigReturn = AddTicketCustomerFunc( Field, CustomerValue, CustomerKey, SetAsTicketCustomer );
            
            $('.ChangeRecipientType').off('click').on('click', function() {
                var From = $(this).data('from');
                if ( From === "To" ) {
                    From = "";
                }

                var To = $(this).data('to');

                var Counter       = ( $(this).attr('id').split("_") )[1];
                var CustomerKey = $('#' + From + 'CustomerTicketText_' + Counter).val();
                var CustomerLogin = $('#' + From + 'CustomerKey_' + Counter).val();

                $('#' + From + 'RemoveCustomerTicket_' + Counter).trigger('click');
                Core.Agent.CustomerSearch.AddTicketCustomer( To + "Customer", CustomerKey, CustomerLogin, false );

                return false;
            });

            return OrigReturn;
        };
    };

    Core.Init.RegisterNamespace(TargetNS, 'APP_MODULE');

    return TargetNS;
}(PS.ChangeCustomerRecipientType || {}));
