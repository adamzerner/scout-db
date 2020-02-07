$(document).on('turbolinks:load', function () {
  let $addPlayerButton = $('.add-player-container button');
  let $addPlayerSelect = $('.add-player-container select');
  let $players = $('.list-group');
  let $hiddenPlayerInputs = $('.hidden-player-inputs');
  let playerToAdd = { id: null, fullName: null };

  $addPlayerButton.on('click', function () {
    setPlayerToAdd(playerToAdd, $addPlayerSelect);
    addPlayer(playerToAdd, $players, $hiddenPlayerInputs);
  });
  $players.on('click', function (e) {
    if ($(e.target).attr('class') === 'close') {
      removePlayer($(e.target));
    }
  });

  function setPlayerToAdd(playerToAdd, $addPlayerSelect) {
    playerToAdd.id = $addPlayerSelect.val();
    playerToAdd.fullName = $addPlayerSelect.find('option:selected').text();
  }

  function addPlayer(playerToAdd, $players, $hiddenPlayerInputs) {
    $players.append(`
      <li class="list-group-item" data-id="${playerToAdd.id}">
        ${playerToAdd.fullName}
        <span class="close">&times;</span>
      </li>
    `);
    $hiddenPlayerInputs.append(`
      <input type="hidden" value="${playerToAdd.id}" name="player_list[player_ids][]" />
    `);
    disablePlayerOption(playerToAdd.id);
    $addPlayerSelect.val('');
  }

  function removePlayer($target) {
    let $li = $target.closest('li');
    let id = $li.data('id');

    enablePlayerOption(id);
    removeFromHiddenPlayerInputs(id);
    $li.remove();
  }

  function removeFromHiddenPlayerInputs(id) {
    $('.hidden-player-inputs input[type=hidden]').each(function (i, input) {
      if ($(input).val() === id.toString()) {
        $(input).remove();
      }
    });
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
