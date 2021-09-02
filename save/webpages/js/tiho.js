
$(document).ready(function() {

  if (
    $("input[name='genre']").val() == 'dissertation'   ||
    $("input[name='genre']").val() == 'habilitation'   ||
    $("input[name='genre']").val() == 'diploma_thesis' ||
    $("input[name='genre']").val() == 'master_thesis'
  ) {
    if ($("input[name='/mycoreobject/metadata/def.modsContainer/modsContainer/mods:mods/mods:originInfo/mods:place/mods:placeTerm']").val()  == '') {
      $("input[name='/mycoreobject/metadata/def.modsContainer/modsContainer/mods:mods/mods:originInfo/mods:place/mods:placeTerm']").val('Hannover');
    };
    if ($("input[name='/mycoreobject/metadata/def.modsContainer/modsContainer/mods:mods/mods:originInfo/mods:publisher']").val()  == '') {
      $("input[name='/mycoreobject/metadata/def.modsContainer/modsContainer/mods:mods/mods:originInfo/mods:publisher']").val('Tierärztliche Hochschule Hannover');
    };
    if ($("select[name='/mycoreobject/metadata/def.modsContainer/modsContainer/mods:mods/mods:classification/@valueURIxEditor']").val()  == '') {
      $("select[name='/mycoreobject/metadata/def.modsContainer/modsContainer/mods:mods/mods:classification/@valueURIxEditor']").val('bibliography');
    };
  }

  // spam protection for mails
  $('span.madress').each(function(i) {
      var text = $(this).text();
      var address = text.replace(" [at] ", "@");
      $(this).after('<a href="mailto:'+address+'">'+ address +'</a>')
      $(this).remove();
  });

  // split genre value on '-' and put last part in host parameter
  $('#tiho-presubmit').on("click", function(e){
    e.stopPropagation();
    e.preventDefault();
    if ($('#genre_host').val().includes('-')) {
        var arrayValues = $('#genre_host').val().split('-');
        $('#genre').val(arrayValues[0]);
        $('#host').val(arrayValues[1]);
    } else {
        $('#genre').val($('#genre_host').val());
    }
    $('#genre_host').val('');
    $('#submit_publication').submit();
  });

  // replace placeholder USERNAME with username
  var userID = $("#currentUser strong").html();
  var newHref = 'https://elib.tiho-hannover.de/servlets/solr/select?q=state%3Asubmitted%20AND%20createdby:' + userID + '&fq=objectType:mods';
  $("a[href='https://elib.tiho-hannover.de/servlets/solr/select?q=state%3Asubmitted%20AND%20createdby:USERNAME']").attr('href', newHref);
  var newHrefTest = 'https://reposis-test.gbv.de/tiho/servlets/solr/select?q=state%3Asubmitted%20AND%20createdby:' + userID + '&fq=objectType:mods';
  $("a[href='https://reposis-test.gbv.de/tiho/servlets/solr/select?q=state%3Asubmitted%20AND%20createdby:USERNAME']").attr('href', newHrefTest);

});