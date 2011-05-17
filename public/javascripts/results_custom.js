/*
* Customization of Repertoire Faceting Results widget
*
* Copyright (c) 2011 MIT Hyperstudio
* Dave Della costa, 05/2011
*
* Requires jquery 1.3.2+
* Support: Firefox 3+ & Safari 4+.  IE emphatically not supported.
*
*
* Usage:
*
*   $('#my_results').results_custom(<options>)
*
* Options:  As for basic faceting widgets
*           - type:  return type for ajax query
*           None are required.
*/

repertoire.results_custom = function($results, options) {

  var self = repertoire.facet_widget($results, options);

  self.offset = options.offset || 0;
  self.limit = options.limit || 5;

  //
  // pagination forward
  //
  self.handler('.rep #results_nav .next', function() {
    var context = self.context();
    if (self.offset + self.limit <= self.count)
      self.offset += self.limit;
    self.refresh();
    return false;
  });

  //
  // pagination backwards
  //
  self.handler('.rep #results_nav .prev', function() {
    var context = self.context();
    if (self.offset - self.limit >= 0)
      self.offset -= self.limit;
    self.refresh();
    return false;
  });

  //
  // Ajax callback for results
  //
  self.reload = function(callback) {
    var context  = self.context();
    context.update_state({
      limit: self.limit,
      offset: self.offset
    });
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

    // Ugh.
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

    if (self.offset - self.limit >= 0) {
      results_nav = results_nav + "<a href='#' class='prev'>Previous page</a>";
    } else {
      results_nav = results_nav + "<span class='disable_link'>First page</span>";
    }

    var page_count = Math.ceil(self.count / self.limit);
    var page = (self.offset / self.limit) + 1;

    results_nav = results_nav + " | Page " + page + " of " + page_count + " | ";

    if (self.offset + self.limit < self.count) {
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
$.fn.results_custom = repertoire.plugin(repertoire.results_custom);
$.fn.results_custom.defaults = {
  type: 'html'          /* jquery ajax type: html, json, xml */
};