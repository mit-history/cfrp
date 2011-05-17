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
* Register an element as the faceting context,
*   and provide user data extraction function
*
* Handles:
*       - manipulation of faceting refinements
*       - url/query-string construction
*       - data assembly for sending to webservice
*       - change publication and observing
*       - grouping faceting widgets into shared context
*       - facet count/results ajax api
*       - hooks for managing custom data
*/

//= require <jquery>

//= require <rep.widgets/model>

repertoire.facet_context = function(context_name, state_fn, options) {
  var self = repertoire.model(options);

  // current query state for all facets in context
  var filter = {};

  self.offset = 0;
  self.limit  = 4;  // TODO: set from defaults
  
  //
  // Return the current refinements for one facet, or all if no facet given
  //
  // Changes to the returned object are persistent, but you must call self.state_changed()
  // to trigger an update event.
  //
  self.refinements = function(name) {
    if (!name) {
      // if no facet provided, return all
      return filter;
    } else {
      // set up refinements for this facet
      if (!filter[name])
        filter[name] = [];

      // reset so we don't get 'stranded'
      self.offset = 0;

      // return current refinements
      return filter[name];
    }
  };

  //
  // Calculate facet value counts from webservice
  //
  // By default, the url is '/<context>/counts/<facet>'
  //
  self.counts = function(facet_name, callback, $elem) {
    var url = self.facet_url('counts', facet_name);
    // package up the faceting state and send back to results rendering service
    self.fetch(self.params(), url, 'json', callback, $elem);
  };
  
  //
  // Update query results from webservice
  //
  // By default, the url is '/<context>/counts/<facet>'
  //
  self.results = function(type, callback, $elem) {
    var url = self.facet_url('results');
    // package up the faceting state and send back to results rendering service
    self.fetch(self.params(), url, type, callback, $elem);
  };
  
  //
  // Convenience function for constructing faceting urls
  //
  self.facet_url = function(action, facet, ext, params) {
    var paths = [context_name, action]    
    if (facet)
      paths.push(facet)
    var url = self.default_url(paths, ext);
    if (params)
      return url + '?' + self.to_query_string(params);
    else
      return url;
  };
    
  //
  // Return the state for the entire faceting context (group of widgets),
  // with any context-specific additions
  //
  self.params = function() {
    var state = state_fn ? state_fn() : {};
    if (self.reset_search == 1 && state['search']) {
      state['search'] = '';
    }
    return $.extend({}, { filter: self.refinements(), offset: self.offset, limit: self.limit }, state);
  };
  
  //
  // Return the identifying name for this context (usually the model class, pluralized)
  //
  self.name = function() {
    return context_name;
  }


  //
  // Toggle whether facet value is selected
  //
  self.toggle = function(name, item) {
    var values = self.refinements(name);
    var index  = $.inArray(item, values);

    if (index == -1)
      values.push(item);
    else
      values.splice(index, 1);

    // Hook in here to update display...see ugliness below:
    self.update_refinements_info();

    return values;
  };


  /******************************************************************************************
   * EVERYTHING BELOW HERE TO 'RETURN SELF' IS UGLY WIDGET-Y ADDITIONS TO CONTEXT.
   */
  self.update_refinements_info = function() {
    var refs = self.refinements();
    var search_string = '';
    var refinement_string = '';

    if (self.get_search_string() != '' && self.get_search_string() != 'Search across all documents') {
      search_string += "Search string <span class='search_string'><span class='search_string_highlight'>" + self.get_search_string() + "</span>";
      search_string += ' <a href="#" class="clear_control search_clear_control">[x]</a>';
      self.add_toggler('search');
    } else {
      // UGH
      $("input#search").attr('value', '');
    }

    for (name in refs) {
      var title = $("#" + self.name() + " > .facet_holder > #" + name).attr('title');

      if (refs[name] != '') {
	refinement_string += title + ": <span class='facet_highlight'>" + refs[name] + "</span>";
	refinement_string += ' <a href="#" class="clear_control ' + name + '_clear_control">[x]</a>';
	refinement_string += ' | ';
	self.add_toggler(name);
      }
    }

    if (refinement_string != '') {
      refinement_string = "<span class='selected_highlight'>Selected:</span> " + refinement_string;
    }

    if (search_string != '' && refinement_string != '') {
      refinement_string = search_string + ", " + refinement_string;
    } else if (search_string != '' && refinement_string == '') {
      refinement_string = search_string;
    }

    $('span#info').html(refinement_string.replace(/ \| $/, ''));
  }


  // Adding in event handler stuff...but at this point this context has become pretty inelegant.
  // Need to think through how to make this into a widget while allowing it to share
  // data from all the facets in the facet context.  Hmm.  Gotta understand facet context better I guess.

  self.add_toggler = function (name) {
    $('a.' + name + '_clear_control').live('click', function () {

      if (name == 'search') {
	self.reset_search = 1;
      } else {
	filter[name] = [];
      }

      // this doesn't work...?
      //self.toggle(name, -1);

      // reload all associated facet widgets
      self.trigger('changed');

      // Hook in here to update display:
      self.update_refinements_info();

      // do not bubble event
      return false;
    });
  };

  /* This is almost there-but seems to be killing the facets when there is already a facet selected and you try to search...?
  $("form.search_form").submit(function() {

    // This is all a bit of a hack because the search param seems to go away if you
    // search, then facet, then clear search, then clear facet, then facet, then search.
    // I know.  Don't ask me.
    var search_param = '';
    if (get_search_string() == '') {
      // UGGGHHH
      search_param = $("input#search").val();
    }

    self.trigger('changed');
    self.update_refinements_info(search_param);
    return false;
  });
  */

  self.get_search_string = function() {
    var params = self.params();
    return params['search'];
  };

  self.reset_search = 0;


  // onload, 'cause we may get a link with a search string?
  self.update_refinements_info();

  /*
   * END UGLINESS ADDED BY DD
   ******************************************************************************************/
  
  // end of context factory method
  return self;
}

$.fn.facet_context = function(state_fn) {
  return this.each(function() {
    // add locator css class to element, and store faceting context data model in it
    var $elem = $(this);
    var name  = $elem.attr('id');
    var model = repertoire.facet_context(name, state_fn, repertoire.defaults);
    $elem.addClass('facet_refinement_context');
    $elem.data('context', model);
  });
};