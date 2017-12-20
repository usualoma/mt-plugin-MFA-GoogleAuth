package MT::Plugin::MFA::GoogleAuth;

use strict;
use warnings;
use utf8;

BEGIN {
    eval 'require Math::Random::MT;';
    if ($@) {
        eval <<PACKAGE;
package Math::Random::MT;

use base 'Exporter';
our \@EXPORT_OK = qw(rand);

*rand = \*CORE::rand;

1;
PACKAGE
        $INC{"Math/Random/MT.pm"} = __FILE__;
    }
};

use Auth::GoogleAuth;

sub plugin {
    my $name = __PACKAGE__;
    $name =~ s{\AMT::Plugin::}{};
    $name =~ s{::}{-}g;
    MT->component($name);
}

sub dialog {
    plugin()->load_tmpl('dialog.tmpl');
}

sub enable {
    my $app = shift;

    my $user = $app->user;
    my $auth = Auth::GoogleAuth->new;
    $user->mfa_google_auth_secret($auth->generate_secret32);
    $user->save;

    my $url = $auth->qr_code(
        $user->mfa_google_auth_secret,
        $user->email,
        'Movable Type',
    );

    return $app->json_result({
        qrCodeUrl => $url,
    });
}

sub _disable {
    my ($user) = @_;

    $user->mfa_google_auth_secret('');
    $user->save;
}

sub disable {
    my $app = shift;

    _disable($app->user);

    return $app->json_result({});
}

sub reset_settings {
    my ($cb, $app, $param) = @_;

    _disable($param->{user});

    1;
}

sub show_settings {
    my ($cb, $app, $param) = @_;

    my $tmpl = plugin()->load_tmpl('settings.tmpl');
    $tmpl->param({
        enabled => !!$app->user->mfa_google_auth_secret,
    });

    push @{$param->{templates}}, $tmpl;
}

sub render_form {
    my ($cb, $app, $param) = @_;

    return 1 unless $app->user->mfa_google_auth_secret;

    push @{$param->{templates}}, plugin()->load_tmpl('form.tmpl');
}

sub _verify_token {
    my ($user, $token) = @_;

    my $auth = Auth::GoogleAuth->new({
        secret32 => $user->mfa_google_auth_secret,
    });
    $auth->verify($token, 1);
}

sub verify_token {
    my ($cb) = @_;
    my $app = MT->app;

    return 1 unless $app->user->mfa_google_auth_secret;

    (my $token = $app->param('mfa_google_auth_token') || '') =~ s/\s+//g;

    return 0 unless $token =~ m/\A\d{6}\z/;
    return 0 unless _verify_token($app->user, $token);

    return 1;
}

1;
