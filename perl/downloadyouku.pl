#!/usr/bin/perl -w
use strict;
use Digest::MD5 qw/md5_hex/;

sub download {
	my ($id, $ans, $file, $dir) = @_, my $cnt = 0;
	for (my $i = 0; defined ($_ = $file->[$i]); $i++) {
		if (/^<\/stream>/) {
			$cnt++;
		}
		elsif ($cnt == $ans && /url="(.+)"/) {
			next if fork();
			while (1) {
				qx/wget -P $dir -U Xeslaro -t 3 '$1'/;
				exit unless $?;
				@$file = api_rest($id);
				$file->[$i] =~ /url="(.+)"/;
			}
		}
	}
	while (wait() != -1) {
	}
}
sub api_rest {
	$_ = shift;
	/id_(.+)\.html/;
	while (1) {
		my $time = time();
		my $auth = md5_hex((time().' XOA== MWZlNWE4Y2Q4OWQ0NjEyMWJjZTJmMWNiYTVhNzQwZGM='));
		my $url = "http://api.youku.com/api_rest?method=video.getvideofile&pid=XOA==&ctime=$time&auth=$auth&videoid=$1";
		my @file = qx/wget -U Xeslaro -O - -t 1 '$url'/;
		return @file if (!$? && grep(/<\/stream>/, @file) >= 1);
	}
}
foreach (@ARGV) {
	my $dir = "/tmp/youku".time();
	qx{
		if [[ ! -d $dir ]]; then
			mkdir $dir
            else
			rm -r $dir
            fi
	};
	my @files = api_rest($_), my $name, my $cnt=0, my $ans=0, my $min ,my $file;
	my %rank = (
		hd2 => 0,
		mp4 => 1,
		flv => 2,
		flvhd => 3,
		'3gphd' => 4,
		'3gp' => 5,
        );
	foreach (@files) {
		if (/CDATA\[(.+)\]\]/) {
			$name = $1;
		}
		elsif (/type="(.+)">/) {
			if (!$cnt) {
				$min = $rank{$1};
			}
			elsif ($rank{$1} < $min) {
				$ans = $cnt;
			}
			$cnt++;
		}
	}
	if (fork()) {
		print "downloading $name begins...\n";
		next;
	}
	download($_, $ans, \@files, $dir);
    if (-e $dir){
        print "exits\n\n";
    }
    opendir (mydirFH ,$dir);
    @files = readdir (mydirFH);    
	# @file = qx/ls -l $dir\/*.*/;
    foreach $file (@files){
        if ($file =~ /\.\.?/){
            next;
        }
     $file =~ /\.(.+)$/;
     print $file , "\n";
     $file =~ s/(\?|&|;)/\\$1/g;
        print $file , "\n";
     qx/mencoder $dir\/$file -oac mp3lame -ovc copy -of lavf -lavfopts format=mp4 -o '$name'.mp4/;    
    }
	# else {
	# 	qx/mv $dir\/$file[0] '$name'.$1/;
	# }
	# qx/rm -r $dir/;
	print "$name downloaded...\n";
	exit;
} continue {
	sleep 1;
}
while (wait() != -1) {
}
