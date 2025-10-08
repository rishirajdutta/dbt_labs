{#
My first jinja block:

{% set tempreature = 80.0 %}

On a day like this i would like to have 

{% if tempreature > 75 %}

A chilled german lager. 

{% elif tempreature < 30 %}

A hot mocha coffee. 

{% else %}

A glass of water at room tempreature. 

{% endif %}

#}

{#
Testing basic for loops in jinja: 

{% for value in range(26) %}

This range has value: {{ value }}

{% endfor %} 
#} 

{#
{% set companies = ['intuit', 'frg', 'target', 'kaiser_permanante', 'gap', 'gmo'] %} 


{%- for employer in companies -%} 
    {% if employer == 'intuit' %}
        {%- set company_type = 'current'  -%}
    {% else %}
        {%- set company_type = 'previous' -%}
    {% endif %}
    Rishi has worked at {{ employer }} in his {{ company_type }} position.
{% endfor %}
#}


{%- set rishi_dictionary = {
    'father' : 'army officer',
    'mother' : 'teacher',
    'sister' : 'manager',
    'brother' : 'athelete'
} -%}

Rishi father is {{ rishi_dictionary['father'] }}, his mother is {{ rishi_dictionary['mother'] }}, his sister is a {{ rishi_dictionary['sister'] }} but "he himself is a {{ rishi_dictionary['brother'] }}"



{% for key, value in rishi_dictionary.items() -%}
    In Rishis family his {{ key|e }} is a {{ value|e }}
{% endfor %}


Sorted rishi_dictionary 

{% for key, value in rishi_dictionary | dictsort -%}
    In Rishis family his {{ key|e }} is a {{ value|e }}
{% endfor %}
