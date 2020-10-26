# jekyll-drawio

## Overview

The plugin provides the functionality for generating an embeded draw.io diagrams.

## Usage

Update the Gemfile and add the `jekyll-drawio` plugin:
```
group :jekyll_plugins do
  gem "jekyll-drawio"
end
```

Now you can embed draw.io diagrams using the following tag:
```
{% drawio path="<path_to_diagram>" page_number=<page_number> %}
```

Parameters:

`path` - relative path to a diagram.

`page_number` - page number from the diagram that should be embeded. NOTE: the numeration starts from 0.