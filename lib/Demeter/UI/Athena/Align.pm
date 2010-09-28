package Demeter::UI::Athena::Align;

use Wx qw( :everything );
use base 'Wx::Panel';
use Wx::Event qw(EVT_BUTTON EVT_CHOICE EVT_COMBOBOX EVT_TEXT);
use Wx::Perl::TextValidator;

use Demeter::UI::Wx::SpecialCharacters qw(:all);

use vars qw($label);
$label = "Align data";

my $tcsize = [60,-1];

sub new {
  my ($class, $parent, $app) = @_;
  my $this = $class->SUPER::new($parent, -1, wxDefaultPosition, wxDefaultSize, wxMAXIMIZE_BOX );

  my $box = Wx::BoxSizer->new( wxVERTICAL );
  $this->{sizer}  = $box;

  my $gbs = Wx::GridBagSizer->new( 5, 5 );

  my $label = Wx::StaticText->new($this, -1, "Aligning");
  $gbs->Add($label, Wx::GBPosition->new(0,0));
  $label = Wx::StaticText->new($this, -1, "Standard");
  $gbs->Add($label, Wx::GBPosition->new(1,0));
  $label = Wx::StaticText->new($this, -1, "Plot as");
  $gbs->Add($label, Wx::GBPosition->new(2,0));
  $label = Wx::StaticText->new($this, -1, "Fit as");
  $gbs->Add($label, Wx::GBPosition->new(3,0));

  $this->{this}     = Wx::StaticText->new($this, -1, q{Group});
  $this->{standard} = Wx::ComboBox->new($this, -1, q{}, wxDefaultPosition, [165,-1], [], wxCB_READONLY);
  $this->{plotas}   = Wx::Choice->new($this, -1, wxDefaultPosition, [165,-1],
				      ["$MU(E)", 'norm(E)', 'deriv(E)', 'smoothed deriv(E)']);
  $this->{fitas}    = Wx::Choice->new($this, -1, wxDefaultPosition, [165,-1],
				      ['deriv(E)', 'smoothed deriv(E)']);

  $this->{plotas} -> SetSelection(2);
  $this->{fitas}  -> SetSelection(0);

  $gbs->Add($this->{this},     Wx::GBPosition->new(0,1));
  $gbs->Add($this->{standard}, Wx::GBPosition->new(1,1));
  $gbs->Add($this->{plotas},   Wx::GBPosition->new(2,1));
  $gbs->Add($this->{fitas},    Wx::GBPosition->new(3,1));

  EVT_CHOICE($this, $this->{plotas}, sub{$this->plot($app->current_data)});
  EVT_COMBOBOX($this, $this->{standard}, sub{$this->plot($app->current_data)});

  $box -> Add($gbs, 0, wxALIGN_CENTER_HORIZONTAL|wxALL, 10);


  my $hbox = Wx::BoxSizer->new( wxHORIZONTAL );
  $box -> Add($hbox, 0, wxALIGN_CENTER_HORIZONTAL|wxALL, 10);
  $this->{shiftlabel} = Wx::StaticText->new($this, -1, "Shift by");
  $this->{shift}      = Wx::TextCtrl->new($this, -1, 0, wxDefaultPosition, $tcsize);
  $this->{units}      = Wx::StaticText->new($this, -1, "eV");
  $this->{replot}     = Wx::Button->new($this, -1, "Replot", @ps2);
  $hbox->Add($this->{shiftlabel}, 0, wxALL,          4);
  $hbox->Add($this->{shift},      0, wxLEFT|wxRIGHT, 2);
  $hbox->Add($this->{units},      0, wxALL,          4);
  $hbox->Add($this->{replot},     0, wxLEFT,         8);

  $this->{shift} -> SetValidator( Wx::Perl::TextValidator->new( qr([-0-9.]) ) );
  EVT_TEXT($this, $this->{shift}, sub{OnShift(@_, $app->current_data)});
  EVT_BUTTON($this, $this->{replot}, sub{$this->plot($app->current_data)});

  $gbs = Wx::GridBagSizer->new( 5, 5 );

  my @ps  = (wxDefaultPosition, [80, -1]);
  my @ps2 = (wxDefaultPosition, [165,-1]);

  $this->{auto}   = Wx::Button->new($this, -1, "Auto align", @ps2);
  $this->{marked} = Wx::Button->new($this, -1, "Align marked groups", @ps2);
  $this->{m5}     = Wx::Button->new($this, -1, "-5",     @ps);
  $this->{p5}     = Wx::Button->new($this, -1, "+5",     @ps);
  $this->{m1}     = Wx::Button->new($this, -1, "-1",     @ps);
  $this->{p1}     = Wx::Button->new($this, -1, "+1",     @ps);
  $this->{mhalf}  = Wx::Button->new($this, -1, "-0.5",   @ps);
  $this->{phalf}  = Wx::Button->new($this, -1, "+0.5",   @ps);
  $this->{mtenth} = Wx::Button->new($this, -1, "-0.1",   @ps);
  $this->{ptenth} = Wx::Button->new($this, -1, "+0.1",   @ps);

  $gbs->Add($this->{auto},   Wx::GBPosition->new(0,0), Wx::GBSpan->new(1,2));
  $gbs->Add($this->{marked}, Wx::GBPosition->new(0,2));
  $gbs->Add($this->{m5},     Wx::GBPosition->new(1,0));
  $gbs->Add($this->{p5},     Wx::GBPosition->new(1,1));
  $gbs->Add($this->{m1},     Wx::GBPosition->new(2,0));
  $gbs->Add($this->{p1},     Wx::GBPosition->new(2,1));
  $gbs->Add($this->{mhalf},  Wx::GBPosition->new(3,0));
  $gbs->Add($this->{phalf},  Wx::GBPosition->new(3,1));
  $gbs->Add($this->{mtenth}, Wx::GBPosition->new(4,0));
  $gbs->Add($this->{ptenth}, Wx::GBPosition->new(4,1));

  EVT_BUTTON($this, $this->{auto},   sub{$this->autoalign($app->current_data, 'this')});
  EVT_BUTTON($this, $this->{marked}, sub{$this->autoalign($app->current_data, 'marked')});
  EVT_BUTTON($this, $this->{m5},     sub{$this->add($app->current_data, -5  )});
  EVT_BUTTON($this, $this->{p5},     sub{$this->add($app->current_data,  5  )});
  EVT_BUTTON($this, $this->{m1},     sub{$this->add($app->current_data, -1  )});
  EVT_BUTTON($this, $this->{p1},     sub{$this->add($app->current_data,  1  )});
  EVT_BUTTON($this, $this->{mhalf},  sub{$this->add($app->current_data, -0.5)});
  EVT_BUTTON($this, $this->{phalf},  sub{$this->add($app->current_data,  0.5)});
  EVT_BUTTON($this, $this->{mtenth}, sub{$this->add($app->current_data, -0.1)});
  EVT_BUTTON($this, $this->{ptenth}, sub{$this->add($app->current_data,  0.1)});

  $box -> Add($gbs, 0, wxALIGN_CENTER_HORIZONTAL|wxALL, 10);


  $this->SetSizerAndFit($box);
  return $this;
};

