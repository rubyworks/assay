# Assay Class Methods

## Metadata

Assay support full project metadata access thanks to the `.ruby`
standard.

    Assay.metadata['name']  #=> 'assay'

The metadata also dynamically translates into constants, so we
can work with this information in the traditional fashion.

    Assay::NAME  #=> 'assay'

## Color Messages

We can have some Assay error messages use ANSI color output by
setting the `Assay.color` setting to `true`.

    Assay.color = true

Keep in mind that this requires the `ansi` library.

In particular it is the equality related assertions that utilize color
output when the objects compared are large. This helps the developer
pinpint the differences quickly.

    expect EqualAssay do
      EqualAssay['really long string'] === 'other string'
    end

## Lookup Assay Classes

Assay tracks all created Assay classes by both associated operation
and assertive name.

    Assay.lookup_by_operator(:==)  #=> EqualAssay

    Assay.lookup_by_name(:equal)   #=> EqualAssay

We can look for either with just `lookup`.

    Assay.lookup(:==)      #=> EqualAssay
    Assay.lookup(:equal)   #=> EqualAssay


