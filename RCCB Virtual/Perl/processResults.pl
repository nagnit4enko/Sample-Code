#!/usr/bin/perl -w

use strict;
use warnings;

use CGI;
*CGI::br = sub { '<br />' };

my $q = CGI->new();

# Uncomment this line if you want to print out every value MyGate sends back.
# print $name . ' => ' . $query->param($name) for my $name ( $query->param );

# Populate PHP variables with the POST back variables MyGate sends
my $result       = $q->param('_RESULT');
my $errorCode    = $q->param('_ERROR_CODE');
my $errorSource  = $q->param('_ERROR_SOURCE');
my $errorMessage = $q->param('_ERROR_MESSAGE');
my $errorDetail  = $q->param('_ERROR_DETAIL');

my $variable1 = $q->param('VARIABLE1');

my $bankErrorCode    = $q->param('_BANK_ERROR_CODE');
my $bankErrorMessage = $q->param('_BANK_ERROR_MESSAGE');

my $cardCountry  = $q->param('_CARDCOUNTRY');
my $price        = $q->param('TXTPRICE');
my $threedsecure = $q->param('_3DSTATUS');

print $q->header(
    -type    => 'text/html',
    -charset => 'UTF-8',
  ),
  $q->start_html(
    -dtd   => [ '-//W3C//DTD XHTML 1.0 Transitional//EN', 'http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd' ],
    -title => 'Perl MyVirtual Results',
    -meta => { 'Copyright' => 'MyGate Communications (Pty) Ltd 2007', },
  );

# The $_POST['_RESULT'] element of the form post is the transaction result.
#   0=Successful
#   1=Warning
#
# (A result of 1 is returned either when the fraud module is providing a flag
#  or if unnecessary parameters were sent to the API in the request message).
#
# Note: A result code of 1 is still a successful transaction.
if ( $result >= 0 ) {
    print "Successful Transaction",          $q->br();
    print "Card Country: $cardCountry",      $q->br();
    print "Processed Amount: $price",        $q->br();
    print "3D-Secure Status: $threedsecure", $q->br();
    print "Custom Variable: $variable1",     $q->br();
}
else {
    ## In the event of a failed transaction, most merchants will only display
    # the bank error message to the client as this will often give the most
    # descriptive message relevant to the client.
    # E.g. Insufficient funds, Blocked Card, etc.
    print "Failed Transaction",                    $q->br();
    print "Error Code: $errorCode",                $q->br();
    print "Error Message: $errorMessage",          $q->br();
    print "Error Details: $errorDetail",           $q->br();
    print "Custom Variable: $variable1",           $q->br(), $q->br();
    print "Bank Error Code: $bankErrorCode",       $q->br();
    print "Bank Error Message: $bankErrorMessage", $q->br();
}

print $q->end_html();

=head1 NAME
 
 processResults.pl - MyGate Communications example
 
 =head1 LICENCE
 
 +---------------------------------------------------------------------------+
 | MyGate Communications - Perl Enterprise Auth and Settle Sample            |
 | Copyright (c) 2007 MyGate Communications (Pty) Ltd                  		 |
 | All rights reserved.                                                      |
 +---------------------------------------------------------------------------+
 | The initial developer of the original code is MyGate Global		         |
 +---------------------------------------------------------------------------+
 
 * "Perl MyVirtual Sample" payment page
 *
 * @category   Code Sample
 * @package    MyGate Communications (Pty) Ltd
 * @subpackage Virtual Transaction (Please contact MyGate to enable immediate settlement if your account requires it)
 * @author     MyGate Global
 * @copyright  Copyright (c) 2007 MyGate Communications (Pty) Ltd
 * @link       http://www.mygateglobal.com/
 * 
 * @Note	   This code serves as an example only. It is not recommended that you use this code for production purposes.
 
 
 =cut

