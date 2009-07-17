package Dancer;

use strict;
use warnings;
use vars qw($VERSION @EXPORT);

use Dancer::Registry;
use HTTP::Server::Simple::CGI;
use base 'Exporter', 'HTTP::Server::Simple::CGI';

@EXPORT = qw(get);

sub handle_request {
    my ($self, $cgi) = @_;

    my $path = $cgi->path_info();
    my $handler = Dancer::Registry->find_route($path);

    if ($handler) {
        print $cgi->header('text/plain');
        print Dancer::Registry->call_route($handler), "\n";
    } 
    else {
        print "HTTP/1.0 404 Not found\r\n";
        print $cgi->header,
              $cgi->start_html('Not found'),
              $cgi->h1('Not found'),
              $cgi->end_html;
    }
}

sub print_banner {
    print "== Entering the dance floor ...\n";
}

sub dance { 
    my $class = shift;
    my ($ipaddr, $port) = ('0.0.0.0', '8080');
    print ">> Listening on $ipaddr:$port\n";
    my $pid = $class->new($port)->run();
}

sub get {
    my ($route, $code) = @_;
    Dancer::Registry->add_route('get', $route, $code);
}

'Dancer';
__END__

=pod 

=head1 NAME

Dancer 

=head1 WARNING

This is under heavy development

=head1 DESCRIPTION

Dancer is framework for writing web application with minimal effort. It was 
inspired by Sinatra, from the Ruby's community.

Dancer is here to provide the simpliest way for writing web application.

=head1 USAGE

As soon as Dancer is imported to a script, that script becomes a webapp.

=head1 TODO

    #!/usr/bin/perl
    use Dancer;

    get '/' => sub { 
        "Hello World";
    };

    get '/hello/:name' => sub {
        "Hello ".$params{name}"
    };


=cut
