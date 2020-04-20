
$(document).ready(function() {

  if ($("input[name='genre']").val()  == 'dissertation'||'habilitation'||'diploma_thesis'||'master_thesis') {
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

});