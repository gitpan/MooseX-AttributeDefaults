# copy-pasted out of the SYNOPSIS

    package My::Custom::Metaclass;
    use Moose;

    extends 'Moose::Meta::Attribute';
    with    'MooseX::AttributeDefaults';

    sub default_options {
      my ($class, $name) = @_;
      
      return (
        is      => 'ro',
        isa     => 'Str',
        default => "default value for $name",
      );
    }

    package Some::Class;
    use Moose;

    has 'attr' => (
      metaclass => 'My::Custom::Metaclass',
      predicate => 'has_attr',
    );

# end copy-paste

package main;
use Test::More tests => 3;

my $obj = Some::Class->new;
ok($obj->can('attr'), 'has its accessor');
ok($obj->can('has_attr'), 'and its predicate');
is($obj->attr, "default value for attr", 'default worked');
