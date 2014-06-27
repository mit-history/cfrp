// A first cut at visualizing the Comedie Francaise data in the faceted browser.
//
// Christopher York, June 2014

//
// Should be presented to the CR people, and interated as appropriate. Points to note:
//
//   - current rollup is via date within the year, but this data seems to orient more to
//     days in the week, and the catholic saints' calendar. Need to devise a way of aggregating
//     that brings these patterns to the fore.
//
//   - an x/y calendar is almost certainly better for than a radial visualization. However,
//     we need a way to visualize aggregations across many years (i.e. the standard calendar
//     format will not work.)
//
//   - repertoire-faceting is a faceted search tool, not an OLAP tool: it's for finding a needle
//     in a haystack, not slicing and dicing the haystack to look for correlations. So data
//     analysis should probably be done via the database tables, and suggestive visualizations
//     then connected as endpoints to the faceted browser.
//


//= require d3.v3.min.js
//= require colorbrewer.v1.min.js

visualize_registers = function(registers, $elem, options) {

  var monthNames = ["janvier", "février", "mars", "avril", "mai", "juin",
                    "juillet", "août", "septembre", "octobre", "novembre", "décembre"];

  registers.forEach(function(d) {
    d.month = +d.month - 1;
    d.day = +d.day - 1;
  });

  var width = options.width || 800,
      height = options.width || 600,
      radius = Math.min(width, height) / 2;

  var format = d3.time.format("%Y-%m-%d"),
      shortFormat = d3.time.format("%d %B"),
      numFormat = d3.format("0,000");

  /* map everything onto a 1904 - a leap year */
  var beginDate = format.parse('1904-01-01'),
      endDate = format.parse('1905-01-01'),
      plotDate = function (d) {
        var beginMonth = d3.time.month.offset(beginDate, d.month);
        return d3.time.day.offset(beginMonth, d.day);
      };

  var rotation = Math.PI,
      rScale = d3.time.scale()
                 .domain([beginDate, endDate])
                 .range([2.0 * Math.PI + rotation, rotation]),
      colors = colorbrewer.RdYlBu[9],
      colorScale = d3.scale.quantile().range(colors);

  var rings = { months : {
                  agg : function(d) { return d.month; },
                  deagg : function(month) { return d3.time.month.offset(beginDate, month); },
                  arc : d3.svg.arc().outerRadius(radius - 90)
                                    .innerRadius(radius - 120),
                  title : function(d) { return monthNames[+d.key] + " : " + numFormat(d.values) + " billets"; },
                  label : function(d) { return monthNames[+d.key] } },
                weeks : {
                  agg : function(d) { return Math.min(52, d3.time.weekOfYear(plotDate(d))) - 1; },
                  deagg : function(week) { return d3.time.week.offset(beginDate, week); },
                  arc : d3.svg.arc().outerRadius(radius - 50)
                                    .innerRadius(radius - 80),
                  title : function(d) { return "semaine " + (+d.key + 1) + " : " + numFormat(d.values) + " billets"; } },
                days : {
                  agg : function(d) { return Math.min(365, d3.time.dayOfYear(plotDate(d))) - 1; },
                  deagg : function(day) { return d3.time.day.offset(beginDate, day); },
                  arc : d3.svg.arc().outerRadius(radius - 10)
                                    .innerRadius(radius - 40),
                  title : function(d) { var date = d3.time.day.offset(beginDate, +d.key);
                                          return date.getDate() + " " + monthNames[date.getMonth()] + " : " + numFormat(d.values) + " billets"; } },
              };

  /* drawing surface */

  d3.select($elem[0]).select("svg").remove();

  var canvas = d3.select($elem[0]).append("svg")
                 .attr("width", width)
                 .attr("height", height)

  var svg = canvas.append("g")
       .attr("transform", "translate(" + width / 2 + "," + height / 2 + ")");

  /* legend */

  var lg = canvas.selectAll(".legend")
         .data(colors)
       .enter().append("g")
         .attr("class", "legend");

  lg.append("rect")
    .attr("x", 10)
    .attr("y", function (d, ndx) { return  12 * (9 - ndx); })
    .attr("width", 10)
    .attr("height", 10)
    .style("fill", function (d) { return d; });

  /* axes */

  var degrScale = function(d) { return (rScale(d) * 180 / Math.PI - 90); };

  var ticks = svg.append("g")
      .attr("class", "axis")
    .selectAll("g")
      .data(rScale.ticks(d3.time.day, 7))
    .enter().append("g")
      .attr("transform", function(d) { return "rotate(" + degrScale(d) + ")"; });

  ticks.append("text")
      .attr("x", radius)
      .attr("dy", "0.35em")
      .style("text-anchor", function(d) { return degrScale(d) < 270 && degrScale(d) > 90 ? "end" : null; })
      .attr("transform", function(d) { return degrScale(d) < 270 && degrScale(d) > 90 ? "rotate(180 " + radius + ",0)" : null; })
      .text(function(d) { return d.getDate(); });

  /* data and visualization proper */

  /* massage data into good format */
  registers.forEach(function (d) { d.day = +d.day;
                                   d.month = +d.month;
                                   d.tickets = +d.tickets });

  /* process each ring in turn */
  for (var i in rings) {
    var ring = rings[i],
        aggData = d3.nest().key(ring.agg)
                      .rollup(function (xs) { return d3.sum(xs, function(d) { return d.tickets; }) })
                      .entries(registers);
        ringColors = colorScale.copy().domain(d3.extent(aggData, function(d) { return d.values; }));

    var g = svg.selectAll("." + i)
        .data(aggData)
      .enter().append("g")
        .attr("class", i);

    var path = g.append("path")
        .attr("id", function(d, ndx) { return i + ndx; })
        .attr("d", ring.arc.startAngle( function(d) { return rScale(ring.deagg(+d.key)); })
                           .endAngle(   function(d) { return rScale(ring.deagg(+d.key + 1)); }))
        .style("fill", function(d) { return ringColors(d.values); });

    if (ring.title) {
      g.append("title").text(function(d) { return ring.title(d); });
    };

    if (ring.label) {
      g.append("text")
          .attr("x", 6)
          .attr("dy", 15)
        .append("textPath")
          .attr("xlink:href", function(d, ndx) { return "#" + i + ndx; })
          .text(function(d) { return ring.label(d); });
    };
  };

  return $elem;
}