sub pull_values {
  my ($this, $data) = @_;
  1;
};
sub push_values {
  my ($this, $data) = @_;
  $this->{this}  -> SetLabel($data->name);
  ##$this->{shiftlabel} -> SetLabel("Shift " . $data->name . " by");
  $this->{shift} -> SetValue($data->bkg_eshift);
  my $count = 0;
  my @list;
  foreach my $i (0 .. $::app->{main}->{list}->GetCount - 1) {
    my $data = $::app->{main}->{list}->GetClientData($i);
    if ($data->datatype ne 'chi') {
      push @list, sprintf("%d: %s", $i+1, $data->name);
      ++$count;
    };
  };
  ($count < 2) ? $this->Enable(0) : $this->Enable(1);
  $this->{standard}->Clear;
  $this->{standard}->Append(\@list);
  $this->{standard}-> SetValue(sprintf("%d: %s", 1, $::app->{main}->{list}->GetClientData(0)->name));

  #($::app->current_index == 0)
  #  ? $this->{standard}-> SetValue(sprintf("%d: %s", 2, $::app->{main}->{list}->GetClientData(1)->name))
  #    : $this->{standard}-> SetValue(sprintf("%d: %s", 1, $::app->{main}->{list}->GetClientData(0)->name));
  $this->plot($data);
};
sub mode {
  my ($this, $data, $enabled, $frozen) = @_;
  1;
};

