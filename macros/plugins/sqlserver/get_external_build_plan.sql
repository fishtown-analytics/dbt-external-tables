{% macro sqlserver__get_external_build_plan(source_node) %}

    {% set build_plan = [] %}

    {% set old_relation = adapter.get_relation(
        database = source_node.database,
        schema = source_node.schema,
        identifier = source_node.identifier
    ) %}
    {{ log('old_relation: ' ~ old_relation, info=True) }}
    {% set create_or_replace = (old_relation is none or var('ext_full_refresh', false)) %}
    {{ log('create_or_replace:' ~ create_or_replace, info=True) }}
    {% if create_or_replace %}
        {% if source_node.external.materialize = true %}
            {# change source_node object to have a new name #}
            {% set source_tmp = source_node %}
            {% set source_tmp.name = source_node.name ~ '__tmp' %}
            {# create the tmp external table #}
            {% set build_plan = build_plan + [ 
                dbt_external_tables.dropif(source_tmp), 
                dbt_external_tables.create_external_table(source_tmp)
            ] %}
            {# create the actual table using actual source name #}
            {# run insert into query  sqlserver__create_table_as?? #}
            {# drop the tmp external table #}
            {% set build_plan = build_plan + [ 
                
            ] %}
        {% endif %}
        {% set build_plan = build_plan + [ 
            dbt_external_tables.dropif(source_node), 
            dbt_external_tables.create_external_table(source_node)
        ] %}
    {% else %}
        {% set build_plan = build_plan + dbt_external_tables.refresh_external_table(source_node) %}
    {% endif %}
    {% do return(build_plan) %}

{% endmacro %}

{% macro synapse__get_external_build_plan(source_node) %}
    {% do return( dbt_external_tables.sqlserver__get_external_build_plan(source_node)) %}
{% endmacro %}