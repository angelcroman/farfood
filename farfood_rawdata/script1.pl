#!/usr/bin/perl
$file='compound_smiles.txt';
open(INFO,$file);
@lines=<INFO>;
close(INFO);

foreach $lines (@lines)
{
	open(OUT, '>', 'temp.smi');
	chomp $lines;
	@row=split(/\t/,$lines);
	print OUT "$row[2]\n";
	#print "$row[2]\n";
	close(OUT);
	system('babel drug_structures_chembl.fs test_out.sdf -s temp.smi -at0.7 --append "chembl_id"');
	system('babel temp.smi test_out.sdf -ofpt > temp2.txt');
	system('rm test_out.sdf');
	system('rm temp.smi');
	open(INFO2,'temp2.txt');
	@lines2=<INFO2>;
	close(INFO2);
	foreach $lines2 (@lines2)
	{
		chomp $lines2;
		@set=split(/= /, $lines2);
		if ($set[1]>=0.7)
		{
			@set2=split(/   /, $set[0]);
			@set3=split(/CHEMBL/, $set2[0]);
			print "$row[0]\t$row[1]\tCHEMBL$set3[1]\t$set[1]\n";
		}
	}

}


