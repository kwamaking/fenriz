#Wikipedia script
sub wiki {
	my ($server, $target, @cmd) = @_;
	if (!$cmd[1]) {
		my $str = 'Please include a search term.';
		send_msg($server, $target, $str);
	}
	else {
		my $ua = LWP::UserAgent->new;
		$ua->agent("libwww-perl/6.02");
		my $entry;
		my $indexsize = scalar(@cmd);
		my $term = join("+",splice(@cmd,1,$indexsize));
		my $url = 'http://en.wikipedia.org/w/api.php?action=query&prop=extracts&format=json&exintro=1&explaintext=1&exchars=350&titles='.$term;
		my $tinyurl = bitly("http://en.wikipedia.org/wiki/$term");
		my $content = $ua->get($url);
		if (!$content->is_success) {
			$entry = 'Wikipedia appears to be down or there was a problem fetching the URL';
		}
		else {
			my $decoded_content = decode_json($content->content);
			my %decoded_hash = %{$decoded_content->{'query'}{'pages'}};
			my @page = keys %decoded_hash;
			if ($decoded_content->{'query'}{'pages'}{$page[0]}{'extract'} eq "") {
				$entry = $entry = $decoded_content->{'query'}{'pages'}{$page[0]}{'title'}.': Either doesn\'t exist or too many results';
				$entry .= ' For more information visit: '.$tinyurl;
			}
			else {
				$entry = $decoded_content->{'query'}{'pages'}{$page[0]}{'title'}.': '.$decoded_content->{'query'}{'pages'}{$page[0]}{'extract'}.'...'; 
				$entry .= ' For more information visit: '.$tinyurl;
			}
		}
		return send_msg($server, $target, $entry);
	}
}

return 1; #return true