D3 2.10 adds threshold scales for arbitrary quantization. In this example, unemployment rates for counties are quantized into different shades of blue.

```javascript
var color = d3.scale.threshold()
    .domain([2, 4, 6, 8, 10])
    .range(["#f2f0f7", "#dadaeb", "#bcbddc", "#9e9ac8", "#756bb1", "#54278f"]);
```
