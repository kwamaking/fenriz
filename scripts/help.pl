#help file
sub help {
	my ($server, $target, $nick, @cmd) = @_;
	my $commandtype = 'notice';
	my @help = (
		'--List of available commands::Brackets indicate optional parameter--',
		'--Last FM Commands:',
		'~np [username]       - shows your currently playing song, or of another user if specified',
		'~compare u1 [u2]     - compares yourself with u1 (another user) if u2 isn\'t specified',
		'~setuser user        - associates the "user" last.fm username with your nickname.',
		'~top [user]  - Shows recent top artists of the user',
		'~whois username      - given a last.fm username, return all nicknames that are associated to it.',
		'~deluser             - removes your last.fm association.',
		'~band artist         - displays information about given band or artist',
		'~plays artist        - displays playcount of given artist',
		'--Weather Commands:',
		'~weather zip         - you will receive a notice with current weather conditions.',
		'@weather zip         - this broadcasts weather conditions into the channel',
		'~weather help        - this displays some helpful hints for getting the weather',
		'--Urban Dictionary Commands:',
		'~ud term             - returns a few lines from urban dictionary with specified term',
		'--Wikipedia:',
		'~wiki term           - returns a few lines wikipedia with specified term',
		'--Down for everyone or just me?:',
		'~checksite website   - Checks if a website is up or down',
	);
	for (@help) { #sends each element in array to window until it's empty
		send_msg_alt($server, $nick, $_, $commandtype);
	}
	return send_msg($server, $target, "$nick: help sent.");
}

return 1; #return true