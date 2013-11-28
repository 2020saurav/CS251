#!/usr/bin/perl
use Switch;

if($ARGV[0] eq '-i') #insert opertation needed
{
	
	$query= "insert into salaries values (\"$ARGV[1]\",\"$ARGV[2]\",\"$ARGV[3]\",\"$ARGV[4]\")".";";
}

elsif($ARGV[0] eq '-u') # for update operation
{
	shift(@ARGV);	# jumps '-u'
	$field_name = shift(@ARGV);	# field name
	$cond = shift(@ARGV);   # condition
	# if command is : perl test.pl -u emp_no 100001:100010 salary 30000
	# field_name = emp_no, cond = 100001:100010

	$query="update salaries set "; # basic query structure

	if($#ARGV==0)	# incase command is: update salary set salary 5000 6000, leaves only 1 argument
	{
		$new_value = shift(@ARGV);
		$query= $query.$field_name."=".$newvalue;
	}

	else 
	{
		for($i=0; $i<=$#ARGV; $i=$i+2) # command is : perl test.pl -u emp_no 100001:100010 salary 30000
		{	
			$arg = $ARGV[$i]; #field name whose values are to be updated
			$new_value = $ARGV[$i+1]; # new value
			$query = $query.$arg."=".$new_value."," ;
		}
	
		$query  =substr ($query, 0,-1) ; # remove last comma from query structure
	}

	$query_cond = condition($first,$cond);
	
	
	$query=$query." where ".$query_cond.";" ;
	
}
else # select operation
{
	$query="select * from salaries where ";
	
	for($i=0;$i<=$#ARGV;$i=$i+3)
	{
			
		$field=$ARGV[$i+1];
		
		$cond=$ARGV[$i+2];
		
		$q_cond=condition($field,$cond);
		#print $q_cond;	
		$query=$query." ( ".$q_cond." ) and ";
		
	}
	
	$query=substr($query, 0 , -4).";";
	
}		
		
#print $query;
`touch query1.sql`;

open(file, ">query1.sql");
print file "use employees;".$query;
#system "cat query1.txt";
print `mysql -u saurav <query1.sql`;
close(file);

#system " cat output.txt ";
system " rm query1.sql ";


sub condition
{
	$str="";
	$field=shift(@_);
	$cond=shift(@_);
	#print $cond."\n" ;
	@conds=split(",",$cond);
	foreach $val (@conds)
	{
	@div=split(":",$val);
	if($#div eq 0)
	{ $str=$str." ".$field." between \"".$val."\" and \"".$val."\" or" }
	

	else
	{ $str=$str." ".$field." between \"".$div[0]."\" and \"".$div[1]."\" or" ; }
	
	}
	$str=substr($str, 0,-3);
	#print $str."\n";
	return $str;		
}		
	 
exit;
