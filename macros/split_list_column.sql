{% macro split_list_column(column_name) -%}
    {#-
        Splits a comma-separated VARCHAR column into a VARCHAR[] expression.
        The list separator is ',' (no space); ', ' (with space) belongs to a
        name (e.g. 'KRAFTON, Inc.'), so it is protected with chr(31) during
        the split. The source also contains company suffixes glued to the
        name without a space ('Rideon,Inc.'): a whole element that is just
        Inc/LLC/Ltd is therefore also protected and normalised to ', Inc.'.
        Elements are trimmed and empty ones removed; order is preserved.
        NULL input yields NULL.
    -#}
    list_filter(
        list_transform(
            string_split(
                regexp_replace(
                    replace({{ column_name }}, ', ', chr(31)),
                    ',(Inc|LLC|Ltd)(\.?)(,|$)',
                    chr(31) || '\1\2\3',
                    'ig'
                ),
                ','
            ),
            x -> trim(replace(x, chr(31), ', '))
        ),
        x -> x <> ''
    )
{%- endmacro %}
