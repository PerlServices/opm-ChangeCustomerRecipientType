# --
# Copyright (C) 2019 - 2022 Perl-Services.de, https://www.perl-services.de
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

    ${ $Param{Data} } =~ s{
        <a \s+ href="#" \s+ id="(.{0,3})RemoveCustomerTicket_  .*? </a> \K
    }{
        $Self->_AddButtons( Type => $1 );
    }exmsg;

    return 1;
}

sub _AddButtons {
    my ( $Self, %Param ) = @_;

    Kernel::LOG( \%Param );
}

1;
