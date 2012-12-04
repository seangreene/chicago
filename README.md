[Threshold scales](https://github.com/mbostock/d3/wiki/Quantitative-Scales#wiki-threshold) support arbitrary quantization, mapping arbitrary slices of a continuous domain to discrete values in the range. In this example, unemployment rates for counties are quantized into different shades of blue.

```javascript
var color = d3.scale.threshold()
    .domain([.02, .04, .06, .08, .10])
    .range(["#f2f0f7", "#dadaeb", "#bcbddc", "#9e9ac8", "#756bb1", "#54278f"]);
```