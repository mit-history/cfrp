/*
 * Calculation functions for sous/livre for new/edit register form (new.html.erb)
 *
 * These depend on the specific selectors in that template, and jquery...this isn't very portable...
 *  -DD, 12/09/09
 *
 * Updated to accommodate deniers, a base-12 sub-sous denomination, in addition to livres and sous.
 *  -JF, 02/17/14
 *  Wow this project has been around for a while!
 */

var calculate_totals_for_tickets_sold = function () {
  var total_sold_l = 0;
  var total_sold_s = 0;
  var total_sold_d = 0;

  $("table#ticket_sales_fields").find("input.ticket_sales_total_sold").each(
    function (i) {
      var total_sold = $(this).attr('value');
      re = /_(\d+)_/i;
      var matches = $(this).attr('id').match(re);
      var this_index = matches[1];

      var ppt_l = 0;
      var ppt_s = 0;
      var ppt_d = 0;

      // "locally scoped" temp variables
      var total_l = total_sold_l;
      var total_s = total_sold_s;
      var total_d = total_sold_d;

      ppt_s = $("table#ticket_sales_fields").find("input#register_ticket_sales_attributes_" + this_index + "_price_per_ticket_s").val();
      ppt_l = $("table#ticket_sales_fields").find("input#register_ticket_sales_attributes_" + this_index + "_price_per_ticket_l").val();
      ppt_d = $("table#ticket_sales_fields").find("input#register_ticket_sales_attributes_" + this_index + "_price_per_ticket_d").val();

      // Calculate totals for this row
      this_total_l = ppt_l * total_sold;
      this_total_s = ppt_s * total_sold;
      this_total_d = ppt_d * total_sold;

      this_total_s += Math.floor(this_total_d/12); // Add deniers/12 to sous
      this_total_d = this_total_d % 12; // Assign remainder to deniers

      this_total_l += Math.floor(this_total_s/20); // Add sous/20 to livres
      this_total_s = this_total_s % 20; // Assign remainder to sous

      // Add this row's totals to the local grand total temp vars.
      // At this point, we may have change that adds up to larger denominations...
      // ...so we should recalculate grand totals in our local total temp vars.

      // Add the total deniers from this row to the grand total deniers
      total_d += this_total_d;

      // Add new sous if any from total deniers
      this_total_s += Math.floor(total_d/12);

      // Add the new total sous from this row to the grand total sous
      total_s += this_total_s;

      // Add new livres if any from new total sous
      this_total_l += Math.floor(total_s/20);

      // Add this row's total livres to the global total livres
      total_l += this_total_l

      total_sold_d = total_d % 12;          // Assign remainder to global deniers
      total_sold_s = total_s % 20;          // Assign remainder to global sous
      total_sold_l = total_l;               // Assign new local total to global livres
    }
  );

  /// TODO: Pick up here.

  if (isNaN(total_sold_l) || isNaN(total_sold_s) || isNaN(total_sold_d)) {
    $('#total_receipts_calculated_ts').html('Not a number--please review your<br />"Tickets Sold and Price Per Ticket"<br />fields for non-number values');
    $('#total_receipts_calculated_ts').css('font-size', '11px');
  } else {
    // Gotta do one last check because otherwise we may have enough
    // sous to add up to a livre, but we don't display it properly.
    // total_sold_l = total_sold_l + Math.floor(total_sold_s/20);
    // total_sold_s = total_sold_s % 20;
    // total_sold_d = total_sold_d % 12;
    $('#total_receipts_calculated_ts').html("Tally: " + total_sold_l + " livre, " + total_sold_s + " sous, " + total_sold_d + " deniers");
    $('#total_receipts_calculated_ts').css('font-size', '14px');
  }

  compare_to_calculated_totals(total_sold_l, total_sold_s, total_sold_d, 'total_receipts_calculated_ts');

  return { l: total_sold_l, s: total_sold_s, d: total_sold_d };
};

// function plus_ça_change(ppt_s, ppt_d, total_sold) {
//   var livres = 0;
//   Math.floor((ppt_d * total_sold)/12)
//   return
// }

var calculate_totals_for_recorded_take = function () {
  var total_l = 0;
  var total_s = 0;
  var total_d = 0;

  $("table#ticket_sales_fields").find("input.ticket_sales_recorded_total_l").each(
    function (i) {
      total_l += new Number($(this).val());
    }
  );

  $("table#ticket_sales_fields").find("input.ticket_sales_recorded_total_s").each(
    function (i) {
      total_s += new Number($(this).val());
    }
  );

  $("table#ticket_sales_fields").find("input.ticket_sales_recorded_total_d").each(
    function (i) {
      total_d += new Number($(this).val());
    }
  );

  total_s = total_s + Math.floor(total_d/12);
  total_d = total_d % 12;
  total_l = total_l + Math.floor(total_s/20);
  total_s = total_s % 20;

  if (isNaN(total_l) || isNaN(total_s)) {
    $('#total_receipts_calculated_rt').html('Not a number--please review your<br />"total take as recorded (livre and sous)"<br />fields for non-number values');
    $('#total_receipts_calculated_rt').css('font-size', '11px');
  } else {
    $('#total_receipts_calculated_rt').html("Tally: " + total_l  + ' livres, ' + total_s + ' sous, ' + total_d + ' deniers');
    $('#total_receipts_calculated_rt').css('font-size', '14px');
  }

  compare_to_calculated_totals(total_l, total_s, total_d, 'total_receipts_calculated_rt');

  return { l: total_l, s: total_s, d: total_d };
};


