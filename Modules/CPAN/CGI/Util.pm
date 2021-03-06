package CGI::Util;

use strict;
use vars qw($VERSION @EXPORT_OK @ISA $EBCDIC @A2E @E2A);
require Exporter;
@ISA = qw(Exporter);
@EXPORT_OK = qw(rearrange make_attributes unescape escape expires);

$VERSION = '1.2';

$EBCDIC = "\t" ne "\011";
if ($EBCDIC) {
if ("~" eq "\xff") {
# POSIX-BC (BS2000)
# Bijective ascii-to-ebcdic table:
@A2E = (
0x00, 0x01, 0x02, 0x03, 0x37, 0x2d, 0x2e, 0x2f,
0x16, 0x05, 0x15, 0x0b, 0x0c, 0x0d, 0x0e, 0x0f,
0x10, 0x11, 0x12, 0x13, 0x3c, 0x3d, 0x32, 0x26,
0x18, 0x19, 0x3f, 0x27, 0x1c, 0x1d, 0x1e, 0x1f,
0x40, 0x5a, 0x7f, 0x7b, 0x5b, 0x6c, 0x50, 0x7d,
0x4d, 0x5d, 0x5c, 0x4e, 0x6b, 0x60, 0x4b, 0x61,
0xf0, 0xf1, 0xf2, 0xf3, 0xf4, 0xf5, 0xf6, 0xf7,
0xf8, 0xf9, 0x7a, 0x5e, 0x4c, 0x7e, 0x6e, 0x6f,
0x7c, 0xc1, 0xc2, 0xc3, 0xc4, 0xc5, 0xc6, 0xc7,
0xc8, 0xc9, 0xd1, 0xd2, 0xd3, 0xd4, 0xd5, 0xd6,
0xd7, 0xd8, 0xd9, 0xe2, 0xe3, 0xe4, 0xe5, 0xe6,
0xe7, 0xe8, 0xe9, 0xbb, 0xbc, 0xbd, 0x6a, 0x6d,
0x4a, 0x81, 0x82, 0x83, 0x84, 0x85, 0x86, 0x87,
0x88, 0x89, 0x91, 0x92, 0x93, 0x94, 0x95, 0x96,
0x97, 0x98, 0x99, 0xa2, 0xa3, 0xa4, 0xa5, 0xa6,
0xa7, 0xa8, 0xa9, 0xfb, 0x4f, 0xfd, 0xff, 0x07,
0x20, 0x21, 0x22, 0x23, 0x24, 0x04, 0x06, 0x08,
0x28, 0x29, 0x2a, 0x2b, 0x2c, 0x09, 0x0a, 0x14,
0x30, 0x31, 0x25, 0x33, 0x34, 0x35, 0x36, 0x17,
0x38, 0x39, 0x3a, 0x3b, 0x1a, 0x1b, 0x3e, 0x5f,
0x41, 0xaa, 0xb0, 0xb1, 0x9f, 0xb2, 0xd0, 0xb5,
0x79, 0xb4, 0x9a, 0x8a, 0xba, 0xca, 0xaf, 0xa1,
0x90, 0x8f, 0xea, 0xfa, 0xbe, 0xa0, 0xb6, 0xb3,
0x9d, 0xda, 0x9b, 0x8b, 0xb7, 0xb8, 0xb9, 0xab,
0x64, 0x65, 0x62, 0x66, 0x63, 0x67, 0x9e, 0x68,
0x74, 0x71, 0x72, 0x73, 0x78, 0x75, 0x76, 0x77,
0xac, 0x69, 0xed, 0xee, 0xeb, 0xef, 0xec, 0xbf,
0x80, 0xe0, 0xfe, 0xdd, 0xfc, 0xad, 0xae, 0x59,
0x44, 0x45, 0x42, 0x46, 0x43, 0x47, 0x9c, 0x48,
0x54, 0x51, 0x52, 0x53, 0x58, 0x55, 0x56, 0x57,
0x8c, 0x49, 0xcd, 0xce, 0xcb, 0xcf, 0xcc, 0xe1,
0x70, 0xc0, 0xde, 0xdb, 0xdc, 0x8d, 0x8e, 0xdf
      );
# Bijective ebcdic-to-ascii table:
@E2A = (
0x00, 0x01, 0x02, 0x03, 0x85, 0x09, 0x86, 0x7f,
0x87, 0x8d, 0x8e, 0x0b, 0x0c, 0x0d, 0x0e, 0x0f,
0x10, 0x11, 0x12, 0x13, 0x8f, 0x0a, 0x08, 0x97,
0x18, 0x19, 0x9c, 0x9d, 0x1c, 0x1d, 0x1e, 0x1f,
0x80, 0x81, 0x82, 0x83, 0x84, 0x92, 0x17, 0x1b,
0x88, 0x89, 0x8a, 0x8b, 0x8c, 0x05, 0x06, 0x07,
0x90, 0x91, 0x16, 0x93, 0x94, 0x95, 0x96, 0x04,
0x98, 0x99, 0x9a, 0x9b, 0x14, 0x15, 0x9e, 0x1a,
0x20, 0xa0, 0xe2, 0xe4, 0xe0, 0xe1, 0xe3, 0xe5,
0xe7, 0xf1, 0x60, 0x2e, 0x3c, 0x28, 0x2b, 0x7c,
0x26, 0xe9, 0xea, 0xeb, 0xe8, 0xed, 0xee, 0xef,
0xec, 0xdf, 0x21, 0x24, 0x2a, 0x29, 0x3b, 0x9f,
0x2d, 0x2f, 0xc2, 0xc4, 0xc0, 0xc1, 0xc3, 0xc5,
0xc7, 0xd1, 0x5e, 0x2c, 0x25, 0x5f, 0x3e, 0x3f,
0xf8, 0xc9, 0xca, 0xcb, 0xc8, 0xcd, 0xce, 0xcf,
0xcc, 0xa8, 0x3a, 0x23, 0x40, 0x27, 0x3d, 0x22,
0xd8, 0x61, 0x62, 0x63, 0x64, 0x65, 0x66, 0x67,
0x68, 0x69, 0xab, 0xbb, 0xf0, 0xfd, 0xfe, 0xb1,
0xb0, 0x6a, 0x6b, 0x6c, 0x6d, 0x6e, 0x6f, 0x70,
0x71, 0x72, 0xaa, 0xba, 0xe6, 0xb8, 0xc6, 0xa4,
0xb5, 0xaf, 0x73, 0x74, 0x75, 0x76, 0x77, 0x78,
0x79, 0x7a, 0xa1, 0xbf, 0xd0, 0xdd, 0xde, 0xae,
0xa2, 0xa3, 0xa5, 0xb7, 0xa9, 0xa7, 0xb6, 0xbc,
0xbd, 0xbe, 0xac, 0x5b, 0x5c, 0x5d, 0xb4, 0xd7,
0xf9, 0x41, 0x42, 0x43, 0x44, 0x45, 0x46, 0x47,
0x48, 0x49, 0xad, 0xf4, 0xf6, 0xf2, 0xf3, 0xf5,
0xa6, 0x4a, 0x4b, 0x4c, 0x4d, 0x4e, 0x4f, 0x50,
0x51, 0x52, 0xb9, 0xfb, 0xfc, 0xdb, 0xfa, 0xff,
0xd9, 0xf7, 0x53, 0x54, 0x55, 0x56, 0x57, 0x58,
0x59, 0x5a, 0xb2, 0xd4, 0xd6, 0xd2, 0xd3, 0xd5,
0x30, 0x31, 0x32, 0x33, 0x34, 0x35, 0x36, 0x37,
0x38, 0x39, 0xb3, 0x7b, 0xdc, 0x7d, 0xda, 0x7e
      );
} else {
# Bijective US-ASCII to EBCDIC (character set IBM-1047) table:
@A2E = (
0x00, 0x01, 0x02, 0x03, 0x37, 0x2d, 0x2e, 0x2f,
0x16, 0x05, 0x15, 0x0b, 0x0c, 0x0d, 0x0e, 0x0f,
0x10, 0x11, 0x12, 0x13, 0x3c, 0x3d, 0x32, 0x26,
0x18, 0x19, 0x3f, 0x27, 0x1c, 0x1d, 0x1e, 0x1f,
0x40, 0x5a, 0x7f, 0x7b, 0x5b, 0x6c, 0x50, 0x7d,
0x4d, 0x5d, 0x5c, 0x4e, 0x6b, 0x60, 0x4b, 0x61,
0xf0, 0xf1, 0xf2, 0xf3, 0xf4, 0xf5, 0xf6, 0xf7,
0xf8, 0xf9, 0x7a, 0x5e, 0x4c, 0x7e, 0x6e, 0x6f,
0x7c, 0xc1, 0xc2, 0xc3, 0xc4, 0xc5, 0xc6, 0xc7,
0xc8, 0xc9, 0xd1, 0xd2, 0xd3, 0xd4, 0xd5, 0xd6,
0xd7, 0xd8, 0xd9, 0xe2, 0xe3, 0xe4, 0xe5, 0xe6,
0xe7, 0xe8, 0xe9, 0xad, 0xe0, 0xbd, 0x5f, 0x6d,
0x79, 0x81, 0x82, 0x83, 0x84, 0x85, 0x86, 0x87,
0x88, 0x89, 0x91, 0x92, 0x93, 0x94, 0x95, 0x96,
0x97, 0x98, 0x99, 0xa2, 0xa3, 0xa4, 0xa5, 0xa6,
0xa7, 0xa8, 0xa9, 0xc0, 0x4f, 0xd0, 0xa1, 0x07,
0x20, 0x21, 0x22, 0x23, 0x24, 0x04, 0x06, 0x08,
0x28, 0x29, 0x2a, 0x2b, 0x2c, 0x09, 0x0a, 0x14,
0x30, 0x31, 0x25, 0x33, 0x34, 0x35, 0x36, 0x17,
0x38, 0x39, 0x3a, 0x3b, 0x1a, 0x1b, 0x3e, 0xff,
0x41, 0xaa, 0x4a, 0xb1, 0x9f, 0xb2, 0x6a, 0xb5,
0xbb, 0xb4, 0x9a, 0x8a, 0xb0, 0xca, 0xaf, 0xbc,
0x90, 0x8f, 0xea, 0xfa, 0xbe, 0xa0, 0xb6, 0xb3,
0x9d, 0xda, 0x9b, 0x8b, 0xb7, 0xb8, 0xb9, 0xab,
0x64, 0x65, 0x62, 0x66, 0x63, 0x67, 0x9e, 0x68,
0x74, 0x71, 0x72, 0x73, 0x78, 0x75, 0x76, 0x77,
0xac, 0x69, 0xed, 0xee, 0xeb, 0xef, 0xec, 0xbf,
0x80, 0xfd, 0xfe, 0xfb, 0xfc, 0xba, 0xae, 0x59,
0x44, 0x45, 0x42, 0x46, 0x43, 0x47, 0x9c, 0x48,
0x54, 0x51, 0x52, 0x53, 0x58, 0x55, 0x56, 0x57,
0x8c, 0x49, 0xcd, 0xce, 0xcb, 0xcf, 0xcc, 0xe1,
0x70, 0xdd, 0xde, 0xdb, 0xdc, 0x8d, 0x8e, 0xdf
      );
# Bijective EBCDIC (character set IBM-1047) to US-ASCII table:
@E2A = (
0x00, 0x01, 0x02, 0x03, 0x85, 0x09, 0x86, 0x7f,
0x87, 0x8d, 0x8e, 0x0b, 0x0c, 0x0d, 0x0e, 0x0f,
0x10, 0x11, 0x12, 0x13, 0x8f, 0x0a, 0x08, 0x97,
0x18, 0x19, 0x9c, 0x9d, 0x1c, 0x1d, 0x1e, 0x1f,
0x80, 0x81, 0x82, 0x83, 0x84, 0x92, 0x17, 0x1b,
0x88, 0x89, 0x8a, 0x8b, 0x8c, 0x05, 0x06, 0x07,
0x90, 0x91, 0x16, 0x93, 0x94, 0x95, 0x96, 0x04,
0x98, 0x99, 0x9a, 0x9b, 0x14, 0x15, 0x9e, 0x1a,
0x20, 0xa0, 0xe2, 0xe4, 0xe0, 0xe1, 0xe3, 0xe5,
0xe7, 0xf1, 0xa2, 0x2e, 0x3c, 0x28, 0x2b, 0x7c,
0x26, 0xe9, 0xea, 0xeb, 0xe8, 0xed, 0xee, 0xef,
0xec, 0xdf, 0x21, 0x24, 0x2a, 0x29, 0x3b, 0x5e,
0x2d, 0x2f, 0xc2, 0xc4, 0xc0, 0xc1, 0xc3, 0xc5,
0xc7, 0xd1, 0xa6, 0x2c, 0x25, 0x5f, 0x3e, 0x3f,
0xf8, 0xc9, 0xca, 0xcb, 0xc8, 0xcd, 0xce, 0xcf,
0xcc, 0x60, 0x3a, 0x23, 0x40, 0x27, 0x3d, 0x22,
0xd8, 0x61, 0x62, 0x63, 0x64, 0x65, 0x66, 0x67,
0x68, 0x69, 0xab, 0xbb, 0xf0, 0xfd, 0xfe, 0xb1,
0xb0, 0x6a, 0x6b, 0x6c, 0x6d, 0x6e, 0x6f, 0x70,
0x71, 0x72, 0xaa, 0xba, 0xe6, 0xb8, 0xc6, 0xa4,
0xb5, 0x7e, 0x73, 0x74, 0x75, 0x76, 0x77, 0x78,
0x79, 0x7a, 0xa1, 0xbf, 0xd0, 0x5b, 0xde, 0xae,
0xac, 0xa3, 0xa5, 0xb7, 0xa9, 0xa7, 0xb6, 0xbc,
0xbd, 0xbe, 0xdd, 0xa8, 0xaf, 0x5d, 0xb4, 0xd7,
0x7b, 0x41, 0x42, 0x43, 0x44, 0x45, 0x46, 0x47,
0x48, 0x49, 0xad, 0xf4, 0xf6, 0xf2, 0xf3, 0xf5,
0x7d, 0x4a, 0x4b, 0x4c, 0x4d, 0x4e, 0x4f, 0x50,
0x51, 0x52, 0xb9, 0xfb, 0xfc, 0xf9, 0xfa, 0xff,
0x5c, 0xf7, 0x53, 0x54, 0x55, 0x56, 0x57, 0x58,
0x59, 0x5a, 0xb2, 0xd4, 0xd6, 0xd2, 0xd3, 0xd5,
0x30, 0x31, 0x32, 0x33, 0x34, 0x35, 0x36, 0x37,
0x38, 0x39, 0xb3, 0xdb, 0xdc, 0xd9, 0xda, 0x9f
      );
    }
}
# Smart rearrangement of parameters to allow named parameter
# calling.  We do the rearangement if:
# the first parameter begins with a -
sub rearrange {
    my($order,@param) = @_;
    return () unless @param;

    if (ref($param[0]) eq 'HASH') {
	@param = %{$param[0]};
    } else {
	return @param 
	    unless (defined($param[0]) && substr($param[0],0,1) eq '-');
    }

    # map parameters into positional indices
    my ($i,%pos);
    $i = 0;
    foreach (@$order) {
	foreach (ref($_) eq 'ARRAY' ? @$_ : $_) { $pos{lc($_)} = $i; }
	$i++;
    }

    my (@result,%leftover);
    $#result = $#$order;  # preextend
    while (@param) {
	my $key = lc(shift(@param));
	$key =~ s/^\-//;
	if (exists $pos{$key}) {
	    $result[$pos{$key}] = shift(@param);
	} else {
	    $leftover{$key} = shift(@param);
	}
    }

    push (@result,make_attributes(\%leftover,1)) if %leftover;
    @result;
}

