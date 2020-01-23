$(document).on('turbolinks:load', function () {
  let $searchBox = $('input[type=search]');
  let options = {
    getValue: 'name',
    url: function (query) {
      return `/search.json?query=${query}`;
    },
    categories: [{
      listLocation: 'players',
      header: 'Players',
    }, {
      listLocation: 'high_school_teams',
      header: 'High school teams',
    }, {
      listLocation: 'club_teams',
      header: 'Club teams',
    }, {
      listLocation: 'tournaments',
      header: 'Tournaments',
    }, {
      listLocation: 'fields',
      header: 'Fields',
    }],
    list: {
      onChooseEvent: function () {
        let url = $searchBox.getSelectedItemData().url;

        $searchBox.val('');
        Turbolinks.visit(url);
      },
    },
  };

  $searchBox.easyAutocomplete(options);
});