var compare_to_calculated_totals = function (total_l, total_s, total_d, selector) {
  var total_l_rec = new Number($('input#register_total_receipts_recorded_l').val());
  // console.log("total_l_rec: " + total_l_rec);
  var total_s_rec = new Number($('input#register_total_receipts_recorded_s').val());
  // console.log("total_s_rec: " + total_s_rec);
  var total_d_rec = new Number($('input#register_total_receipts_recorded_d').val());
  // console.log("total_d_rec: " + total_d_rec);

  $("#" + selector).attr('class', 'alert-success');

  if (total_l_rec.valueOf() !== new Number(total_l).valueOf()) {
    $("#" + selector).attr('class', 'alert-error');
    console.log("total_l_rec: " + total_l_rec.valueOf() + " does not match calculated: " + new Number(total_l).valueOf());
  }
  else {
    console.log("total_l_rec: " + total_l_rec.valueOf() + " matches calculated: " + new Number(total_l).valueOf());
  }

  if (total_s_rec.valueOf() !== new Number(total_s).valueOf()) {
    $("#" + selector).attr('class', 'alert-error');
    console.log("total_s_rec: " + total_s_rec.valueOf() + " does not match calculated: " + new Number(total_s).valueOf());
  }
  else {
    console.log("total_s_rec: " + total_s_rec.valueOf() + " matches calculated: " + new Number(total_s).valueOf());
  }

  if (total_d_rec.valueOf() !== new Number(total_d).valueOf()) {
    $("#" + selector).attr('class', 'alert-error');
    console.log("total_d_rec: " + total_d_rec.valueOf() + " does not match calculated: " + new Number(total_d).valueOf());
  }
  else {
    console.log("total_d_rec: " + total_d_rec.valueOf() + " matches calculated: " + new Number(total_d).valueOf());
  }
};

$(function() {
  var rt_vals = {};
  var ts_vals = {};

  rt_vals = calculate_totals_for_recorded_take();
  // console.dir(rt_vals);
  ts_vals = calculate_totals_for_tickets_sold();
  // console.dir(ts_vals);

  $("table#ticket_sales_fields").find("input.ticket_sales_recorded_total_l").keyup( function () {
    rt_vals = calculate_totals_for_recorded_take();
  });

  $("table#ticket_sales_fields").find("input.ticket_sales_recorded_total_s").keyup( function () {
    rt_vals = calculate_totals_for_recorded_take();
  });

  $("table#ticket_sales_fields").find("input.ticket_sales_recorded_total_d").keyup( function () {
    rt_vals = calculate_totals_for_recorded_take();
  });

  $("table#ticket_sales_fields").find("input.ticket_sales_total_sold").keyup( function () {
    ts_vals = calculate_totals_for_tickets_sold();
  });

  $("table#ticket_sales_fields").find("input.ticket_sales_price_per_ticket_s").keyup( function () {
    ts_vals = calculate_totals_for_tickets_sold();
  });

  $("table#ticket_sales_fields").find("input.ticket_sales_price_per_ticket_l").keyup( function () {
    ts_vals = calculate_totals_for_tickets_sold();
  });

  $("table#ticket_sales_fields").find("input.ticket_sales_price_per_ticket_d").keyup( function () {
    ts_vals = calculate_totals_for_tickets_sold();
  });

  $("table#ticket_sales_fields").find("input#total_receipts_recorded_l").keyup( function () {
    compare_to_calculated_totals(rt_vals.l, rt_vals.s, rt_vals.d, 'total_receipts_calculated_rt');
    compare_to_calculated_totals(ts_vals.l, ts_vals.s, ts_vals.d, 'total_receipts_calculated_ts');
  });

  $("table#ticket_sales_fields").find("input#total_receipts_recorded_s").keyup( function () {
    compare_to_calculated_totals(rt_vals.l, rt_vals.s, rt_vals.d, 'total_receipts_calculated_rt');
    compare_to_calculated_totals(ts_vals.l, ts_vals.s, ts_vals.d, 'total_receipts_calculated_ts');
  });

  $("table#ticket_sales_fields").find("input#total_receipts_recorded_d").keyup( function () {
    compare_to_calculated_totals(rt_vals.l, rt_vals.s, rt_vals.d, 'total_receipts_calculated_rt');
    compare_to_calculated_totals(ts_vals.l, ts_vals.s, ts_vals.d, 'total_receipts_calculated_ts');
  });
});