sub make_attributes {
    my $attr = shift;
    return () unless $attr && ref($attr) && ref($attr) eq 'HASH';
    my $escape = shift || 0;
    my(@att);
    foreach (keys %{$attr}) {
	my($key) = $_;
	$key=~s/^\-//;     # get rid of initial - if present

	# old way: breaks EBCDIC!
	# $key=~tr/A-Z_/a-z-/; # parameters are lower case, use dashes

	($key="\L$key") =~ tr/_/-/; # parameters are lower case, use dashes

	my $value = $escape ? simple_escape($attr->{$_}) : $attr->{$_};
	push(@att,defined($attr->{$_}) ? qq/$key="$value"/ : qq/$key/);
    }
    return @att;
}

sub simple_escape {
  return unless defined(my $toencode = shift);
  $toencode =~ s{&}{&amp;}gso;
  $toencode =~ s{<}{&lt;}gso;
  $toencode =~ s{>}{&gt;}gso;
  $toencode =~ s{\"}{&quot;}gso;
# Doesn't work.  Can't work.  forget it.
#  $toencode =~ s{\x8b}{&#139;}gso;
#  $toencode =~ s{\x9b}{&#155;}gso;
  $toencode;
}

sub utf8_chr ($) {
        my $c = shift(@_);

        if ($c < 0x80) {
                return sprintf("%c", $c);
        } elsif ($c < 0x800) {
                return sprintf("%c%c", 0xc0 | ($c >> 6), 0x80 | ($c & 0x3f));
        } elsif ($c < 0x10000) {
                return sprintf("%c%c%c",
                                           0xe0 |  ($c >> 12),
                                           0x80 | (($c >>  6) & 0x3f),
                                           0x80 | ( $c          & 0x3f));
        } elsif ($c < 0x200000) {
                return sprintf("%c%c%c%c",
                                           0xf0 |  ($c >> 18),
                                           0x80 | (($c >> 12) & 0x3f),
                                           0x80 | (($c >>  6) & 0x3f),
                                           0x80 | ( $c          & 0x3f));
        } elsif ($c < 0x4000000) {
                return sprintf("%c%c%c%c%c",
                                           0xf8 |  ($c >> 24),
                                           0x80 | (($c >> 18) & 0x3f),
                                           0x80 | (($c >> 12) & 0x3f),
                                           0x80 | (($c >>  6) & 0x3f),
                                           0x80 | ( $c          & 0x3f));

        } elsif ($c < 0x80000000) {
                return sprintf("%c%c%c%c%c%c",
                                           0xfe |  ($c >> 30),
                                           0x80 | (($c >> 24) & 0x3f),
                                           0x80 | (($c >> 18) & 0x3f),
                                           0x80 | (($c >> 12) & 0x3f),
                                           0x80 | (($c >> 6)  & 0x3f),
                                           0x80 | ( $c          & 0x3f));
        } else {
                return utf8(0xfffd);
        }
}

# unescape URL-encoded data
sub unescape {
  shift() if ref($_[0]) || (defined $_[1] && $_[0] eq $CGI::DefaultClass);
  my $todecode = shift;
  return undef unless defined($todecode);
  $todecode =~ tr/+/ /;       # pluses become spaces
    $EBCDIC = "\t" ne "\011";
    if ($EBCDIC) {
      $todecode =~ s/%([0-9a-fA-F]{2})/chr $A2E[hex($1)]/ge;
    } else {
      $todecode =~ s/%(?:([0-9a-fA-F]{2})|u([0-9a-fA-F]{4}))/
	defined($1)? chr hex($1) : utf8_chr(hex($2))/ge;
    }
  return $todecode;
}

# URL-encode data
sub escape {
  shift() if ref($_[0]) || (defined $_[1] && $_[0] eq $CGI::DefaultClass);
  my $toencode = shift;
  return undef unless defined($toencode);
    $EBCDIC = "\t" ne "\011";
    if ($EBCDIC) {
      $toencode=~s/([^a-zA-Z0-9_.-])/uc sprintf("%%%02x",$E2A[ord($1)])/eg;
    } else {
      $toencode=~s/([^a-zA-Z0-9_.-])/uc sprintf("%%%02x",ord($1))/eg;
    }
  return $toencode;
}

# This internal routine creates date strings suitable for use in
# cookies and HTTP headers.  (They differ, unfortunately.)
# Thanks to Mark Fisher for this.
sub expires {
    my($time,$format) = @_;
    $format ||= 'http';

    my(@MON)=qw/Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec/;
    my(@WDAY) = qw/Sun Mon Tue Wed Thu Fri Sat/;

    # pass through preformatted dates for the sake of expire_calc()
    $time = expire_calc($time);
    return $time unless $time =~ /^\d+$/;

    # make HTTP/cookie date string from GMT'ed time
    # (cookies use '-' as date separator, HTTP uses ' ')
    my($sc) = ' ';
    $sc = '-' if $format eq "cookie";
    my($sec,$min,$hour,$mday,$mon,$year,$wday) = gmtime($time);
    $year += 1900;
    return sprintf("%s, %02d$sc%s$sc%04d %02d:%02d:%02d GMT",
                   $WDAY[$wday],$mday,$MON[$mon],$year,$hour,$min,$sec);
}

# This internal routine creates an expires time exactly some number of
# hours from the current time.  It incorporates modifications from 
# Mark Fisher.
sub expire_calc {
    my($time) = @_;
    my(%mult) = ('s'=>1,
                 'm'=>60,
                 'h'=>60*60,
                 'd'=>60*60*24,
                 'M'=>60*60*24*30,
                 'y'=>60*60*24*365);
    # format for time can be in any of the forms...
    # "now" -- expire immediately
    # "+180s" -- in 180 seconds
    # "+2m" -- in 2 minutes
    # "+12h" -- in 12 hours
    # "+1d"  -- in 1 day
    # "+3M"  -- in 3 months
    # "+2y"  -- in 2 years
    # "-3m"  -- 3 minutes ago(!)
    # If you don't supply one of these forms, we assume you are
    # specifying the date yourself
    my($offset);
    if (!$time || (lc($time) eq 'now')) {
        $offset = 0;
    } elsif ($time=~/^\d+/) {
        return $time;
    } elsif ($time=~/^([+-]?(?:\d+|\d*\.\d*))([mhdMy]?)/) {
        $offset = ($mult{$2} || 1)*$1;
    } else {
        return $time;
    }
    return (time+$offset);
}

1;

__END__

=head1 NAME

CGI::Util - Internal utilities used by CGI module

=head1 SYNOPSIS

none

=head1 DESCRIPTION

no public subroutines

=head1 AUTHOR INFORMATION

Copyright 1995-1998, Lincoln D. Stein.  All rights reserved.  

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

Address bug reports and comments to: lstein@cshl.org.  When sending
bug reports, please provide the version of CGI.pm, the version of
Perl, the name and version of your Web server, and the name and
version of the operating system you are using.  If the problem is even
remotely browser dependent, please provide information about the
affected browers as well.

=head1 SEE ALSO

L<CGI>

=cut
