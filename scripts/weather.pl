# Weather Script
sub get_weather {
	my @cmd  = @_;
	if (!$cmd[1]) {
		return $str = "Please try ~weather zipcode/city,country";
	}
	if ($cmd[1] eq "help") {
		$str = "Use it like this: ~weather zipcode or ~weather city,country";
		$str .= " If the city has a space in it, use an underscore.  i.e., ~weather San_Diego,California";
		return $str;
	}
	my $ua = LWP::UserAgent->new;
	$ua->agent('Mozilla/5.0');
	my $str;
	my $ctemp;
	$ua->timeout(10);
	my $url = 'http://38.102.136.104/auto/raw/'.$cmd[1];
	my $results = $ua->get($url);
	my @weather = split(/[|]\s*/, $results->content);
	if (!$results->is_success) {
		$str = "Sorry, no weather available for your location, For help and formatting use: ~weather help";
	}
	elsif (!$weather[0]) {
		$str = "Sorry, no weather available for your location, For help and formatting use: ~weather help";
	}
	else {
		if ($weather[1] eq "") { 
			$str = "\002Conditions for $weather[18], $weather[19] at $weather[0]:\002 $weather[8] \002Temp:\002 $weather[1] F ";
			$str .= "\002Humidity:\002 $weather[4] \002Barometer:\002 $weather[7] \002Wind:\002 $weather[6] mph";
		}
		else {
			my $ctemp = sprintf( "%4.1f", ($weather[1] - 32) * (5 / 9) );
			$str = "\002Conditions for $weather[18], $weather[19] at $weather[0]:\002 $weather[8] \002Temp:\002 $weather[1] F/$ctemp C ";
			$str .= "\002Humidity:\002 $weather[4] \002Barometer:\002 $weather[7] \002Wind:\002 $weather[6] mph";
		}

	}
	return $str;
}		
return 1; #return true