# jekyll-drawio

## Overview
[![Gem Version](https://badge.fury.io/rb/jekyll-drawio.svg)](https://badge.fury.io/rb/jekyll-drawio)

The plugin provides the functionality for generating embedded draw.io diagrams.

## Usage

Update the Gemfile and add the `jekyll-drawio` plugin:
```
group :jekyll_plugins do
  gem "jekyll-drawio"
end
```

Now you can embed draw.io diagrams using the following tag:
```
{% drawio path="<path_to_diagram>" page_number=<page_number> height=<height_in_px> %}
```

Parameters:

`path` - relative path to a diagram.

`page_number` - page number from the diagram that should be embedded. NOTE: the numeration starts from 0.

`height` - diagram frame height in px.