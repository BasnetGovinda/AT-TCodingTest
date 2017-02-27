#!C:\xampp\perl\bin\perl

use strict;
use DBI;
use CGI;
my $driver = "SQLite"; 
my $database = "db_Appointment.sqlite";
my $dsn = "DBI:$driver:database=$database";
my $userid = "";
my $password = "";
my $q = new CGI;
my $date = $q->param('datepicker');
my $time=$q->param('timepicker');
my $desc=$q->param('desc');
#concat the date and time in single string
my $datetime=$date."=".$time;
#make database conection
my $dbh = DBI->connect($dsn, $userid, $password ) or die $DBI::errstr;

#insert data based on the ui form
my $sth = $dbh->prepare("INSERT INTO tbl_Appointment
                       (Datetime, Description)
                        values
                       ('$datetime', '$desc')");
$sth->execute() or die $DBI::errstr;
$sth->finish();
$dbh->commit or die $DBI::errstr;

#redirect the page to the home page
 print "Location:http://localhost/Appointment-App/\n\n";