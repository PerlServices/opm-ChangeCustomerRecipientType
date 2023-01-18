# --
# Copyright (C) 2019 - 2023 Perl-Services.de, https://www.perl-services.de
# --
# This software comes with ABSOLUTELY NO WARRANTY. For details, see
# the enclosed file COPYING for license information (AGPL). If you
# did not receive this file, see http://www.gnu.org/licenses/agpl.txt.
# --

package Kernel::Output::HTML::FilterElementPost::ChangeCustomerRecipientType;

use strict;
use warnings;

our @ObjectDependencies = qw(
    Kernel::Config
    Kernel::Language
    Kernel::Output::HTML::Layout
    Kernel::System::Web::Request
);

sub new {
    my ( $Type, %Param ) = @_;

    # allocate new hash for object
    my $Self = {};
    bless( $Self, $Type );

    return $Self;
}

sub Run {
    my ( $Self, %Param ) = @_;

    my $LanguageObject = $Kernel::OM->Get('Kernel::Language');
    my $LayoutObject   = $Kernel::OM->Get('Kernel::Output::HTML::Layout');
    my $ParamObject    = $Kernel::OM->Get('Kernel::System::Web::Request');
    my $ConfigObject   = $Kernel::OM->Get('Kernel::Config');
    my $ArticleObject  = $Kernel::OM->Get('Kernel::System::Ticket::Article');

    # get template name
    my $Templatename = $Param{TemplateFile} || '';

    return 1 if !$Templatename;
    return 1 if !$Param{Templates}->{$Templatename};

    my $ButtonType = $ConfigObject->Get('ChangeRecipientType::ButtonType') || '';

    ${ $Param{Data} } =~ s{
        <a \s+ href="\#" \s+ id="(.{0,3})RemoveCustomerTicket  .*? </a> \K
    }{
        $Self->_AddButtons( Type => $1, Buttons => $ButtonType );
    }exmsg;

    if ( $ButtonType eq 'Text' ) {
        ${ $Param{Data} } =~ s{
            id=["'](?:Cc|Bcc)?CustomerTicketText(?:_.*?)?["'] \K
        }{
            style="width: 60%"
        }xmsg;
    }

    return 1;
}

sub _AddButtons {
    my ( $Self, %Param ) = @_;

    if ( $Param{Buttons} eq 'Text' ) {
        return $Self->_AddTextButtons( %Param );
    }
    else {
        return $Self->_AddIconButtons( %Param );
    }
}

sub _AddTextButtons {
    my ( $Self, %Param ) = @_;

    my $Type    = $Param{Type} || 'To';
    my %Buttons = (
        To  => [ 'Cc', 'Bcc' ],
        Cc  => [ 'To', 'Bcc' ],
        Bcc => [ 'To', 'Cc'  ],
    );

    my $ButtonsHTML = '';
    for my $Button ( @{ $Buttons{$Type} || [] } ) {
        $ButtonsHTML .= sprintf qq~
            <a href="#" class="ChangeRecipientType" data-to="$Button" data-from="$Type"
                id="${Type}ChangeRecipientType" name="${Type}ChangeRecipientType">
                &gt; $Button
            </a>
        ~;
    }

    return $ButtonsHTML;
}

sub _AddIconButtons {
    my ( $Self, %Param ) = @_;

    my $Type    = $Param{Type} || 'To';
    my %Buttons = (
        To  => [ [ 'Cc', 'angle-down'      ], [ 'Bcc', 'angle-double-down'] ],
        Cc  => [ [ 'To', 'angle-up'        ], [ 'Bcc', 'angle-down'       ] ],
        Bcc => [ [ 'To', 'angle-double-up' ], [ 'Cc',  'angle-up'         ] ],
    );

    my $ButtonsHTML = '';
    for my $Button ( @{ $Buttons{$Type} || [] } ) {
        $ButtonsHTML .= sprintf qq~
            <a href="#" class="ChangeRecipientType" data-to="$Button->[0]" data-from="$Type"
                id="${Type}ChangeRecipientType" name="${Type}ChangeRecipientType">
                <i class="fa fa-$Button->[1]"></i>
                <span class="InvisibleText">$Button->[0]</span>
            </a>
        ~;
    }

    return $ButtonsHTML;
}

1;
