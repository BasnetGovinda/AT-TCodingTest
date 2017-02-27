#!C:\xampp\perl\bin\perl

use strict;
use JSON;
use DBI;
use CGI;
my $driver = "SQLite"; 
my $database = "db_Appointment.sqlite";
my $dsn = "DBI:$driver:database=$database";
my $userid = "";
my $password = "";
my $cgi = CGI->new;
my $id = $cgi->param('param');
#set the header 
print $cgi->header(-type => "application/json", -charset => "utf-8");
#making the databse connection
my $dbh = DBI->connect($dsn, $userid, $password ) or die $DBI::errstr;

#query to get the data based on the parameter from ajax call
my $sth = $dbh->prepare("SELECT Datetime, Description
                        FROM tbl_Appointment where Description=?
                        ");
  
$sth->execute($id) or die $DBI::errstr;

my @jsondata;
while (my @row = $sth->fetchrow_array()) {
   my ($Datetime, $Description ) = @row;
   #adding the data to the jsondata array
   push @jsondata, ({'Datetime' => $Datetime, 'Description' =>$Description});

}
print encode_json(\@jsondata);
$sth->finish();