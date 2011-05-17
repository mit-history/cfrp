/*
* Repertoire faceting ajax widgets
*
* Copyright (c) 2009 MIT Hyperstudio
* Christopher York, 09/2009
*
* Requires jquery 1.3.2+
* Support: Firefox 3+ & Safari 4+.  IE emphatically not supported.
*
*
* A barebones faceting results widget.  HTML rendering is done on the server side.
*
* Usage:
*
*   $('#my_results').results(<options>)
*
* Options:  As for basic faceting widgets
*           - type:  return type for ajax query
*           None are required.
*/

//= require "facet_widget"


repertoire.results = function($results, options) {
  // inherit basic facet widget behaviour
  var self = repertoire.facet_widget($results, options);


  //
  // pagination forward
  //
  self.handler('.rep #results_nav .next', function() {
    var context = self.context();
    if (context.offset + context.limit <= self.count)
      context.offset += context.limit;
    self.refresh();
    return false;
  });


  //
  // pagination backwards
  //
  self.handler('.rep #results_nav .prev', function() {
    var context = self.context();
    if (context.offset - context.limit >= 0)
      context.offset -= context.limit;
    self.refresh();
    return false;
  });


  //
  // Ajax callback for results
  //
  self.reload = function(callback) {
    var context  = self.context();
    context.results(options.type, callback, $results);
  }


  // Count of results, see below
  self.count = 0;

  
  //
  // Render fetched html
  //
  var $template_fn = self.render;
  self.render = function(data) {
    var $markup = $template_fn();

    // LAME INTERIM SOLUTION...
    // REAL WAY TO DO THIS IS TO BUILD CUSTOM RESULTS WIDGET?
    if (data.match(/\|count = (\d*)\|/)) {
      self.count = RegExp.$1;
      $('.results_count').html(self.count);
      data = data.replace(/\|count = (\d*)\|/g, '');
    }

    // if html returned, use it; otherwise defer to a custom injector
    if (options.type == 'html') {
      $markup.append(data);
    }

    // opacity mask (for loading)
    $markup.append('<div class="mask"/>')

    return $markup.prepend(self.result_nav());
  }


  //
  // Build results nav for prepending to results template:
  //
  self.result_nav = function() {
    var context = self.context();
    var results_nav = "<div id='results_nav'>";

    if (context.offset - context.limit >= 0) {
      results_nav = results_nav + "<a href='#' class='prev'>Previous page</a>";
    } else {
      results_nav = results_nav + "<span class='disable_link'>First page</span>";
    }

    var page_count = Math.ceil(self.count / context.limit);
    var page = (context.offset / context.limit) + 1;

    results_nav = results_nav + " | Page " + page + " of " + page_count + " | ";

    if (context.offset + context.limit < self.count) {
      results_nav = results_nav + "<a href='#' class='next'>Next page</a>";
    } else {
      results_nav = results_nav + "<span class='disable_link'>Last page</span>";
    }

    results_nav = results_nav + "</div>";
    return results_nav;
  }

  // end of results factory function
  return self;
};

// Results plugin
$.fn.results = repertoire.plugin(repertoire.results);
$.fn.results.defaults = {
  type: 'html'          /* jquery ajax type: html, json, xml */
};