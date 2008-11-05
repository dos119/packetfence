#
# Copyright 2007-2008 Inverse groupe conseil
#
# See the enclosed file COPYING for license information (GPL).
# If you did not receive this file, see
# http://www.fsf.org/licensing/licenses/gpl.html
#
#

package pf::SNMP::3COM;

=head1 NAME

pf::SNMP::3COM - Object oriented module to access SNMP enabled 3COM
switches


=head1 SYNOPSIS

The pf::SNMP::3COM module implements an object oriented interface
to access SNMP enabled 3COM switches.

=cut

use strict;
use warnings;
use diagnostics;

use base ('pf::SNMP');
use Log::Log4perl;
use Net::SNMP;

sub parseTrap {
    my ($this, $trapString) = @_;
    my $trapHashRef;
    my $logger = Log::Log4perl::get_logger(ref($this));
    if ($trapString =~ /BEGIN TYPE ([23]) END TYPE BEGIN SUBTYPE 0 END SUBTYPE BEGIN VARIABLEBINDINGS \.1\.3\.6\.1\.2\.1\.2\.2\.1\.2\.(\d+) = /) {
        $trapHashRef->{'trapType'} = (($1 == 2) ? "down" : "up");
        $trapHashRef->{'trapIfIndex'} = $2;
    } else {
        $logger->debug("trap currently not handled");
        $trapHashRef->{'trapType'} = 'unknown';
    }
    return $trapHashRef;
}

sub getDot1dBasePortForThisIfIndex {
    my ($this, $ifIndex) = @_;
    my $logger = Log::Log4perl::get_logger(ref($this));
    my $ifIndexDot1dBasePortHash = { 
        102 => 1,
        103 => 2,
        104 => 3,
        105 => 4 };
    return $ifIndexDot1dBasePortHash->{$ifIndex};

}

sub _setVlan {
    my ($this,$ifIndex,$newVlan,$oldVlan,$switch_locker_ref) = @_;
    my $logger = Log::Log4perl::get_logger(ref($this));
    return $this->_setVlanByOnlyModifyingPvid($ifIndex,$newVlan,$oldVlan,$switch_locker_ref);
}

sub _getMacAtIfIndex {
    my ($this,$ifIndex,$vlan) = @_;
    my $logger = Log::Log4perl::get_logger(ref($this));
    my @macArray;
    if (! $this->connectRead()) {
        return @macArray;
    }
    my %macBridgePortHash = $this->getMacBridgePortHash();
    my $dot1dBasePort = $this->getDot1dBasePortForThisIfIndex($ifIndex);
    foreach my $_mac (keys %macBridgePortHash) {
        if ($macBridgePortHash{$_mac} eq $dot1dBasePort) {
            push @macArray, $_mac;
        }
    }
    return @macArray;
}

1;

# vim: set shiftwidth=4:
# vim: set expandtab:
# vim: set backspace=indent,eol,start:
