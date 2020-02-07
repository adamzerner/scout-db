$(document).on('turbolinks:load', function () {
  let $addPlayerButton = $('.add-player-container button');
  let $addPlayerSelect = $('.add-player-container select');
  let $players = $('.list-group');
  let playerToAdd = { id: null, fullName: null };

  $addPlayerButton.on('click', function () {
    setPlayerToAdd(playerToAdd, $addPlayerSelect);
    addPlayer(playerToAdd, $players);
  });
  $players.on('click', function (e) {
    let $target = $(e.target);
    let $li;

    if ($target.attr('class') === 'close') {
      $li = $target.closest('li');
      enablePlayerOption($li.data('id'));
      $li.remove();
    }
  });

  function setPlayerToAdd(playerToAdd, $addPlayerSelect) {
    playerToAdd.id = $addPlayerSelect.val();
    playerToAdd.fullName = $addPlayerSelect.find('option:selected').text();
  }

  function addPlayer(playerToAdd, $players) {
    $players.append(`
      <li class="list-group-item" data-id="${playerToAdd.id}">
        ${playerToAdd.fullName}
        <span class="close">&times;</span>
      </li>
    `);
    disablePlayerOption(playerToAdd.id);
    $addPlayerSelect.val('');
  }

  function enablePlayerOption(id) {
    let $playerOption = getPlayerOption(id);

    $playerOption.prop('disabled', false);
  }

  function disablePlayerOption(id) {
    let $playerOption = getPlayerOption(id);

    $playerOption.prop('disabled', true);
  }

  function getPlayerOption(id) {
    return $addPlayerSelect.find(`option[value=${id}]`).prop('disabled', true);
  }
});