sub OnShift {
  my ($this, $event, $data) = @_;
  $data->bkg_eshift($this->{shift}->GetValue);
};
sub add {
  my ($this, $data, $amount) = @_;
  my $shift = $this->{shift}->GetValue;
  $this->{shift}->SetValue($shift+$amount);
  $this->plot($data);
};

sub autoalign {
  my ($this, $data, $how) = @_;
  my $busy = Wx::BusyCursor->new();
  ($this->{standard}->GetValue =~ m{\A(\d+):}) and ($stan_index = $1-1);
  $stan = $::app->{main}->{list}->GetClientData($stan_index);

  if (($how eq 'this') and ($data eq $stan)) {
    $app->{main}->status("Not aligning -- the data and standard are the same!");
    return;
  };

  my @all = ($data);
  if ($how eq 'marked') {
    @all = ();
    foreach my $i (0 .. $::app->{main}->{list}->GetCount - 1) {
      next if ($::app->{main}->{list}->GetClientData($i)eq $stan);
      push(@all, $::app->{main}->{list}->GetClientData($i))
	if $::app->{main}->{list}->IsChecked($i);
    };
  };
  $stan->align(@all);
  undef $busy;
  $this->{shift}->SetValue($data->bkg_eshift);
  $this->plot($data);
};

sub plot {
  my ($this, $data) = @_;
  my $busy = Wx::BusyCursor->new();
  #$data -> bkg_eshift($this->{shift}->GetValue);
  ($this->{standard}->GetValue =~ m{\A(\d+):}) and ($stan_index = $1-1);
  $stan = $::app->{main}->{list}->GetClientData($stan_index);
  $data->po->set(emin=>-30, emax=>50);
  $data->po->set(e_mu=>1, e_markers=>1, e_bkg=>0, e_pre=>0, e_post=>0, e_norm=>0, e_der=>0, e_sec=>0, e_i0=>0, e_signal=>0);
  $data->po->e_norm(1) if ($this->{plotas}->GetSelection == 1);
  $data->po->e_der(1)  if ($this->{plotas}->GetSelection == 2);
  $data->po->set(e_der=>1, e_smooth=>3)  if ($this->{plotas}->GetSelection == 3);
  $data->po->start_plot;
  $_->plot('e') foreach ($stan, $data);
  undef $busy;
};

1;


=head1 NAME

Demeter::UI::Athena::Align - An alignment tool for Athena

=head1 VERSION

This documentation refers to Demeter version 0.4.

=head1 SYNOPSIS

This module provides a

=head1 CONFIGURATION


=head1 DEPENDENCIES

Demeter's dependencies are in the F<Bundle/DemeterBundle.pm> file.

=head1 BUGS AND LIMITATIONS

=over 4

=item *

This 'n' that

=back

Please report problems to Bruce Ravel (bravel AT bnl DOT gov)

Patches are welcome.

=head1 AUTHOR

Bruce Ravel (bravel AT bnl DOT gov)

L<http://cars9.uchicago.edu/~ravel/software/>

=head1 LICENCE AND COPYRIGHT

Copyright (c) 2006-2010 Bruce Ravel (bravel AT bnl DOT gov). All rights reserved.

This module is free software; you can redistribute it and/or
modify it under the same terms as Perl itself. See L<perlgpl>.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

=cut